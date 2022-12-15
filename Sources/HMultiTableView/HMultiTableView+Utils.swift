//
//  Created by HoangNM
//

import UIKit

@objc public protocol HMultiTableViewDataSource: AnyObject {
    func numberOfColumn(inTableView tableView: HMultiTableView) -> Int
    @objc optional func numberOfSection(inTableView tableView: HMultiTableView) -> Int
    func multiTableView(_ multiTableView: HMultiTableView, numberOfRowAt column: Int) -> Int
    func multiTableView(_ multiTableView: HMultiTableView, cellForRowAt indexPath: IndexPath, withColumn column: Int) -> UITableViewCell
}

@objc public protocol HMultiTableViewDelegate: AnyObject {
    func multiTableView(_ tableView: HMultiTableView, widthForColumn column: Int) -> CGFloat
    func multiTableView(widthOfContent width: CGFloat, forColumn column: Int) -> CGFloat

    // MARK: - Big header
    @objc optional func multiTableView(_ tableView: HMultiTableView, heightForHeaderAt column: Int) -> CGFloat
    @objc optional func multiTableView(_ tableView: HMultiTableView, viewForHeaderAt column: Int) -> UIView
    
    // MARK: - SectionHeader
    @objc optional func multiTableView(_ tableView: HMultiTableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func multiTableView(_ tableView: HMultiTableView, viewForHeaderInSection section: Int, withColumn column: Int) -> UIView
    
    // MARK: - SectionFooter
    @objc optional func multiTableView(_ tableView: HMultiTableView, heightForFooterInSection section: Int) -> CGFloat
    @objc optional func multiTableView(_ tableView: HMultiTableView, viewForFooterInSection section: Int, withColumn column: Int) -> UIView
    
    // MARK: - For Row
    @objc optional func multiTableView(_ tableView: HMultiTableView, heighForRowAt indexPath: IndexPath) -> CGFloat
    @objc optional func multiTableView(_ tableView: HMultiTableView, didSelectRowAt indexPath: IndexPath, withColumn column: Int)
    
    // MARK: - For scroll
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView, contentOffset: CGPoint)
    @objc optional func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidEndScrolling(_ scrollView: UIScrollView)
    
    // MARK: - Load More
    @objc optional func multiTableViewPerformLoadMore(at tableView: HMultiTableView)
    
    // MARK: - Frame
    /// Additional action after tableview did reframe base view
    @objc optional func tableViewDidReframeBaseView(_ tableView: HMultiTableView)
}
