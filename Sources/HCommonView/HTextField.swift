//
//  Created by HoangNM
//

import UIKit
import HExtension

class HTextField: UITextField {

    enum WidthValue {
        case constant(value: CGFloat)
        case ratio(value: CGFloat)
        case none
    }
    // MARK: - RightView
    private var rightViewContainer: UIView?
    public var rightViewContentView: UIView?
    public var rightViewWidth: WidthValue = .none
    public var rightPadding: CGFloat = 0 { didSet { updatePaddingRight() } }
    // MARK: - LeftView
    private var leftViewContainer: UIView?
    public var leftViewContentView: UIView?
    public var leftViewWidth: WidthValue = .none
    public var leftPadding: CGFloat = 0 { didSet { updatePaddingLeft() } }
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let width: CGFloat =  {
            switch rightViewWidth {
            case .constant(let value):
                return value
            case .ratio(let value):
                return height * value
            case .none:
                return 0
            }
        }()
        let rightViewWidthValue = width + rightPadding
        let x = bounds.width - rightViewWidthValue
        let rightViewBounds = CGRect(x: x, y: 0, width: rightViewWidthValue, height: height)
        return rightViewBounds
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let width: CGFloat =  {
            switch leftViewWidth {
            case .constant(let value):
                return value
            case .ratio(let value):
                return height * value
            case .none:
                return 0
            }
        }()
        let leftViewWidthValue = width + leftPadding
        let x = bounds.width - leftViewWidthValue
        let rightViewBounds = CGRect(x: x, y: 0, width: leftViewWidthValue, height: height)
        return rightViewBounds
    }
    // MARK: - Funcs
    func updatePaddingRight() {
        if rightViewContainer == nil {
            rightViewContainer = UIView()
            rightView = rightViewContainer
        }
        updateRightViewFrameIfNeeded()
    }
    
    func updateRightViewFrameIfNeeded() {
        guard let rightViewContainer = rightViewContainer,
            let rightViewContentView = rightViewContentView else {
            return
        }
        
        rightViewContentView.constraints.forEach({
            rightViewContentView.removeConstraint($0)
        })
        
        NSLayoutConstraint.activate([
            rightViewContainer.leftAnchor.constraint(equalTo: rightViewContentView.leftAnchor, constant: -rightPadding),
            rightViewContainer.topAnchor.constraint(equalTo: rightViewContentView.topAnchor),
            rightViewContainer.rightAnchor.constraint(equalTo: rightViewContentView.rightAnchor),
            rightViewContainer.bottomAnchor.constraint(equalTo: rightViewContentView.bottomAnchor),
        ])
    }
    
    func updatePaddingLeft() {
        if rightViewContainer == nil {
            rightViewContainer = UIView()
            rightView = rightViewContainer
        }
        updateLeftViewFrameIfNeeded()
    }
    
    func updateLeftViewFrameIfNeeded() {
        guard let leftViewContainer = leftViewContainer,
            let leftViewContentView = leftViewContentView else {
            return
        }
        
        leftViewContentView.constraints.forEach({
            leftViewContentView.removeConstraint($0)
        })
        
        NSLayoutConstraint.activate([
            leftViewContainer.rightAnchor.constraint(equalTo: leftViewContentView.rightAnchor, constant: leftPadding),
            leftViewContainer.topAnchor.constraint(equalTo: leftViewContentView.topAnchor),
            leftViewContainer.leftAnchor.constraint(equalTo: leftViewContentView.leftAnchor),
            leftViewContainer.bottomAnchor.constraint(equalTo: leftViewContentView.bottomAnchor),
        ])
    }
    
    open func setRightView(_ view: UIView, rightViewMode: UITextField.ViewMode = .always) {
        let rightViewContainer = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // Set properties
        self.rightViewContentView = view
        self.rightViewContainer = rightViewContainer
        self.rightView = rightViewContainer
        self.rightViewMode = rightViewMode
        // UpdateFrame
        rightViewContainer.addSubview(view)
        updateRightViewFrameIfNeeded()
    }
    
    open func setLeftView(_ view: UIView, leftViewMode: UITextField.ViewMode = .always) {
        let leftViewContainer = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // Set properties
        self.leftViewContentView = view
        self.leftViewContainer = leftViewContainer
        self.rightView = leftViewContainer
        self.rightViewMode = leftViewMode
        // UpdateFrame
        leftViewContainer.addSubview(view)
        updateLeftViewFrameIfNeeded()
    }
}
