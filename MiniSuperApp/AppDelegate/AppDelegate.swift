import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerProviderFactories()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let appComponent = AppComponent()
        let viewController = appComponent.appRootBuildable.build(listener: nil)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        return true
    }
    
}
