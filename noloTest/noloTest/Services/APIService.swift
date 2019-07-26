//
//  APIService.swift
//  noloTest
//
//  Created by Aryan Sharma on 26/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftDate
import SVProgressHUD

class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.spacexdata.com/v3"

    func fetchLaunches(after date: String,
                       completionHandler: @escaping(Result<[Launch]>) -> ()) {
        let url = "/launches"
        let params: Parameters = [
            "start": date,
            "end": Date().toFormat("YYYY-MM-dd")
        ]
        SVProgressHUD.show(withStatus: "Gathering 🚀 data, All hail Mr. Elon Stark!!")
        Alamofire.request(baseURL+url,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.default,
                          headers: nil).responseData { (dataResponse) in
                            SVProgressHUD.dismiss()
                            guard let data = dataResponse.data else {
                                completionHandler(.error(APIError.noData))
                                return
                            }
                            do {
                                let resp = try JSONDecoder().decode([Launch].self, from: data)
                                completionHandler(.success(resp))
                            } catch let err {
                                print(err)
                                completionHandler(.error(APIError.parseError(err.localizedDescription)))
                            }

                            
        }
        
    }
}

enum APIError: Error {
    case noData
    case parseError(String)
    case noToken
}

enum Result<T> {
    case error(Error)
    case success(T)
}
