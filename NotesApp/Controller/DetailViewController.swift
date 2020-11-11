//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Баир Надцалов on 11.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    var textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        navigationController?.isToolbarHidden = true
        
        configureTextView()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    // MARK: - Configigure text view
    
    func configureTextView() {
        
        textView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        textView.text = "test text"
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
        
        //save note and send data to main controller
        //dismiss keyboard
    }
    
    @objc func showKeyboard() {
        
        
    }
    
    @objc func hideKeyboard() {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
