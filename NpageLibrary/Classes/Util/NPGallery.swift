//
//  NPGallery.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

/*
 Usage
 
 1. Extends
 UIImagePickerControllerDelegate, UINavigationControllerDelegate
 
 2. Init & Call
 let galleryUtil: NPGallery = NPGallery()
 galleryUtil.showPhotoWithDelegate(target: self, tag: 0)
 
 3. override image picker delegate
 @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
 imageView.image = GalleryUtil.getImage(info: info)
 let fileName: String = GalleryUtil.getFileName(info: info)
 print(fileName)
 picker.dismiss(animated: true, completion: nil)
 }
 
 */

import UIKit
import Photos

public class NPGallery: NSObject {
    var _tag: Int?
    var _target: UIViewController?
    
    static func getFileName(info: [String : Any]) -> String! {
        if #available(iOS 11.0, *) {
            if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
                if let fileName = (asset.value(forKey: "filename")) as? String {
                    return fileName
                }
            }
        } else {
            // Fallback on earlier versions
        }
        return ""
    }
    
    static func getImage(info: [String : Any]) -> UIImage? {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            return pickedImage
        }
        return nil
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    func showPhotoWithDelegate(target: UIViewController, tag: Int = 0) {
        checkPermission()
        
        _target = target
        _tag = tag;
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        DispatchQueue.main.async {
            self._target?.present(alert, animated: true, completion: nil)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (UIAlertAction) in
            self.showImagePicker(sourceType: .photoLibrary);
        }))
        // iOS 시뮬레이터는 카메라 찍기가 없으므로 제외
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
                self.showImagePicker(sourceType: .camera);
            }))
        }
    }
    
    func showImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController: UIImagePickerController = UIImagePickerController.init()
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = false
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)!
        imagePickerController.delegate = _target! as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        _target?.present(imagePickerController, animated: true, completion: nil)
    }
}
