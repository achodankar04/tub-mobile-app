//
//  DashboardViewModel.swift
//  TheUltimateBuzz
//
//  Created by Sagar C on 31/07/20.
//  Copyright © 2020 Ticron. All rights reserved.
//

import UIKit
import Alamofire

protocol VideoResponseDelegate {
    func passVideoResponse(videoDict: Dictionary<String,Any>)
}

class DashboardViewModel: NSObject {

    var delegate : VideoResponseDelegate?
    func callAPI(){
        let url = URL(string: "https://theultimatebuzz.com/videosAndroid.json")!
        AF.request(url as URL, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let resultNew = value as? Dictionary<String, Any>
                let arr_videos = resultNew!["videos"] as? NSArray
                if(arr_videos!.count > 0){
                    for vid_data in arr_videos! as Array{                        
                        self.delegate?.passVideoResponse(videoDict: vid_data as! Dictionary<String, Any>)
                    }
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
