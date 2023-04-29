import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

