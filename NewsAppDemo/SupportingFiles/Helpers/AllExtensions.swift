//
//  AllExtensions.swift
//  NewsAppDemo
//
//  Created by hasher on 12/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

protocol Utilities {
}

//MARK:- Utilities Extensions
extension NSObject:Utilities {
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        if flags.contains(.reachable) == false {
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
}




//MARK:-UIColor Extensions
extension UIColor {
    
   class func hexStringToUIColor (hex:String, withOpacity: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(withOpacity)
        )
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat)->UIColor{
        return UIColor(red:red/255 , green: green/255, blue: blue/255, alpha: 1)
    }
}


//MARK: Dictionary [AnyHashable: Any]

extension Dictionary where Key: Hashable, Value: Any
{
    func getDataFromDictionary() -> Data? {
        do {
            let taskData = try JSONSerialization.data(withJSONObject: self as Any, options: .prettyPrinted)
            return taskData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

//MARK:- UIWindow Extensions

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}



//MARK:- UIView Extensions

extension UIView {
    
    func addConstraints(_ format: String, constraintViews: [UIView]) {
        var viewsDictionary = [String: Any]()
        for view: UIView in constraintViews {
            let key = "v\((constraintViews as NSArray).index(of: view))"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewsDictionary))
    }
    
    func showNoDataLabel(withText text: String?) {
            hideNoDataLabel()
            layoutIfNeeded()
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 20))
            noDataLabel.text = text
            noDataLabel.textAlignment = .center
        noDataLabel.font = UIFont.systemFont(ofSize: 16)
            noDataLabel.textColor = LIGHT_GRAY_COLOR
            noDataLabel.sizeToFit()
            noDataLabel.tag = NO_DATA_LABEL_TAG
            if (self is UITableView) {
                let tableView = self as? UITableView
                tableView?.tableHeaderView = noDataLabel
                var frame: CGRect? = tableView?.tableHeaderView?.frame
                frame?.size.height = tableView?.frame.size.height ?? 0.0
                tableView?.tableHeaderView?.frame = frame ?? CGRect.zero
                tableView?.reloadData()
            } else {
                noDataLabel.center = center
                var frame: CGRect = noDataLabel.frame
                frame.origin.y = self.frame.size.height / 2 - 10
                noDataLabel.frame = frame
                addSubview(noDataLabel)
                bringSubviewToFront(noDataLabel)
            }
        }
        
        func hideNoDataLabel() {
            if (self is UITableView) {
                let tableView = self as? UITableView
    //            tableView?.tableHeaderView = UIView()
                tableView?.tableHeaderView = nil
            } else {
                viewWithTag(NO_DATA_LABEL_TAG)?.removeFromSuperview()
            }
        }
}

//MARK: UIViewController Extensions

extension UIViewController {
    
    //MARK:- For InternetConnectivity Observers
       func addObserverForInternetConnectivity() {
           NotificationCenter.default.addObserver(self, selector: #selector(self.gotInternetConnectivity), name: NSNotification.Name.INTERNET_CONNECTION, object: nil)
       }
       
       func removeObserverForInternetConnectivity() {
           NotificationCenter.default.removeObserver(self, name: NSNotification.Name.INTERNET_CONNECTION, object: nil)
       }
       
       @objc func gotInternetConnectivity() {
           SHOW_TOAST("Connection established")
       }
    
    func addRightButtonsWith(fisrtButtonDefaultTitle: String?, fisrtButtonSelectedTitle: String?, fisrtButtonSelected: Bool = false, target: Any?)
    {
        navigationItem.rightBarButtonItems = nil
        
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 45))
        button1.setTitle(fisrtButtonDefaultTitle, for: .normal)
        button1.setTitle(fisrtButtonSelectedTitle, for: .selected)
        button1.setTitleColor(UIColor.systemGreen, for: .normal)
        button1.setTitleColor(UIColor.systemGreen, for: .selected)
        
        button1.addTarget(target, action: #selector(firstButtonAction(sender:)), for: .touchUpInside)
        
        button1.isSelected = fisrtButtonSelected
        
        let stackView = UIStackView(arrangedSubviews: [button1])
        stackView.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
        stackView.axis = .horizontal
        stackView.spacing = 13.0
        navigationItem.rightBarButtonItems = [ UIBarButtonItem(customView: stackView)]
    }
    
    @objc open func firstButtonAction(sender: UIButton) {
    }
         
}

//MARK: Extention for Array

extension Array {
    func indexesOf<T : Equatable>(object:T) -> [Int] {
        var result: [Int] = []
        for (index,obj) in self.enumerated() {
            if obj as! T == object {
                result.append(index)
            }
        }
        return result
    }
}
