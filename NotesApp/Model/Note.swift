//
//  Note.swift
//  NotesApp
//
//  Created by Баир Надцалов on 11.11.2020.
//

import Foundation

class Note: NSObject, NSCoding {
    
    var text: String
    var date: String

    init (text: String, date: String) {
        
        self.text = text
        self.date = date
    }
    
    required init?(coder: NSCoder) {
        text = coder.decodeObject(forKey: "text") as? String ?? ""
        date = coder.decodeObject(forKey: "date") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(text, forKey: "text")
        coder.encode(date, forKey: "date")
    }
    
}

