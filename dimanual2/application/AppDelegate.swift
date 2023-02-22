import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            print("Your code here")
            return true
        }
    
    func application(_ application: UIApplication,
       configurationForConnecting connectingSceneSession: UISceneSession,
       options: UIScene.ConnectionOptions
     ) -> UISceneConfiguration {
       let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
       sceneConfig.delegateClass = SceneDelegate.self // 👈🏻
       return sceneConfig
     }
}
