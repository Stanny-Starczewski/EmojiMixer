import UIKit

final class EmojiMixesViewModel {
    var onChange: (() -> Void)?
     private(set) var emojiMixes: [EmojiMixViewModel] = [] {
         didSet {
             onChange?() // сообщаем через замыкание, что ViewModel изменилась
         }
     }
    
    private let emojiMixFactory: EmojiMixFactory
    private let emojiMixStore: EmojiMixStore

    convenience init() {
        let emojiMixStore = try! EmojiMixStore(
            context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        )
        self.init(emojiMixFactory: EmojiMixFactory(), emojiMixStore: emojiMixStore)
    }
    
    init(emojiMixFactory: EmojiMixFactory, emojiMixStore: EmojiMixStore) {
        self.emojiMixFactory = emojiMixFactory
        self.emojiMixStore = emojiMixStore
//        super.init()
        emojiMixStore.delegate = self
        emojiMixes = getEmojiMixesFromStore()
    }
    
    func addEmojiMixTapped() {
        let newEmojiMix = emojiMixFactory.makeNewMix()
        try! emojiMixStore.addNewEmojiMix(newEmojiMix.emojies, color: newEmojiMix.backgroundColor)
    }
    
    func deleteAll() {
        try! emojiMixStore.deleteAll()
    }
    
    private func getEmojiMixesFromStore() -> [EmojiMixViewModel] {
        return emojiMixStore.emojiMixes.map {
            EmojiMixViewModel(
                id: $0.objectID.uriRepresentation().absoluteString,
                emojis: $0.emojies ?? "",
                backgroundColor: UIColorMarshalling.deserialize(hexString: $0.colorHex ?? "") ?? .white)
        }
    }
}
// MARK: - EmojiMixStoreDelegate

extension EmojiMixesViewModel: EmojiMixStoreDelegate {
    func didUpdateContent(_ store: EmojiMixStore) {
        emojiMixes = getEmojiMixesFromStore()
    }
}
