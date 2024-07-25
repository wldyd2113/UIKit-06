//
//  File.swift
//  Socially-UIKit
//
//  Created by 차지용 on 7/25/24.
//

import Foundation
import FirebaseCore

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    var description: String?
    var imageUR: String?
    @ServerTimestamp var datePublished: Date?
}
