//
//  Created by HoangNM
//

import UIKit

open class HBaseViewController: UIViewController {
    /// To check if controller is displaying on screen or not
    public var isControllerVisible: Bool {
        self.viewIfLoaded?.window != nil
    }
    /// Use for check the fist time screen was shown and trigger some one-time event
    private var isFirstTimeShowing: Bool = true
    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstTimeShowing {
            isFirstTimeShowing.toggle()
            firstTimeShowing()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Funcs

    @objc open func backAction() {
        navigationController?.popViewController(animated: true)
    }

    /// This func will trigger once after controller was showed at the first time
    /// Override it to request data if needed
    open func firstTimeShowing() {
        
    }
}

open class HBaseContentContainerController<ContentView: UIView>: HBaseViewController {
    public var contentView: ContentView!
    
    open override func loadView() {
        contentView = ContentView()
        view = contentView
    }
}

open class HBaseScreenViewController<ContentView: HBaseContentView>: HBaseContentContainerController<ContentView> {
    open override func viewDidLoad() {
        super.viewDidLoad()
        if let backButton = contentView.backButton {
            backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        }
    }
}
