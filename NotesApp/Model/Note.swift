//
//  Note.swift
//  NotesApp
//
//  Created by Баир Надцалов on 11.11.2020.
//

import Foundation

class Note: Codable {
    
    var title: String
    var body: String
    var date: Date

    init (title: String, body: String, date: Date) {
        
        self.title = title
        self.body = body
        self.date = date
    }
}

