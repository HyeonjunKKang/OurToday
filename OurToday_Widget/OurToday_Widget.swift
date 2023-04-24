//
//  OurToday_Widget.swift
//  OurToday_Widget
//
//  Created by 강현준 on 2023/04/20.
//

import WidgetKit
import SwiftUI
import RealmSwift


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct OurToday_WidgetEntryView : View {
    var entry: Provider.Entry
    
    let loveData: LoveModel
    
    var mainImage: UIImage{
        guard let data = loveData.mainImage else { return #imageLiteral(resourceName: "mainImage")}
        let image = UIImage(data: data)
        let size = CGSize(width: 364, height: 180)
        let resizedImage = image?.resize(to: size)
        return resizedImage ?? #imageLiteral(resourceName: "mainImage")
    }
    
    var howMany: String{
        let calendar = Calendar.current
        guard let loveDay = loveData.firstLoveDay else { return "D-day +0일" }
        
        let today = Date()
        let start = calendar.startOfDay(for: loveDay)
        let end = calendar.startOfDay(for: today)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return "D-day +\((components.day ?? 0) + 1) 일"
    }
    
    var body: some View {
        ZStack(alignment: .center){
            GeometryReader{ geo in
                Image(uiImage: WidgetRealmManager.shared.getMainBackgroundImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            VStack(alignment: .center){
                Spacer()
                Image(uiImage: #imageLiteral(resourceName: "heart_fill"))
                    .resizable()
                    .frame(width: 50, height: 50)
                HStack{
                    Spacer()
                    Text(howMany)
                        .foregroundColor(.white)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct OurToday_Widget: Widget {
    let kind: String = "OurToday_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            OurToday_WidgetEntryView(entry: entry, loveData: WidgetRealmManager.shared.fetch())
        }
        .configurationDisplayName("우리 오늘 위젯")
        .description("우리 오늘 위젯으로 만나보세요!")
        .supportedFamilies([.systemSmall, .systemMedium])
        
    }
}

struct OurToday_Widget_Previews: PreviewProvider {
    static var previews: some View {
        OurToday_WidgetEntryView(entry: SimpleEntry(date: Date()), loveData: WidgetRealmManager.shared.fetch())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
