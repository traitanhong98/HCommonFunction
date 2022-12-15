//
//  Created by HoangNM
//

import UIKit

// MARK: - UITableViewDataSource
extension HMultiTableView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSection?(inTableView: self) ?? 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let column = tableView.tag - keyTableViewTag
        return dataSource?.multiTableView(self, numberOfRowAt: column) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let column = tableView.tag - keyTableViewTag
        return dataSource?.multiTableView(self, cellForRowAt: indexPath, withColumn: column) ?? UITableViewCell()
    }
}
// MARK: - UITableViewDelegate
extension HMultiTableView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let column = tableView.tag - keyTableViewTag
        delegate?.multiTableView?(self, didSelectRowAt: indexPath, withColumn: column)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        delegate?.multiTableView?(self, heighForRowAt: indexPath) ?? UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        delegate?.multiTableView?(self, heightForHeaderInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let column = tableView.tag - keyTableViewTag
        return delegate?.multiTableView?(self, viewForHeaderInSection: section, withColumn: column)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        delegate?.multiTableView?(self, heightForFooterInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let column = tableView.tag - keyTableViewTag
        return delegate?.multiTableView?(self, viewForFooterInSection: section, withColumn: column)
    }
}

// MARK: - UIScrollViewDelegate
extension HMultiTableView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let dataSource = dataSource else {
            return
        }
        let contentOffset = scrollView.contentOffset
        let numberOfColumn = dataSource.numberOfColumn(inTableView: self)
        // Avoid offset from above Scroll view affect tableview
        for i in 0..<numberOfColumn {
            if scrollView == scrollViewForColumn(i) {
                delegate?.scrollViewDidScroll?(scrollView, contentOffset: contentOffset)
                return
            }
        }
        
        for i in 0..<numberOfColumn {
            if let tableView = tableForColumn(i) {
                tableView.contentOffset.y = contentOffset.y
            }
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let dataSource = dataSource {
            let numberOfColumn = dataSource.numberOfColumn(inTableView: self)
            for i in 0..<numberOfColumn {
                if let scrollView = tableForColumn(i) {
                    if !isVerticalLoadingMore {
                      
                        // UITableView only moves in one direction, y axis
                        let currentOffset = scrollView.contentOffset.y
                        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
                        
                        if scrollView.contentSize.height >= scrollView.frame.size.height, // Only when contentSize is higher than tableview
                           maximumOffset - currentOffset <= verticalLoadMoreOffset {
                            // To prevent loadmore repetedly, user must call endLoadMoreFunction to make loadMore available
                            isVerticalLoadingMore = true
                            delegate?.multiTableViewPerformLoadMore?(at: self)
                        }
                    }
                    break
                }
            }
        }
        
        if !decelerate {
            delegate?.scrollViewDidEndScrolling?(scrollView)
        }
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
        delegate?.scrollViewDidEndScrolling?(scrollView)
    }
}
