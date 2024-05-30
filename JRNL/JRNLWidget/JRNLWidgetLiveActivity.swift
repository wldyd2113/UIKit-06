//
//  JRNLWidgetLiveActivity.swift
//  JRNLWidget
//
//  Created by 차지용 on 5/30/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct JRNLWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct JRNLWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: JRNLWidgetAttributes.self) { context in
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

extension JRNLWidgetAttributes {
    fileprivate static var preview: JRNLWidgetAttributes {
        JRNLWidgetAttributes(name: "World")
    }
}

extension JRNLWidgetAttributes.ContentState {
    fileprivate static var smiley: JRNLWidgetAttributes.ContentState {
        JRNLWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: JRNLWidgetAttributes.ContentState {
         JRNLWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: JRNLWidgetAttributes.preview) {
   JRNLWidgetLiveActivity()
} contentStates: {
    JRNLWidgetAttributes.ContentState.smiley
    JRNLWidgetAttributes.ContentState.starEyes
}
