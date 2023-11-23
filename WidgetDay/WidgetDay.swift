//
//  WidgetDay.swift
//  WidgetDay
//
//  Created by Mahdia Amriou on 22/11/2023.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = SimpleEntry(date: startOfDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WidgetDayEntryView :  View {
    var entry: SimpleEntry
    var config: SimpleConfig

    init(entry: SimpleEntry) {
        self.entry = entry
        self.config = SimpleConfig.determineConfig(from: entry.date)
    }

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(config.backgroundColor.gradient)
                .padding(.horizontal, -16)
                .padding(.vertical, -8)

            VStack(spacing: 0) {
                Text(entry.date.weekdayDisplayFormat)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.9))
                        .minimumScaleFactor(0.9)

                ZStack {
                    Text(entry.date.dayDisplayFormat)
                        .font(.system(size: 70, weight: .heavy))
                        .fontWeight(.bold)
                        .foregroundColor(.black.opacity(0.1))

                    Text(config.quote)
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                        .padding(-18)
                }
                Text("-\(config.author)")
                .font(.system(size: 10))
                .foregroundColor(.white)
                .foregroundColor(.white)
                .padding(.top, -4)
            }
            .padding()
        }
    }
}

struct WidgetDay: Widget {
    let kind: String = "DailyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetDayEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Daily Widget")
        .description("")
        //.supportedFamilies([.systemSmall, .systemLarge])
    }
    
    
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

extension Date {
    var weekdayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}

#Preview(as: .systemSmall) {
    WidgetDay()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
