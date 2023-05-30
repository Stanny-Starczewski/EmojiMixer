import UIKit

class EmojiMixesViewController: UIViewController {
    
    private var viewModel: EmojiMixesViewModel?
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        cofigueView()
        configueConstraints()
        viewModel = EmojiMixesViewModel()
        viewModel?.$emojiMixes.bind { [weak self] _ in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func setupNavigationController() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add,
                                          target: self,
                                          action: #selector(addNewEmojiMix))
        navigationItem.rightBarButtonItem = rightButton
        let leftButton = UIBarButtonItem(title: NSLocalizedString("Delete All", comment: ""),
                                         style: .plain,
                                         target: self,
                                         action: #selector(deleteAll))
        navigationItem.leftBarButtonItem = leftButton
    }

    @objc
    private func addNewEmojiMix() {
        viewModel?.addEmojiMixTapped()
        }
    
    @objc
    private func deleteAll() {
        viewModel?.deleteAll()
    }
    }

extension EmojiMixesViewController {
    func cofigueView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func configueConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
}
// MARK: - Extensions

extension EmojiMixesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.emojiMixes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiCollectionViewCell,
        let viewModel = viewModel else { return UICollectionViewCell() }
        cell.initialize(viewModel.emojiMixes[indexPath.item])
        return cell
    }
}

extension EmojiMixesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension EmojiMixesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset
        let availableWidth = collectionView.bounds.width - insets.left - insets.right
        let minSpacing = 10.0
        let itemsPerRow = 2.0
        let itemWidth = (availableWidth - (itemsPerRow - 1) * minSpacing)  / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}


