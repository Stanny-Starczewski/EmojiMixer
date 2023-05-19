import UIKit

class ViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var emojiMixFactory = EmojiMixFactory()
    lazy var emojiMixStore = EmojiMixStore()
    
    private var visibleEmojies: [EmojiMix] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        cofigueView()
        configueConstraints()
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func setupNavigationController() {
             let rightButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addNewEmojiMix))
             navigationItem.rightBarButtonItem = rightButton
         }

    @objc
    private func addNewEmojiMix() {
        let newMix = emojiMixFactory.makeNewMix()

        let newMixIndex = visibleEmojies.count
        visibleEmojies.append(newMix)
        
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: newMixIndex, section: 0)])
        }
    }

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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleEmojies.count
    }
    //количество ячеек в секции
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiCollectionViewCell
        let emojiMix = visibleEmojies[indexPath.row]
        cell?.titleLabel.text = emojiMix.emojies
        cell?.contentView.backgroundColor = emojiMix.backgroundColor
        return cell!
    }
    //сама ячейка для заданной позиции IndexPath
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout { // 1 Для управления расположением и размерами элементов (включая размеры хедера) нужно реализовать методы из протокола
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // 1 Мы добавляем реализацию метода
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


