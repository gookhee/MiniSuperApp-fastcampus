import NeedleFoundation

final class AppComponent: BootstrapComponent {
    var appRootModuleBuilder: AppRootModuleBuildable {
        AppRootModuleComponent(parent: self)
    }
}
