//
//  JournalEntry.swift
//  JRNL
//
//  Created by 차지용 on 5/10/24.
//

import UIKit

class JournalEntry {
    // MARK: - Properties
    let date: Date
    let rateing: Int
    let entryTitle: String
    let entryBody: String
    let photo: UIImage?
    let latitude: Double? //위도
    let longitude: Double? //경도
    
    init?(date: Date, rateing: Int, title: String, body: String, photo: UIImage? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        if title.isEmpty || body.isEmpty || rateing < 0 || rateing > 5 {
            return nil
        }
        self.date = Date()
        self.rateing = rateing
        self.entryTitle = title
        self.entryBody = body
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
}
