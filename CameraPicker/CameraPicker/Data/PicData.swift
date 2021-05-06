//
//  picData.swift
//  CameraPicker
//
//  Created by ilomidze on 04.05.21.
//

import Foundation
import UIKit

class PicData: Codable {
    var picture: Data
    var name: String
    var date: String!
    var location: String
    
    init() {
        if let picture = UIImage(named: "NoImageAvailable")?.pngData() {
            self.picture = picture
        } else {
            fatalError("System File Missing")
        }
        
        name = ""
        location = "No Location"
        date = dateToString(date: Date())
        
    }
    
    init(picture: Data, name: String, date: Date, location: String) {
        self.picture = picture
        self.name = name
        self.location = location
        self.date = dateToString(date: date)
    }
    
    init(picture: Data, name: String, dateStr: String, location: String) {
        self.picture = picture
        self.name = name
        self.location = location
        self.date = dateStr
    }
    
    func dateToString(date: Date) -> String {
        let df  = DateFormatter()
        df.dateStyle = .short
        df.dateFormat = "dd.MM.yyyy"
        
        return df.string(from: date)
    }
    
    //ec
}

