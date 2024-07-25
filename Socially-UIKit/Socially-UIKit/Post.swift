//
//  File.swift
//  Socially-UIKit
//
//  Created by 차지용 on 7/25/24.
//

import Foundation
import FirebaseFirestore

struct Post: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    var description: String?
    var imageUR: String?
    @ServerTimestamp var datePublished: Date?
    
    init?(document: QueryDocumentSnapshot) {
        dump(document.data())
        self.id = document.documentID
        self.description = document.data()["description"] as? String
    }
}
