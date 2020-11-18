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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveNote))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        let notesCountText = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: .none)
        
        toolbarItems = [notesCountText, share]
        
        configureTextView()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustTextView), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustTextView), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    // MARK: - Configigure text view
    
    func configureTextView() {
        
        if let note = currentNote {
            textView.text = note.text
        } else {
            textView.text = ""
        }
        
        //show keyboard
        textView.becomeFirstResponder()
        
        textView.font = UIFont(name: "arial", size: 18)
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
        textView.endEditing(true)
        
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
    
    @objc func shareNote() {
        
        guard let note = textView.text else { return }
        
        let vc = UIActivityViewController(activityItems: [note], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func adjustTextView(notification: Notification) {
        
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
        
    }

}
