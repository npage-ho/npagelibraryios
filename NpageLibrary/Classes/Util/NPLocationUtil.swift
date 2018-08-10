//
//  NPLocationUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 10..
//

/*
 Usage
 
 1. init at top(not in viewDidLoad)
 var locationUtil = NPLocationUtil()
 
 2. call method findLocation
 locationUtil.findLocation(target: self) { (coordinate, error) in
    print("location : \(String(describing: coordinate))")
 }
 
 */

import UIKit
import CoreLocation

public class NPLocationUtil: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var completeBlock: ((CLLocationCoordinate2D?, Error?) -> Void)?
    
    public func findLocation(target: UIViewController!, _completeBlock:@escaping (_ locations: CLLocationCoordinate2D?, _ error: Error?) -> Void) {
        completeBlock = _completeBlock
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if locationManager.responds(to: #selector(locationManager.requestWhenInUseAuthorization)) {
            let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            
            if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            } else if status == .restricted || status == .denied {
                let title = (status == .denied) ? "Location services are off" : "Background location is not enabled"
                let message = "To use background location you must turn on 'Always' in the Location Services Settings"
                
                var actions: [UIAlertAction]!
                actions.append(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
                    self.completeBlock!(nil, nil)
                    
                }))
                actions.append(UIAlertAction(title: "Confirm", style: .default, handler: { (UIAlertAction) in
                    self.completeBlock!(nil, nil)
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }))
                NPAlertUtil.showAlert(title: title, message: message, actions: actions)
                
            } else {
                locationManager.startUpdatingLocation()
            }
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        if let coor = manager.location?.coordinate{
            print("latitude" + String(coor.latitude) + "/ longitude" + String(coor.longitude))
            self.completeBlock!(manager.location?.coordinate, nil)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.completeBlock!(nil, error)
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined: break
        case .restricted, .denied: break
        default:
            locationManager.startUpdatingLocation()
        }
    }
}
