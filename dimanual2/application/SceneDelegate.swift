import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  typealias Provider = ProfileContentProvider<PreferencesStore>

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let container = DIContainer.shared
    container.register(type: PrivacyLevel.self, component: PrivacyLevel.friend)
    container.register(type: User.self, component: Mock.user())
    container.register(type: PreferencesStore.self, component: PreferencesStore())
    container.register(type: Provider.self, component: Provider())
    let profileView = ProfileView<Provider>()
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: profileView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}
