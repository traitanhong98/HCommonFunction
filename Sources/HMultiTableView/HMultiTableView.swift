//
//  Created by HoangNM
//

import UIKit

public class HMultiTableView: UIView {
    let keyScrollViewTag: Int = 500
    
    var keyTableViewTag: Int {
        keyScrollViewTag + 500
    }
    
    var keyTableHeaderViewTag: Int {
        keyTableViewTag + 500
    }
    
    @IBOutlet open weak var dataSource: HMultiTableViewDataSource? {
        didSet {
            self.initBaseView()
        }
    }
    
    @IBOutlet open weak var delegate: HMultiTableViewDelegate? {
        didSet {
            self.reframeBaseView()
        }
    }
    
    public var showsHorizontalScrollIndicator: Bool = false {
        didSet {
            if let columnCount = dataSource?.numberOfColumn(inTableView: self) {
                (0..<columnCount).forEach { index in
                    if let scrollView = viewWithTag(keyScrollViewTag + index) as? UIScrollView {
                        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
                    }
                }
            }
        }
    }
    
    var isVerticalLoadingMore: Bool = false
    var verticalLoadMoreOffset: CGFloat = -50
    // MARK: - LifeCycle
    public init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        reframeBaseView()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        if dataSource != nil {
            self.initBaseView()
        }
        
        if delegate != nil {
            self.reframeBaseView()
        }
    }
    // MARK: - Func
    private func initBaseView() {
        guard let dataSource = dataSource else {
            return
        }
        subviews.forEach({$0.removeFromSuperview()})
        let numberOfColumn = dataSource.numberOfColumn(inTableView: self)
        for i in 0..<numberOfColumn {
            let scrollView = UIScrollView()
            scrollView.tag = keyScrollViewTag + i
            scrollView.backgroundColor = .clear
            scrollView.isDirectionalLockEnabled = true
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.contentSize = CGSize(width: 0, height: scrollView.contentSize.height)
            scrollView.bounces = false
            scrollView.delegate = self
            scrollView.indicatorStyle = .white
            // Table
            let tableView = UITableView()
            tableView.backgroundColor = .clear
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
            tableView.tag = keyTableViewTag + i
            tableView.delegate = self
            tableView.dataSource = self
            tableView.keyboardDismissMode = .onDrag
            tableView.autoresizesSubviews = true
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            tableView.tableFooterView = UIView(frame: .zero)
            scrollView.addSubview(tableView)
            
            self.addSubview(scrollView)
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0
            }
        }
    }
    
    public func reframeBaseView() {
        guard let delegate = delegate,
              let dataSource = dataSource else {
            return
        }
        let numberOfColumn = dataSource.numberOfColumn(inTableView: self)
        var offsetX: CGFloat = 0
        for column in 0..<numberOfColumn {
            if let scrollView = viewWithTag(keyScrollViewTag + column) as? UIScrollView {
                
                let widthForColumn = delegate.multiTableView(self, widthForColumn: column)
                let contentWidth = delegate.multiTableView(widthOfContent: widthForColumn, forColumn: column)
                let headerHeight = delegate.multiTableView?(self, heightForHeaderAt: column) ?? 0
                
                scrollView.frame = .init(x: offsetX,
                                         y: 0,
                                         width: widthForColumn,
                                         height: frame.height)
                scrollView.contentSize = .init(width: contentWidth, height: scrollView.frame.height)
                var headerView = viewWithTag(keyTableHeaderViewTag + column)
                if headerView == nil,
                   let newHeaderView = delegate.multiTableView?(self, viewForHeaderAt: column) {
                    newHeaderView.tag = keyTableHeaderViewTag + column
                    headerView = newHeaderView
                    scrollView.addSubview(newHeaderView)
                }
                
                if let headerView = headerView {
                    headerView.frame = .init(x: 0, y: 0, width: contentWidth, height: headerHeight)
                }
                
                if let tableView = viewWithTag(keyTableViewTag + column) {
                    tableView.frame = .init(x: 0, y: headerHeight, width: contentWidth, height: scrollView.frame.height - headerHeight)
                }
                offsetX += widthForColumn
            }
        }
        delegate.tableViewDidReframeBaseView?(self)
    }
    
    public func reloadBaseView() {
        initBaseView()
        reframeBaseView()
        reloadData()
    }
}
