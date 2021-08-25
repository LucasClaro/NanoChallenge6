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
                    ZStack {
                        Image("Quadro2")
                            .resizable()
                            .frame(width: 150, height: 135, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image("Prod1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 115, height: 115, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    ZStack {
                        Image("Quadro2")
                            .resizable()
                            .frame(width: 150, height: 135, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image("Prod2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 115, height: 115, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                
            case .systemLarge:
                VStack {
                    HStack {
                        ZStack {
                            Image("Quadro2")
                                .resizable()
                                .frame(width: 150, height: 135, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Image("Prod1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 115, height: 115, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        
                        ZStack {
                            Image("Quadro2")
                                .resizable()
                                .frame(width: 150, height: 135, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Image("Prod2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 115, height: 115, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
           
                    }
                    HStack {
                        ZStack {
                            Image("Quadro2")
                                .resizable()
                                .frame(width: 150, height: 135, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Image("Prod3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 115, height: 115, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        
                        ZStack {
                            Image("Quadro2")
                                .resizable()
                                .frame(width: 150, height: 135, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Image("Prod4")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 115, height: 115, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
           
                    }
                }
            default:
                Image("Quadro2")
                    .resizable()
                    .frame(width: 150, height: 135, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack {
                    
                    Image("Prod1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 115, height: 115, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
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
