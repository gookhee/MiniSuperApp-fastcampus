import UIKit

public protocol AdaptivePresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss()
}

public final class AdaptivePresentationControllerDelegateProxy: NSObject{

    public weak var delegate: AdaptivePresentationControllerDelegate?
}


extension AdaptivePresentationControllerDelegateProxy: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.presentationControllerDidDismiss()
    }
}
