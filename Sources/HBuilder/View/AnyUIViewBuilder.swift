//
//  Created by HoangNM
//

import UIKit

public protocol AnyUIViewBuilder {
    associatedtype ViewType: UIView
    var view: ViewType! { get set}
    func build() -> ViewType
}

extension AnyUIViewBuilder {
    public func setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        view.setContentHuggingPriority(priority, for: axis)
        return self
    }
    
    public func setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        view.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
    
    public func setBackgroundColor(_ color: UIColor?) -> Self {
        view.backgroundColor = color
        return self
    }
    
    public func setCornerRadius(_ cornerRadius: CGFloat) -> Self {
        view.layer.cornerRadius = cornerRadius
        return self
    }
    
    public func clipToBounds(_ isClipToBounds: Bool = true) -> Self {
        view.clipsToBounds = isClipToBounds
        return self
    }
    
    public func setHidden(_ isHidden: Bool = true) -> Self {
        view.isHidden = isHidden
        return self
    }
    
    public func build() -> ViewType {
        return view
    }
}

open class UIViewBuilder<ViewType: UIView>: AnyUIViewBuilder {
    public var view: ViewType!
    
    public init() {
        view = ViewType()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
