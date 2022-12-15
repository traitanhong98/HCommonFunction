//
//  Created by HoangNM
//

import UIKit

open class UILabelBuilder: AnyUIViewBuilder {
    public var view: UILabel!
    
    public init () {
        view = ViewType()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func setTextColor(_ color: UIColor?) -> Self {
        view.textColor = color
        return self
    }
    
    open func setFont(_ font: UIFont?) -> Self {
        view.font = font
        return self
    }
    
    open func setNumberOfLines(_ numberOfLines: Int) -> Self {
        view.numberOfLines = numberOfLines
        return self
    }
    
    open func setText(_ text: String?) -> Self {
        view.text = text
        return self
    }
    
    open func setTextAlignment(_ alignment: NSTextAlignment) -> Self {
        view.textAlignment = alignment
        return self
    }
}
