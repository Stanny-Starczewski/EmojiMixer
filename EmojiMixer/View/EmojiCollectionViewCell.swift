import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel = UILabel()
    private let colors = Colors()
    
     var viewModel: EmojiMixViewModel? {
         didSet {
             titleLabel.text = viewModel?.emojis
             contentView.backgroundColor = viewModel?.backgroundColor
         }
     }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(_ viewModel: EmojiMixViewModel) {
        self.viewModel = viewModel
        setTitleLabel(text: viewModel.emojis)
        setBackgroundColor(viewModel.backgroundColor)
        bind()
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.$emojis.bind { [weak self] newValue in
            self?.setTitleLabel(text: newValue)
        }
        viewModel.$backgroundColor.bind { [weak self] newValue in
            self?.setBackgroundColor(newValue)
        }
    }
    
    private func setTitleLabel(text: String?) {
        titleLabel.text = text
    }
    
    private func setBackgroundColor(_ backgroundColor: UIColor?) {
        contentView.backgroundColor = colors.tintEmojiBackgroundColor(backgroundColor!)
    }
}
