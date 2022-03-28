import UIKit
import ModernRIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?
    private var urlHandler: URLHandler?
    
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

protocol URLHandler: AnyObject {
    func handle(_ url: URL)
}
