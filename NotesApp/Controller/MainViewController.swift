//
//  MainViewController.swift
//  NotesApp
//
//  Created by Баир Надцалов on 11.11.2020.
//

import UIKit

class MainViewController: UITableViewController {
    
    lazy var notes: [Note] = {
        let notes = [Note]()
        return notes
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)

        configureNavigationController()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.isToolbarHidden = false
    }
    
    // MARK: - Screen view configirurations
    
    func configureNavigationController() {
        
        //set style
        navigationItem.title = "Notes"
        navigationController?.toolbar.tintColor = #colorLiteral(red: 1, green: 0.5612351894, blue: 0, alpha: 1)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        //Navigation items
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        let notesCountText = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: .none)
        
        toolbarItems = [notesCountText, add]
        
        navigationController?.isToolbarHidden = false
        
    }
    
    // MARK: - Actions
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let title = notes[indexPath.row].title
        let text = notes[indexPath.row].body
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = text
        cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation

    @objc func addNote() {
        
        let vc = DetailViewController()
        vc.noteSenderDelegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension MainViewController: NoteSenderDelegate {
    
    func updateNote(note: Note) {

        notes.append(note)
        tableView.reloadData()
    }
    
}
