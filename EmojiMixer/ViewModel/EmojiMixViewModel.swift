import UIKit

@objcMembers
final class EmojiMixViewModel: NSObject, Identifiable {
    let id: String
    dynamic private(set) var emojis: String
    dynamic private(set) var backgroundColor: UIColor
    
    init(id: String, emojis: String, backgroundColor: UIColor) {
        self.id = id
        self.emojis = emojis
        self.backgroundColor = backgroundColor
        super.init()
    }
}
