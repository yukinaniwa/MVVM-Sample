//
//  APIResponse.swift
//  
//
//  Created by yuki naniwa on 2019/03/11.
//

import Foundation


enum APIResponse {
    case success
    case error(error: Error)
    case cancel
}
