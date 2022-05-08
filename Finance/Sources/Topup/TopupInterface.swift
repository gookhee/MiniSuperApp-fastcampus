//
//  TopupInterface.swift
//  
//
//  Created by 정국희 on 2022/02/16.
//

import Foundation
import UIKit

import CleanSwiftUtil

// MARK: - TopupBuildingLogic definition

public protocol TopupBuildingLogic {
    typealias Destination = ViewlessInteracting
    
    func build(
        withListener listener: TopupListener,
        topupBaseViewController: TopupBaseViewControllable
    ) -> Destination
}

public protocol TopupListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToTopupClosed()
    func listenToTopupFinished()
}

public protocol TopupBaseViewControllable: UIViewController {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    var presentationDelegate: UIAdaptivePresentationControllerDelegate { get }
}
