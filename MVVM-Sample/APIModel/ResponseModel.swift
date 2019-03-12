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
    case error(error: Error)
}
