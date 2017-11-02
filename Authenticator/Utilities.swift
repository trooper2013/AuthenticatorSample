//
//  Utilities.swift
//  Authenticator
//
//  Created by Raj Rao on 9/11/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSDKCore
let app_one_key = "app-one"

let app_two_key = "app-two"

let app_one_default_url = "sampleapp"

let app_two_default_url = "sampleapptwo"

func readAppOneUrl() -> String {
    let url:String? =  readStringFromDefaults(key: app_one_key)
    return url ?? app_one_default_url
}

func readAppTwoUrl() -> String {
    let url:String? =  readStringFromDefaults(key: app_two_key)
    return url ?? app_two_default_url
}

func writeStringToDefaults(key: String, value: String) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
    
}

func readStringFromDefaults(key: String) -> String? {
    let defaults = UserDefaults.standard
    return defaults.string(forKey:key)
}

extension String {
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    
}

public extension Sequence {
    func groupBy<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for el in self {
            let key = key(el)
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }
}


extension UIImageView : SFRestDelegate {
    
//    - (void)request:(SFRestRequest *)request didLoadResponse:(id)dataResponse rawResponse:(NSURLResponse *)rawResponse;
    
    public func request(_ request: SFRestRequest, didLoadResponse dataResponse: Any) {
        let responseData = dataResponse as! Data
        DispatchQueue.main.async(execute: { () -> Void in
            let image = UIImage(data: responseData)
            guard let img = image else {
                return
            }
            self.image = img
            
        })
        
    }
    
    public func request(_ request: SFRestRequest, didFailLoadWithError error: Error) {
        print("Error...")
    }
    
    public func imageFromURL(imageURL: URL, placeholder: UIImage) {
        
        if self.image == nil{
            self.image = placeholder
        }
        
        let request = SFRestRequest(method: SFRestMethod.GET, baseURL: "https://fblogin-dev-ed--c.na30.content.force.com", path: "profilephoto/72936000000p2Om/F", queryParams: nil )
        SFRestAPI.sharedInstance().send(request, delegate: self)
        
//        let token = SFUserAccountManager.sharedInstance().currentUser?.credentials.accessToken
//        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        
//        URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
//
//            if error != nil {
//                print(error ?? "No Error")
//                return
//            }
//
//            DispatchQueue.main.async(execute: { () -> Void in
//                let image = UIImage(data: data!)
//                guard let name = nameField.text else {
//                    show("No name to submit")
//                    return
//                }
//
//                if (image!=nil) {
//                    self.image = image
//                }
//            })
//
//        }).resume()
    }}


