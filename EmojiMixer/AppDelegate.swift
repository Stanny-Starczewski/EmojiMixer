import UIKit
import CoreData
import YandexMobileMetrica

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                preconditionFailure("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "32613d0b-8457-48e3-b9bd-35ec1e29cef3") else { // используйте ваш ключ
                return true
            }
                
            YMMYandexMetrica.activate(with: configuration)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(          // 1
            name: nil,
            sessionRole: connectingSceneSession.role
        )
        sceneConfiguration.storyboard = nil
        sceneConfiguration.sceneClass = UIWindowScene.self
        sceneConfiguration.delegateClass = SceneDelegate.self   // 2
        return sceneConfiguration
    }
}

