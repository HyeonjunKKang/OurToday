//
//  PickTheDayAndBirthDayDelegate.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit

protocol PickDateDelegate: AnyObject{
    func dayDidComplete(controller: UIViewController)
    func pickDay(controller: UIViewController, selecteDay: Date)
}

protocol ImagePickerDelegate: AnyObject{
    func imagePick(_ controller: UIViewController, image: UIImage)
}

protocol MainToAnniversaryDelegate: AnyObject{
    func didChangeLoveDate(lovedata: LoveModel)
}
