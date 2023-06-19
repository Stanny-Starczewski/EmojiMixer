import UIKit

final class EmojiMixesViewModel {
    @Observable
    private(set) var emojiMixes: [EmojiMixViewModel] = []
    
    private let emojiMixFactory: EmojiMixFactory
    private let emojiMixStore: EmojiMixStore
    private let analyticsService = AnalyticsService()

    convenience init() {
        let emojiMixStore = try! EmojiMixStore(
            context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        )
        self.init(emojiMixFactory: EmojiMixFactory(), emojiMixStore: emojiMixStore)
    }
    
    init(emojiMixFactory: EmojiMixFactory, emojiMixStore: EmojiMixStore) {
        self.emojiMixFactory = emojiMixFactory
        self.emojiMixStore = emojiMixStore
        emojiMixStore.delegate = self
        emojiMixes = getEmojiMixesFromStore()
    }
    
    func addEmojiMixTapped() {
        analyticsService.report(event: "mixes_add", params: ["mixes_count" : emojiMixes.count + 1])
        let newEmojiMix = emojiMixFactory.makeNewMix()
        try! emojiMixStore.addNewEmojiMix(newEmojiMix.emojies, color: newEmojiMix.backgroundColor)
    }
    
    func addFixedEmojiMix() {
        let newMix = emojiMixFactory.makeNewFixedMix()
        try! emojiMixStore.addNewEmojiMix(newMix.emojies, color: newMix.backgroundColor)
    }
    
    func deleteAll() {
        analyticsService.report(event: "mixes_delete_all", params: ["mixes_count" : emojiMixes.count])
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
