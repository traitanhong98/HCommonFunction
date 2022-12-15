//
//  Created by HoangNM
//

import UIKit

extension UIView {
    public var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    
    public var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
        
    public class var nibNameClass: String? {
        return "\(self)".components(separatedBy: ".").first
    }

    public class var nib: UINib? {
        guard Bundle.main.path(forResource: nibNameClass, ofType: "nib") != nil else { return nil }
        
        return UINib(nibName: nibNameClass ?? "", bundle: nil)
    }

    public class func nib(bundle: Bundle = Bundle.main) -> UINib? {
        guard bundle.path(forResource: nibNameClass, ofType: "nib") != nil else { return nil }

        return UINib(nibName: nibNameClass ?? "", bundle: bundle)
    }
    
    public class func fromNib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type, inBundle: Bundle = Bundle.main) -> T? {
        let nibName = (nibNameOrNil ?? nibNameClass) ?? ""
        guard inBundle.path(forResource: nibName, ofType: "nib") != nil else { return nil }

        guard let nibViews = inBundle.loadNibNamed(nibName, owner: nil, options: nil), nibViews.count > 0 else { return nil }

        for view in nibViews where view is T {
            return view as? T
        }
        return nil
    }
    
    @discardableResult
    public func loadViewFromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        constraintAll(to: contentView)
        return contentView
    }
    
    public func constraintAll(to view: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
