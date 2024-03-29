//
//  Methods.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 31/10/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

    
//    <key>NSAppTransportSecurity</key>
//    <dict>
//        <key>NSAllowsArbitraryLoads</key>
//        <true/>
//        <key>NSExceptionDomains</key>
//        <dict>
//            <key>example.com</key>
//            <dict>
//                <key>NSExceptionAllowsInsecureHTTPLoads</key>
//                <true/>
//                <key>NSIncludesSubdomains</key>
//                <true/>
//            </dict>
//        </dict>
//    </dict>


class Methods: NSObject {
    class func getBaseUrl() -> String {
        return kSERVERURL
    }
    class func getOneSignalId() -> String {
        return ""
    }
    class func getApplicationAppStoreId() -> String {
        return ""
    }
    class func getAppStoreMoreUrl() -> String {
        return ""
    }
    class func validateEmail(with check_email: String?) -> Bool{
          let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
          let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
          return emailTest.evaluate(with: check_email)
    }
    
    class func validMobileNumber(_ number: String?) -> Bool{
        let numberRegEx = "[0-9]{10}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if numberTest.evaluate(with: number) == true {
            return true
        } else {
            return false
        }
    }
    
    class func isValidateDOB(_ dateOfBirth: String?) -> Bool{
           let format = DateFormatter()
           format.dateStyle = .short
           format.dateFormat = "dd/MM/yy"
           let validateDOB: Date? = format.date(from: dateOfBirth ?? "")
           if validateDOB != nil {
               return true
           } else {
               return false
           }
       }
    
    class func extractYoutubeId(fromLink link: String?) -> String?{
        let regexString = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        let regExp = try? NSRegularExpression(pattern: regexString, options: .caseInsensitive)
        let array = regExp?.matches(in: link ?? "", options: [], range: NSRange(location: 0, length: link?.count ?? 0))
        if (array?.count ?? 0) > 0 {
            let result: NSTextCheckingResult? = array?.first
            if let aRange = result?.range {
                return (link as NSString?)?.substring(with: aRange)
            }
            return nil
        }
        return nil
    }
    
    class func getPath(_ fileName: String) -> String{
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.path
    }
    
    class func copyFile(_ fileName: NSString){
           let dbPath: String = getPath(fileName as String)
           let fileManager = FileManager.default
           if !fileManager.fileExists(atPath: dbPath) {
               
               let documentsURL = Bundle.main.resourceURL
               let fromPath = documentsURL!.appendingPathComponent(fileName as String)
               
               var error : NSError?
               do {
                   try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
               } catch let error1 as NSError {
                   error = error1
               }
               
               if (error != nil) {
                   print("Database copy failed!")
               } else {
                   print("Your database copy successfully!")
               }
           }
       }
    
    class func getAPIKey() -> String{
        return "primetv"
    }
    
    class func getSalt() -> NSString {
           let str:Int = (Int(1+arc4random_uniform(1000)))
           return NSString(format: "%@", String(str))
       }
    
    class func getSign(_ salt: String?) -> String? {
           let keysalt = "\(self.getAPIKey())\(salt ?? "")"
           return Methods.getMD5Hash(keysalt)
       }
    
    class func getMD5Hash(_ string: String) -> String{
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
                CC_MD5(bytes.baseAddress, CC_LONG(d.count), &digest)
            }
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    class func getBase64EncodedString(_ jsonDict: [AnyHashable : Any]?) -> String?{
        var detailsData: Data? = nil
        if let jsonDict = jsonDict {
            detailsData = try? JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
        }
        
        var jsonStr: String? = nil
        if let detailsData = detailsData {
            jsonStr = "\(String(data: detailsData, encoding: .utf8) ?? "")"
        }
        let base64Data: Data? = jsonStr?.data(using: .utf8)
        let str = base64Data?.base64EncodedString(options: [])
        return str
    }
    
   public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class var screenHeight: CGFloat {
          return UIScreen.main.bounds.size.height
      }
    
    class func getIFAddresses() -> [String]{
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }
        
        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            var addr = ptr.pointee.ifa_addr.pointee
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }
        freeifaddrs(ifaddr)
        return addresses
    }
    
    
    class func formatPoints(num: Double) -> String{
            var thousandNum = num/1000
            var millionNum = num/1000000
            if num >= 1000 && num < 1000000{
                if(floor(thousandNum) == thousandNum){
                    return("\(Int(thousandNum))k")
                }
                return("\(thousandNum.roundToPlaces(places: 1))k")
            }
            
            if num > 1000000 {
                if(floor(millionNum) == millionNum){
                    return("\(Int(thousandNum))k")
                }
                return ("\(millionNum.roundToPlaces(places: 1))M")
            } else {
                if(floor(num) == num){
                    return ("\(Int(num))")
                }
                return ("\(num)")
            }
        }
    
    
}
extension String
{
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension NSAttributedString
{
    convenience init(htmlString html: String) throws {
        try self.init(data: Data(html.utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
    }
}

extension Double
{
    /// Rounds the double to decimal places value
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(100.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}


