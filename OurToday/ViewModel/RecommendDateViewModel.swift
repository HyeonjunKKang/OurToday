//
//  RecommendDateViewModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit

struct RecommendDateViewModel{
    
    // MARK: - Properties
    
    private let date: DateModel
    
    var imagerUrl: String{
        return date.imageurl
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
    
    func loadImage(url string: String, completion: @escaping(UIImage) -> ()){
        if let url = URL(string: string){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
               
                if let error = error{
                    print("DEBUG: Error downloading image \(error.localizedDescription)")
                    
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("DEBUG: Error converting data to image")
                    
                    return
                }
                completion(image)
            }.resume()
        }
    }
    
    // MARK: - Initializer
    
    init(date: DateModel) {
        self.date = date
    }
}
