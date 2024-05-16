//
//  JournalEntry.swift
//  JRNL
//
//  Created by 차지용 on 5/10/24.
//

import UIKit
import MapKit

class JournalEntry: NSObject, MKAnnotation, Codable {
    // MARK: - Properties
    let dateString: String
    let rateing: Int
    let entryTitle: String
    let entryBody: String
    let photoData: Data?
    let latitude: Double? //위도
    let longitude: Double? //경도
    
    // MARK: - Intialization
    init?(rateing: Int, title: String, body: String, photo: UIImage? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        if title.isEmpty || body.isEmpty || rateing < 0 || rateing > 5 {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        self.dateString = formatter.string(from: Date())
        self.rateing = rateing
        self.entryTitle = title
        self.entryBody = body
        self.photoData = photo?.jpegData(compressionQuality: 1.0)
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        guard let lat = latitude,
              let long = longitude else {
            return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var title: String? {
        dateString
    }
    
    var subtitle: String? {
        entryTitle
    }
}

// MARK: - Sample data
struct SampleJournalEntryData {
    var journalEntries: [JournalEntry] = []
    
    mutating func createSampleJournalEntryData() {
        let photo1 = UIImage(systemName: "sun.max")
        let photo2 = UIImage(systemName: "cloud")
        let photo3 = UIImage(systemName: "cloud.sun")
        guard let journalEntry1 = JournalEntry(rateing: 5, title: "Good", body: "Today is good day", photo: photo1) else {
            fatalError("Unable to instantiate journalEntry1")
        }
        
        guard let journalEntry2 = JournalEntry(rateing: 0, title: "Bad", body: "Today is Bad day", photo: photo2 ,latitude: 37.493912, longitude: 126.826153 ) else {
            fatalError("Unable to instantiate journalEntry2")
        }
        
        guard let journalEntry3 = JournalEntry(rateing: 3, title: "Ok", body: "Today is Ok day", photo: photo3) else {
            fatalError("Unable to instantiate journalEntry3")
        }
        
        journalEntries += [journalEntry1, journalEntry2, journalEntry3]
    }
}
