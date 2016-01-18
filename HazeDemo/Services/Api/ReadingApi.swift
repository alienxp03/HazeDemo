//
//  ReadingApi.swift
//  HazeDemo
//
//  Created by Muhammad Azuan Zira Zairein on 16/01/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa

struct ReadingsApi: Api {
    func latestReading() -> Driver<[Reading]> {
        return Observable.create({ observer in
            var readings = [Reading]()
            
            Alamofire.request(.GET, self.baseApiUrl)
                .responseJSON(completionHandler: {
                    response in
                    switch response.result {
                    case .Success(let value):
                        let json = JSON(value)
                        
                        for (_, result):(String, JSON) in json["result"] {
                            let reading = Reading(json: result)
                            readings.append(reading)
                        }
                        observer.on(.Next(readings))
                        observer.on(.Completed)
                    case .Failure(let error):
                        observer.on(.Error(error))
                    }
                })
            return NopDisposable.instance
        }).asDriver(onErrorJustReturn: [Reading]())
    }
}
