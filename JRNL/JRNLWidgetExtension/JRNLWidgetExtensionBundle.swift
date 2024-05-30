//
//  JRNLWidgetExtensionBundle.swift
//  JRNLWidgetExtension
//
//  Created by 차지용 on 5/30/24.
//

import WidgetKit
import SwiftUI

@main
struct JRNLWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        JRNLWidgetExtension()
        JRNLWidgetExtensionLiveActivity()
    }
}
