import UIKit

class ViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let emojies = [ "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
    
    private var visibleEmojies = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        cofigueView()
        configueConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func setupNavigationController() {
             let leftButton = UIBarButtonItem(barButtonSystemItem: .undo,
                                              target: self,
                                              action: #selector(removeLastEmoji))
             let rightButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addNextEmoji))
             navigationItem.rightBarButtonItem = rightButton
             navigationItem.leftBarButtonItem = leftButton
         }

    @objc private func addNextEmoji() {
        guard visibleEmojies.count < emojies.count else { return }
        let index = visibleEmojies.count
        let indexPath = IndexPath(row: index, section: 0)
        let emoji = emojies[index]
        visibleEmojies.append(emoji)
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [indexPath])
        }
    }
    
    @objc private func removeLastEmoji() {
        guard visibleEmojies.count > 0 else { return }
        let index = visibleEmojies.count - 1
        let indexPath = IndexPath(row: index, section: 0)
        visibleEmojies.remove(at: index)
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [indexPath])
        }
    }

         

    func cofigueView() {
        view.addSubview(collectionView)
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
        cell?.titleLabel.text = visibleEmojies[indexPath.row]
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
        return CGSize(width: collectionView.bounds.width / 2, height: 50)   // 2 Берём ширину коллекции и делим на два, чтобы на каждой строке помещалось ровно по две ячейки. Высоту выставляем
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


