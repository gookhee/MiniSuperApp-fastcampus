import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let viewController = AppRootBuilder(dependency: AppComponent())
            .build(listener: nil)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        return true
    }
    
}
