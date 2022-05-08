import NeedleFoundation

final class AppComponent: BootstrapComponent {
    var appRootBuildable: AppRootBuildingLogic {
        AppRootBuilder(parent: self)
    }
}
