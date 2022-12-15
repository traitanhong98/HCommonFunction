//
//  Created by HoangNM
//

import UIKit

open class UITableViewBuilder: AnyUIViewBuilder {
    public var view: UITableView!
    
    public init () {
        view = ViewType()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func setDefault() -> Self {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.keyboardDismissMode = .onDrag
        view.autoresizesSubviews = true
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.contentInset = .zero
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return self
    }
}
