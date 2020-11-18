//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Баир Надцалов on 11.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    var textView = UITextView()
    weak var noteSenderDelegate: NoteSenderDelegate?
    
    var currentNote: Note?
    var noteIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        //change this button later to instant save when user type or change a note
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        
        configureTextView()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
    }
    
    // MARK: - Configigure text view
    
    func configureTextView() {
        
        if let note = currentNote {
            textView.text = note.text
        } else {
            textView.text = ""
        }
        
        textView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    // MARK: - Action
    
    @objc func saveNote() {
        
        //dismiss keyboard
        
        guard let text = textView.text else { return }
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentTime = dateFormatter.string(from: date)
        
        if let index = noteIndex {
            
            noteSenderDelegate?.updateNote(text: text, date: currentTime, at: index)
        } else {
            let newNote = Note(text: text, date: currentTime)
            noteSenderDelegate?.newNote(note: newNote)
        }
        
        
    }
    
    @objc func showKeyboard() {
        
        
    }
    
    @objc func hideKeyboard() {
        
    }

}
