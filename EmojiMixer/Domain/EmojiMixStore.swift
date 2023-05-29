import UIKit
import CoreData

enum EmojiMixStoreError: Error {
    case decodingErrorInvalidEmojies
    case decodingErrorInvalidColorHex
}

protocol EmojiMixStoreDelegate: AnyObject {
    func didUpdateContent(_ store: EmojiMixStore)
}

final class EmojiMixStore: NSObject {
    
    private let context: NSManagedObjectContext
    private var fetchedResultsController: NSFetchedResultsController<EmojiMixCoreData>!
    weak var delegate: EmojiMixStoreDelegate?

    init(context: NSManagedObjectContext) throws {
        self.context = context
        super.init()
        
        let fetchRequest = EmojiMixCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \EmojiMixCoreData.emojies, ascending: true)
        ]
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        self.fetchedResultsController = controller
        try controller.performFetch()
    }
    
    var emojiMixes: [EmojiMixCoreData] {
        return self.fetchedResultsController.fetchedObjects ?? []
    }

    func addNewEmojiMix(_ emojies: String, color: UIColor) throws {
        let emojiMixCoreData = EmojiMixCoreData(context: context)
        emojiMixCoreData.emojies = emojies
        emojiMixCoreData.colorHex = UIColorMarshalling.serialize(color: color)
        try context.save()
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
}
// MARK: - NSFetchedResultsControllerDelegate
extension EmojiMixStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdateContent(self)
    }
}


