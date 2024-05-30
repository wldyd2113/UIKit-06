//
//  JRNLWidgetExtensionLiveActivity.swift
//  JRNLWidgetExtension
//
//  Created by 차지용 on 5/30/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct JRNLWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct JRNLWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: JRNLWidgetExtensionAttributes.self) { context in
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

extension JRNLWidgetExtensionAttributes {
    fileprivate static var preview: JRNLWidgetExtensionAttributes {
        JRNLWidgetExtensionAttributes(name: "World")
    }
}

extension JRNLWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: JRNLWidgetExtensionAttributes.ContentState {
        JRNLWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: JRNLWidgetExtensionAttributes.ContentState {
         JRNLWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: JRNLWidgetExtensionAttributes.preview) {
   JRNLWidgetExtensionLiveActivity()
} contentStates: {
    JRNLWidgetExtensionAttributes.ContentState.smiley
    JRNLWidgetExtensionAttributes.ContentState.starEyes
}
