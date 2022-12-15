//
//  Created by HoangNM
//

import UIKit

extension HMultiTableView {
    // MARK: - Category Instances methods
    /// Get vertical TableView for specific Column
    public func tableForColumn(_ column: Int) -> UITableView? {
        return viewWithTag(keyScrollViewTag + column)?.viewWithTag(keyTableViewTag + column) as? UITableView
    }
    /// Get hozirontal Scroll view for specific Column
    public func scrollViewForColumn(_ column: Int) -> UIScrollView? {
        return viewWithTag(keyScrollViewTag + column) as? UIScrollView
    }
    
    // MARK: - InstanceMethod
    public func reuseHeaderForColumn(_ column: Int) -> UIView? {
        let scrollview = viewWithTag(keyScrollViewTag + column)
        return scrollview?.viewWithTag(keyTableHeaderViewTag + column)
    }
    /// Get all cell that are displaying on screen
    public func getVisibleCells() -> [UITableViewCell] {
        var cells = [UITableViewCell]()
        for i in 0..<(dataSource?.numberOfColumn(inTableView: self) ?? 0) {
            cells += getVisibleCellsForColumn(i) ?? []
        }
        return cells
    }
    /// Get call cell that are displaying on specific column
    public func getVisibleCellsForColumn(_ column: Int) -> [UITableViewCell]? {
        return tableForColumn(column)?.visibleCells
    }
    /// ReloadData for every tableView
    public func reloadData() {
        if let numberOfColumn = dataSource?.numberOfColumn(inTableView: self) {
            for column in 0..<numberOfColumn {
                self.tableForColumn(column)?.reloadData()
            }
        }
    }
    
    public func scrollToRowAtIndexPath(_ indexPath: IndexPath, atScrollPosition position: UITableView.ScrollPosition, animated: Bool) {
        if let numberOfColumn = dataSource?.numberOfColumn(inTableView: self) {
            for column in 0..<numberOfColumn {
                self.tableForColumn(column)?.scrollToRow(at: indexPath, at: position, animated: animated)
            }
        }
    }
    // MARK: - Other method
    /// Method to release the loadMore process, call it to tell tableView re-enable loadMore
    public func endLoadMore() {
        isVerticalLoadingMore = false
    }
}
