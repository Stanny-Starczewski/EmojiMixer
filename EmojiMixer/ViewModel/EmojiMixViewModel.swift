import UIKit

struct EmojiMixViewModel: Identifiable {
    let id: String
    
    @Observable
    private(set) var emojis: String
    
    @Observable
    private(set) var backgroundColor: UIColor
}
