import UIKit

@objcMembers
final class EmojiMixViewModel: NSObject {
    
    dynamic private(set) var emojis: String
    dynamic private(set) var backgroundColor: UIColor
    
    init(emojis: String, backgroundColor: UIColor) {
        self.emojis = emojis
        self.backgroundColor = backgroundColor
    }
}
