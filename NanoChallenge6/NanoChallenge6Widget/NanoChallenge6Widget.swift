//
//  NanoChallenge6Widget.swift
//  NanoChallenge6Widget
//
//  Created by Gabriel Rodrigues da Silva on 24/08/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct FavoriteProd: View {
    @State var prodNumber: Int = 1
    
    var body: some View {
        ZStack {
            Image("Quadro2")
                .resizable()
                .frame(width: 150, height: 135)
            
            Link(destination: URL(string: "\(prodNumber-1)")!, label: {
                Image("Prod\(prodNumber)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 115, height: 115)
            })
        }
    }
}

struct NanoChallenge6WidgetEntryView: View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        ZStack {
            Image("Fundo2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            switch family {
            case .systemMedium:
                HStack {
                    FavoriteProd(prodNumber: 1)
                    FavoriteProd(prodNumber: 2)
                }
                
            case .systemLarge:
                VStack {
                    HStack {
                        FavoriteProd(prodNumber: 3)
                        FavoriteProd(prodNumber: 4)
                    }
                    HStack {
                        FavoriteProd(prodNumber: 5)
                        FavoriteProd(prodNumber: 6)
                    }
                }
            default:
                FavoriteProd(prodNumber: 7)
            }
        }
        .preferredColorScheme(.light)
    }
}

@main
struct NanoChallenge6Widget: Widget {
    let kind: String = "NanoChallenge6Widget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            NanoChallenge6WidgetEntryView(entry: entry)
                .widgetURL(URL(string: "HPwidget://Prod1"))
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct NanoChallenge6Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NanoChallenge6WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            NanoChallenge6WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            NanoChallenge6WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
