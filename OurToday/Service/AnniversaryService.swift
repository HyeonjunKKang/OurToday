//
//  AnniversaryService.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/20.
//

import Foundation

final class AnniversaryService{
    
    static let shared = AnniversaryService()
    
    private var anniversaryList: [AnniversaryModel] = []
    
    private init(){}
    
    func calculateAnniversary(loveModel: LoveModel ,completion: @escaping ([AnniversaryModel])->()){
        
        guard let loveDay = loveModel.firstLoveDay, let loverBirthday = loveModel.loverBirthDay, let loverNickName = loveModel.loverNickname, let firstLoveDay = loveModel.firstLoveDay else { return }
        
        let calendar = Calendar.current
        let startOfDayLoveDay = calendar.startOfDay(for: loveDay)
        let startOfDayToday = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: startOfDayLoveDay, to: startOfDayToday)
        var numberOfDaysMetUpToday = (components.day ?? 0) + 1
        
        let startDate = Date()
        let endDate = calendar.date(byAdding: .day, value: DAYOFTHRITYYEAR, to: startDate)!
        
        var currentDate = startDate
        
        var dateTuple = [(whatDay: String, date: String, remainDay: String)]()
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            let loverBirthDateComponent = calendar.dateComponents([.month, .day], from: loverBirthday)
            let firstLoveDayDateConponents = calendar.dateComponents([.month, .day], from: firstLoveDay)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
            
            while currentDate <= endDate {
                
                let gap = calendar.dateComponents([.day], from: startDate, to: currentDate)
                let today = calendar.dateComponents([.month, .day], from: currentDate)
                let dateString = dateFormatter.string(from: currentDate)
                
                if (numberOfDaysMetUpToday < 101 && numberOfDaysMetUpToday % 10 == 0){
                    dateTuple.append((whatDay: "\(numberOfDaysMetUpToday) 일", date: dateString, remainDay: "D-Day\(gap.day ?? 0)"))
                } else if (numberOfDaysMetUpToday > 100 && numberOfDaysMetUpToday % 100 == 0){
                    dateTuple.append((whatDay: "\(numberOfDaysMetUpToday) 일", date: dateString, remainDay: "D-Day\(gap.day ?? 0)"))
                } else if today == firstLoveDayDateConponents{
                    dateTuple.append((whatDay: "\(numberOfDaysMetUpToday / 365)주년", date: dateString, remainDay: "D-Day\(gap.day ?? 0)"))
                }
                else {
                    if loverBirthDateComponent == today{
                        dateTuple.append((whatDay: "\(loverNickName)생일", date: dateString, remainDay: "D-Day\(gap.day ?? 0)"))
                    }
                }
                numberOfDaysMetUpToday += 1
                
                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            }
            self.anniversaryList = []
            dateTuple.forEach {
                self.anniversaryList.append(AnniversaryModel(whatDay: $0.whatDay, date: $0.date, remainDay: $0.remainDay))
            }
            
            completion(self.anniversaryList)
        }
    }
    
}
