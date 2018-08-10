//
//  NPBaseTV.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 10..
//

import UIKit

public class NPBaseTV: UITableView {
    var arrayAllData: [[String : AnyObject]]?
    var refreshBlock: ((Int) -> Void)?
    var moreBlock: ((Int) -> Void)?
    var refreshControlCustom: UIRefreshControl?
    var pageNo = 0
    var pageSize = 20
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        pageNo = 1
    }
    
    public func setPageSize(_ ps: NSInteger) {
        pageSize = ps
    }
    
    public func setRefreshList(_ refreshBlock: @escaping (_ pageNo: Int) -> Void) {
        self.refreshBlock = refreshBlock
        refreshControlCustom = UIRefreshControl()
        refreshControlCustom?.addTarget(self, action: #selector(NPBaseCV.refreshList), for: .valueChanged)
        if #available(iOS 10.0, *) {
            refreshControl = refreshControlCustom
        } else {
            if let aCustom = refreshControlCustom {
                addSubview(aCustom)
            }
        }
    }
    
    public func setMoreList(_ moreBlock: @escaping (_ pageNo: Int) -> Void) {
        self.moreBlock = moreBlock
    }
    
    override public func reloadData() {
        super.reloadData()
        if refreshControlCustom != nil && ((refreshControlCustom?.isRefreshing)! || !(refreshControlCustom?.isHidden ?? false)) {
            refreshControlCustom?.isHidden = true
            refreshControlCustom?.endRefreshing()
        }
    }
    
    @objc func refreshList() {
        if !(refreshBlock != nil) {
            return
        }
        if refreshControlCustom != nil {
            refreshControlCustom?.isHidden = false
            refreshControlCustom?.beginRefreshing()
        }
        pageNo = 1
        refreshBlock!(pageNo)
    }
}

extension NPBaseTV : UITableViewDelegate {
    
}

extension NPBaseTV : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard arrayAllData != nil else {
            return 0
        }
        return arrayAllData!.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension NPBaseTV : UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard arrayAllData != nil else {
            return
        }
        if arrayAllData!.count < pageSize || arrayAllData!.count % pageSize != 0 || !(moreBlock != nil) {
            return
        }
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self.pageNo += 1
                self.moreBlock!(self.pageNo)
            })
        }
    }
}
