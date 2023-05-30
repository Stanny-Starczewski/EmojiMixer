import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel = UILabel()
    
     var viewModel: EmojiMixViewModel? {
         didSet {
             titleLabel.text = viewModel?.emojis
             contentView.backgroundColor = viewModel?.backgroundColor
         }
     }
    
//    private var emojiesBinding: NSObject?
//    private var backgroundColorBinding: NSObject?
    
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
    
//    override func prepareForReuse() {
//        emojiesBinding = nil
//        backgroundColorBinding = nil
//    }
    
    func initialize(_ viewModel: EmojiMixViewModel) {
        self.viewModel = viewModel
        setTitleLabel(text: viewModel.emojis)
        setBackgroundColor(viewModel.backgroundColor)
        bind()
    }
    
    private func bind() {
        guard var viewModel = viewModel else { return }
        
//        emojiesBinding = viewModel.observe(\.emojis,
//                                            options: [.new],
//                                            changeHandler: { [weak self] _, change in
//            guard let newValue = change.newValue else { return }
//            self?.setTitleLabel(text: newValue)
//        })
//
//        backgroundColorBinding = viewModel.observe(\.backgroundColor,
//                                                    options: [.new],
//                                                    changeHandler: { [weak self] _, change in
//            guard let newValue = change.newValue else { return }
//            self?.setBackgroundColor(newValue)
//        })
        viewModel.onChange = { [weak self] in
            self?.setTitleLabel(text: viewModel.emojis)
            self?.setBackgroundColor(viewModel.backgroundColor)
        }
    }
    
    private func setTitleLabel(text: String?) {
        titleLabel.text = text
    }
    
    private func setBackgroundColor(_ backgroundColor: UIColor?) {
        contentView.backgroundColor = backgroundColor
    }
}
