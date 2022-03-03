//
//  TopupInterface.swift
//  
//
//  Created by GOOK HEE JUNG on 2022/03/03.
//

import UIKit
import ModernRIBs

public protocol TopupListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToTopupClosed()
    func listenToTopupFinished()
}

public protocol TopupBuildable: Buildable {
    func build(
        withListener listener: TopupListener,
        topupBaseViewController: TopupBaseViewControllable
    ) -> Routing
}

public protocol TopupBaseViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    var presentationDelegate: UIAdaptivePresentationControllerDelegate { get }
}
