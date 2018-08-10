//
//  NPBaseCV.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 10..
//

import UIKit

open class NPBaseCV: UICollectionView {
    var refreshBlock: ((Int) -> Void)?
    var moreBlock: ((Int) -> Void)?
    var didSelectBlock: ((NSInteger, [String : AnyObject]?) -> Void)?
    
    var arrayAllData: [[String : AnyObject]]?
    var refreshControlCustom: UIRefreshControl?
    var pageNo = 0
    var pageSize = 20

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        pageNo = 1
        
        if #available(iOS 10.0, tvOS 10.0, *) {
            self.prefetchDataSource = self
        }
    }
    
    public func setPageSize(_ ps: NSInteger) {
        pageSize = ps
    }
    
    public func didSelectItem(_didSelectBlock:@escaping (_ index: NSInteger, _ item: [String:AnyObject]?) -> Void) {
        didSelectBlock = _didSelectBlock
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
    
    override open func reloadData() {
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
        if let refresh = refreshBlock as ((Int) -> Void)? {
            refresh(pageNo)
        }
    }
}

extension NPBaseCV : UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let didSelectItem = didSelectBlock as ((NSInteger, [String : AnyObject]?) -> Void)? {
            didSelectItem(indexPath.row, arrayAllData?[indexPath.row])
        }
    }
}

extension NPBaseCV : UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard arrayAllData != nil else {
            return 0
        }
        return arrayAllData!.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension NPBaseCV : UICollectionViewDataSourcePrefetching {
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    }
}

extension NPBaseCV : UIScrollViewDelegate {
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
                if let more = self.moreBlock as ((Int) -> Void)? {
                    more(self.pageNo)
                }
            })
        }
    }
}
