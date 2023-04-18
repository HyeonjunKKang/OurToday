//
//  DetailDateInfoViewModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/17.
//

import UIKit

final class DetailDateInfoViewModel{
    
    // MARK: - Properties
    private var dateModel: DateModel
    
    var name: String{
       return dateModel.name
    }
    
    var introduce: String{
        return dateModel.introduce
    }
    
    var address: String{
        return dateModel.address
    }
    
    var imageUrl: URL{
        guard let url = URL(string: dateModel.imageurl) else {
            return URL(string: "https://firebasestorage.googleapis.com/v0/b/ourtoday-4eb24.appspot.com/o/%E1%84%89%E1%85%A5%E1%84%8B%E1%85%AE%E1%86%AF%E1%84%90%E1%85%A1%E1%84%8B%E1%85%AF.png?alt=media&token=0a791961-035e-494d-a224-8648011b2cbf")! }
        
        return url
    }
    
    // MARK: - initializer
    
    init(dateModel: DateModel) {
        self.dateModel = dateModel
    }
    
}
