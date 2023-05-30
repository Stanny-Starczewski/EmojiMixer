import UIKit

struct EmojiMixViewModel: Identifiable {
    let id: String
//    let emojis: String
//    let backgroundColor: UIColor
    
    var onChange: (() -> Void)?
    
    private(set) var emojis: String {
        didSet {
            onChange?()
        }
    }
    
    private(set) var backgroundColor: UIColor {
        didSet {
            onChange?()
        }
    }
}
