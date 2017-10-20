//
//  Utilities.swift
//  Authenticator
//
//  Created by Raj Rao on 9/11/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

import Foundation

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


