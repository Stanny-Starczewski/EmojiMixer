import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let colors = Colors()

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let viewController = EmojiMixesViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = colors.navigationBarTintColor
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

