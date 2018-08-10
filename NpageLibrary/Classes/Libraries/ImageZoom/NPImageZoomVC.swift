//
//  NPImageZoomVC.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

/*
 Usage
 
 let imageZoomVC = ImageZoomVC(nibName: "ImageZoomVC", bundle: nil)
 imageZoomVC.arrayImages = ["https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg", "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-2.jpg", "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-3.jpg"]
 self.present(imageZoomVC, animated: true, completion: nil)
 */

import UIKit
import Kingfisher

public class NPImageZoomVC: UIViewController {
    var arrayImages: Array<String>!
    var arrayTitles: Array<String>?
    var selectImageIndex: Int = 0
    var rectStandard: CGRect!
    
    @IBOutlet weak var _scrollView: UIScrollView!
    @IBOutlet weak var labelCurrentPage: UILabel!
    @IBOutlet weak var labelTitle: UILabel!

    override public func viewDidLoad() {
        super.viewDidLoad()

        _scrollView.delegate = self
        rectStandard = UIScreen.main.bounds
        if arrayImages != nil && arrayImages.count > 0 {
            for i in 0..<arrayImages.count {
                addImage(arrayImages[i], index: i)
            }
            _scrollView.contentSize = CGSize(width: rectStandard.size.width * CGFloat(arrayImages.count), height: rectStandard.size.height)
            _scrollView.contentOffset = CGPoint(x: rectStandard.size.width * CGFloat(selectImageIndex), y: 0)
            labelCurrentPage.text = "\(selectImageIndex + 1) / \(Int(arrayImages.count))"
            setTitleText(selectImageIndex)
        }
    }
    
    func setTitleText(_ page: Int) {
        if arrayTitles != nil && (arrayTitles?.count)! > 0 {
            labelTitle.text = arrayTitles?[page]
        }
    }

    func addImage(_ urlString: String, index: Int) {
        let imageView = UIImageView(frame: rectStandard)
        imageView.contentMode = .scaleAspectFit
        imageView.kf.setImage(with: URL(string: urlString))
        let scrollView = UIScrollView(frame: CGRect(x: CGFloat(rectStandard.size.width * CGFloat(index)), y: 0, width: rectStandard.size.width, height: rectStandard.size.height))
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.contentSize = _scrollView.frame.size
        scrollView.zoomScale = 1
        scrollView.tag = index + 1
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        _scrollView.addSubview(scrollView)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    @objc func handleDoubleTap(_ gestureRecognizer: UIGestureRecognizer?) {
        let scrollView = gestureRecognizer?.view as? UIScrollView
        if (scrollView?.zoomScale ?? 0.0) > (scrollView?.minimumZoomScale ?? 0.0) {
            zoom(scrollView, to: gestureRecognizer?.location(in: scrollView) ?? CGPoint.zero, withScale: scrollView?.minimumZoomScale ?? 0.0, animated: true)
        } else {
            zoom(scrollView, to: gestureRecognizer?.location(in: scrollView) ?? CGPoint.zero, withScale: scrollView?.maximumZoomScale ?? 0.0, animated: true)
        }
    }
    
    func zoom(_ scrollView: UIScrollView?, to zoomPoint: CGPoint, withScale scale: CGFloat, animated: Bool) {
        var zoomPoint = zoomPoint
        //Normalize current content size back to content scale of 1.0f
        let contentSize = CGSize(width: (scrollView?.contentSize.width ?? 0.0) / (scrollView?.zoomScale ?? 0.0), height: (scrollView?.contentSize.height ?? 0.0) / (scrollView?.zoomScale ?? 0.0))
        //translate the zoom point to relative to the content rect
        zoomPoint.x = (zoomPoint.x / (scrollView?.bounds.size.width ?? 0.0)) * contentSize.width
        zoomPoint.y = (zoomPoint.y / (scrollView?.bounds.size.height ?? 0.0)) * contentSize.height
        //derive the size of the region to zoom to
        let zoomSize = CGSize(width: (scrollView?.bounds.size.width ?? 0.0) / scale, height: (scrollView?.bounds.size.height ?? 0.0) / scale)
        
        let zoomRect = CGRect(x: zoomPoint.x - zoomSize.width / 2.0, y: zoomPoint.y - zoomSize.height / 2.0, width: zoomSize.width, height: zoomSize.height)
        //apply the resize
        scrollView?.zoom(to: zoomRect, animated: animated)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NPImageZoomVC: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView.subviews.count > 0 {
            return scrollView.subviews[0]
        } else {
            return nil
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var page: Int = Int(floor((scrollView.contentOffset.x - rectStandard.size.width / 2) / rectStandard.size.width) + 1)
        if page < 0 {
            page = 0
        }
        labelCurrentPage.text = "\(page + 1) / \(Int(arrayImages.count))"
        setTitleText(page)
    }
}
