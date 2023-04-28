import UIKit

class ViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let emodjis = [ "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]

    override func viewDidLoad() {
        super.viewDidLoad()
        cofigueView()
        configueConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }

    func cofigueView() {
        view.addSubview(collectionView)
    }

    func configueConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emodjis.count
    }
    //количество ячеек в секции
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiCollectionViewCell
        cell?.titleLabel.text = emodjis[indexPath.row]
        return cell!
    }
    //сама ячейка для заданной позиции IndexPath
}

extension ViewController: UICollectionViewDelegateFlowLayout { // 1 Для управления расположением и размерами элементов (включая размеры хедера) нужно реализовать методы из протокола
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // 1 Мы добавляем реализацию метода
        return CGSize(width: collectionView.bounds.width / 2, height: 50)   // 2 Берём ширину коллекции и делим на два, чтобы на каждой строке помещалось ровно по две ячейки. Высоту выставляем
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


