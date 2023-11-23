//
//  WidgetDayLiveActivity.swift
//  WidgetDay
//
//  Created by Mahdia Amriou on 22/11/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetDayAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetDayLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetDayAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetDayAttributes {
    fileprivate static var preview: WidgetDayAttributes {
        WidgetDayAttributes(name: "World")
    }
}

extension WidgetDayAttributes.ContentState {
    fileprivate static var smiley: WidgetDayAttributes.ContentState {
        WidgetDayAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetDayAttributes.ContentState {
         WidgetDayAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetDayAttributes.preview) {
   WidgetDayLiveActivity()
} contentStates: {
    WidgetDayAttributes.ContentState.smiley
    WidgetDayAttributes.ContentState.starEyes
}
