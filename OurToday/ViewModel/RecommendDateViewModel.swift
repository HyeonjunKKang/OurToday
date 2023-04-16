//
//  RecommendDateViewModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import Foundation

struct RecommendDateViewModel{
    
    // MARK: - Properties
    
    private let date: DateModel
    
    var imageUrl: URL?{
        return URL(string: date.imageurl)
    }
    
    var description: String{
        return date.introduce
    }
    
    var address: String{
        return date.address
    }
    
    var name: String{
        return date.name
    }
    
    // MARK: - Initializer
    
    init(date: DateModel) {
        self.date = date
    }
}
