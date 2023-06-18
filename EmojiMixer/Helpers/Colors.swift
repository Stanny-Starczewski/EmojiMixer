import UIKit

final class Colors {
    var collectionViewBackgroundColor: UIColor = .systemBackground

    var navigationBarTintColor: UIColor = UIColor { (traits) -> UIColor in
        let isDarkMode = traits.userInterfaceStyle == .dark
        return isDarkMode ? UIColor.white : UIColor.systemBlue
    }

    func tintEmojiBackgroundColor(_ color: UIColor) -> UIColor {
        return UIColor { (traits) -> UIColor in
            let isDarkMode = traits.userInterfaceStyle == .dark
            return isDarkMode ? color.darker(by: 0.4) : color
        }
    }
}

extension UIColor {
    fileprivate func lighter(by percentage: CGFloat = 0.3) -> UIColor {
        return self.adjust(by: abs(percentage)) ?? UIColor.white
    }

    fileprivate func darker(by percentage: CGFloat = 0.3) -> UIColor {
        return self.adjust(by: -1 * abs(percentage)) ?? UIColor.black
    }

    fileprivate func adjust(by percentage: CGFloat = 0.3) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(
                red: min(red + percentage, 1.0),
                green: min(green + percentage, 1.0),
                blue: min(blue + percentage, 1.0),
                alpha: alpha
            )
        } else {
            return nil
        }
    }
}

