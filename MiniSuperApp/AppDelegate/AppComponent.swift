import Foundation
import CleanSwiftUtil

final class AppComponent: CleanSwiftComponent<EmptyDependency>, AppRootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }

}
