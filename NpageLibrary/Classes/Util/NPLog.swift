//
//  NPLog.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

import UIKit

enum LogEvent: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
}

public class NPLog {
    static var isLoggingEnabled = true
    
    static func setLoggin(enable: Bool) {
        isLoggingEnabled = enable
    }

    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS" // Use your own
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    class func e( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        printLog(event: LogEvent.e, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    class func i( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        printLog(event: LogEvent.i, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    class func d( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        printLog(event: LogEvent.d, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    class func v( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        printLog(event: LogEvent.v, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    class func w( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        printLog(event: LogEvent.w, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    class func s( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        printLog(event: LogEvent.s, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    class func printLog(event: LogEvent,  _ object: Any, filename: String, line: Int, column: Int, funcName: String) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(event.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

extension Date {
    func toString() -> String {
        return NPLog.dateFormatter.string(from: self as Date)
    }
}
