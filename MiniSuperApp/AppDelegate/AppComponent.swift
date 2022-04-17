import Foundation
import CleanSwiftUtil

final class AppComponent: CleanSwiftComponent<CleanSwiftEmptyDependency>, AppRootDependency {

    init() {
        super.init(dependency: CleanSwiftEmptyComponent())
    }

}
