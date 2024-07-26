//
//  File.swift
//  Socially-UIKit
//
//  Created by 차지용 on 7/25/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

struct Post: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    var description: String?
    var imageURL: String?
    var path: String?
    @ServerTimestamp var datePublished: Date?
    
    init?(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        self.description = document.data()["description"] as? String
        if let url = document.data()["imageURL"] as? String {
            self.imageURL = url
        }
        if let path = document.data()["path"] as? String {
            self.path = path
        }
    }
    
    func checkImageURL(_ path: String) {
        let thumbRef = Storage.storage().reference().child("thumbs/\(path)_320x200")
        thumbRef.downloadURL { url, error in
            if error  != nil {
                return
            }
            
            if let url = url,
               let docId = self.id {
                Firestore.firestore().collection("Posts")
                    .document(docId)
                    .setData(["imageURL": url.absoluteString])
            }
        }
    }
}
