//
//  Created by HoangNM
//

import UIKit


open class UIButtonBuilder: AnyUIViewBuilder {
    public var view: UIButton!
    
    public init() {
        view = ViewType()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func setTitle(_ title: String, for state: UIControl.State = .normal) -> Self {
        view.setTitle(title, for: state)
        return self
    }
    
    open func setImage(_ image: UIImage?, for state: UIControl.State = .normal) -> Self {
        view.setImage(image, for: state)
        return self
    }
    
    open func setTitleColor(_ color: UIColor?, for state: UIControl.State = .normal) -> Self {
        view.setTitleColor(color, for: state)
        return self
    }
    
    open func setCornerRadius(_ cornerRadius: CGFloat) -> Self {
        view.layer.cornerRadius = cornerRadius
        return self
    }
    
    open func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Self {
        view.addTarget(target, action: action, for: controlEvents)
        return self
    }
}
