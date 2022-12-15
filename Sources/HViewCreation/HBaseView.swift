//
//  Created by HoangNM on 14/12/2022.
//

import UIKit
import HExtension

public protocol HBaseContentView: UIView {
    var backButton: UIButton! { get set }
}

open class HBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setupView()
    }
    
    public init() {
        super.init(frame: .zero)
        loadViewFromNib()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        setupView()
    }
    
    open func setupView() {
 
    }
}
