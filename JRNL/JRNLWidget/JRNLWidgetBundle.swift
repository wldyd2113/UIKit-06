//
//  JRNLWidgetBundle.swift
//  JRNLWidget
//
//  Created by 차지용 on 5/30/24.
//

import WidgetKit
import SwiftUI

@main
struct JRNLWidgetBundle: WidgetBundle {
    var body: some Widget {
        JRNLWidget()
        JRNLWidgetLiveActivity()
    }
}
