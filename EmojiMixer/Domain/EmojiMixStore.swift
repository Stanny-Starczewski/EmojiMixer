import UIKit
import CoreData

enum EmojiMixStoreError: Error {
    case decodingErrorInvalidEmojies
    case decodingErrorInvalidColorHex
}

final class EmojiMixStore: NSObject {
    
    private let context: NSManagedObjectContext

    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.init(context: context)
    }

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {
        let emojiMixCoreData = EmojiMixCoreData(context: context)
        updateExistingEmojiMix(emojiMixCoreData, with: emojiMix)
        try context.save()
    }

    func updateExistingEmojiMix(_ emojiMixCorData: EmojiMixCoreData, with mix: EmojiMix) {
        emojiMixCorData.emojies = mix.emojies
        emojiMixCorData.colorHex = UIColorMarshalling.serialize(color: mix.backgroundColor)
    }
    
    func emojiMix(from emojiMixCorData: EmojiMixCoreData) throws -> EmojiMix {
        guard let emojies = emojiMixCorData.emojies else {
            throw EmojiMixStoreError.decodingErrorInvalidEmojies
        }
        guard let colorHex = emojiMixCorData.colorHex else {
            throw EmojiMixStoreError.decodingErrorInvalidEmojies
        }
        return EmojiMix(
            emojies: emojies,
            backgroundColor: UIColorMarshalling.deserialize(hexString: colorHex)!
        )
    }

    func fetchEmojiMixes() throws -> [EmojiMix] {
        let fetchRequest = EmojiMixCoreData.fetchRequest()
        let emojiMixesFromCoreData = try context.fetch(fetchRequest)
        return try emojiMixesFromCoreData.map { try self.emojiMix(from: $0) }
    }
}

