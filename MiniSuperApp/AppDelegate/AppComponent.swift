import Foundation
import CleanSwiftUtil

final class AppComponent: Component<EmptyDependency>, AppRootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }

}
