//
//  NPDateUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 17..
//

import UIKit

public class NPDateUtil: NSObject {
    public class func string(from date: Date?, format: String?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format ?? ""
        if let aDate = date {
            return formatter.string(from: aDate)
        }
        return nil
    }
    
    public class func date(from dateString: String?, format: String?) -> Date? {
        guard let aDateString = dateString else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = format ?? ""
        return formatter.date(from: aDateString)
    }
    
    public class func changeFormat(_ stringDate: String?, format: String?) -> String? {
        return self.string(from: self.detectorDate(stringDate), format: format)
    }
    
    public class func detectorDate(_ stringDate: String?) -> Date? {
        guard var aStringDate = stringDate else {
            return nil
        }
        var timeZone: NSTimeZone = NSTimeZone.default as NSTimeZone
        if aStringDate.contains("T") && aStringDate.contains("Z") {
            timeZone = NSTimeZone.local as NSTimeZone
            aStringDate = aStringDate.replacingOccurrences(of: "T", with: " ")
            aStringDate = aStringDate.replacingOccurrences(of: "Z", with: "")
        }
        //Detect.
        let detector = try? NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingAllTypes))
        let result: NSTextCheckingResult? = detector?.firstMatch(in: aStringDate, options: .reportCompletion, range: NSRange(location: 0, length: aStringDate.count))
        let date = result?.date?.addingTimeInterval(TimeInterval(timeZone.secondsFromGMT))
        
        return date
    }
    
    public class func isOver(_ dateString: String?, format: String?) -> Bool {
        print("\(#function) \(dateString ?? "")")
        print("timeIntervalSinceDate : \(Date().timeIntervalSince(NPDateUtil.date(from: dateString, format: format)!))")
        return Date().timeIntervalSince(NPDateUtil.date(from: dateString, format: format)!) >= 0
    }
}
