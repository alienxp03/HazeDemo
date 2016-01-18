//
//  LocationsViewModel.swift
//  HazeDemo
//
//  Created by Muhammad Azuan Zira Zairein on 16/01/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct LocationsViewModel {
    private var locations: Variable<[Reading]>      = Variable([Reading]())
    private var filteredLocation                    = Variable([Reading]())

    var searchText                                  = Variable("")
    var locationsFetched                            = Driver.just(false)
    var locationsFiltered                           = Driver.just(false)
    
    init() {
        locationsFetched = ReadingsApi()
            .latestReading()
            .flatMapLatest({ readings -> Driver<Bool> in
                self.locations.value = readings.sort{ $0.location.name < $1.location.name }
                return Driver.just(true)
            })
        
        locationsFiltered = searchText.asObservable()
            .flatMapLatest({ text -> Driver<Bool> in
                self.filteredLocation.value = self.locations.value
                    .filter{ $0.location.name.lowercaseString.containsString(text.lowercaseString)}
                return Driver.just(true)
            }).asDriver(onErrorJustReturn: false)
    }
    
    func getLocations() -> [Reading] {
        if isSearching() {
            return filteredLocation.value
        }
        return locations.value
    }

    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    func readingForRowAtIndexPath(indexPath: NSIndexPath) -> Reading {
        if isSearching() {
            return filteredLocation.value[indexPath.row]
        }
        return locations.value[indexPath.row]
    }
    
    private func isSearching() -> Bool {
        return searchText.value.count() > 0
    }
}
