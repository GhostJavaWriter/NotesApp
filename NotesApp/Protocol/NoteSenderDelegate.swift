//
//  NoteSenderDelegate.swift
//  NotesApp
//
//  Created by Баир Надцалов on 12.11.2020.
//

import Foundation

protocol NoteSenderDelegate: class {
    
    func newNote(note: Note)
    
    func updateNote(text: String, date: String, at index: Int)
}
