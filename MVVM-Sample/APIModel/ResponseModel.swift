//
//  ResponseModel.swift
//  MVVM-Sample
//
//  Created by yuki naniwa on 2019/03/12.
//  Copyright © 2019 yuki naniwa. All rights reserved.
//

import Foundation

enum FetchResult {
    case success
    case cancel
    case error(error: ResponseError)
}

struct ResponseError {
    let code: UInt
    let message: String
    
    init(code: UInt, message: String) {
        self.code = code
        self.message = message
    }
    
    init(error: Error) {
        self.code = 400
        self.message = error.localizedDescription
    }
}

enum ResponseModel {
    struct LoginResponseModel: Decodable {
        var userToken: String
    }
    
    struct TopResponseModel: Decodable {
        var userToken: String
    }
}
