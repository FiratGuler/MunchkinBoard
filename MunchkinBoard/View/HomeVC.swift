//
//  ViewController.swift
//  MunchkinBoard
//
//  Created by Fırat Güler on 1.06.2024.
//

import UIKit

struct SetupCharacter {
    var name : String
    var imageName : String
    var segmentIndex : Int
    var deleteVisible : Bool
}

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewButton: UIButton!
    
    var setupArray : [SetupCharacter] = [
        SetupCharacter(name: "player", imageName: "meeple_1", segmentIndex: 0, deleteVisible: true),
        SetupCharacter(name: "player", imageName: "meeple_1", segmentIndex: 0, deleteVisible: true),
        SetupCharacter(name: "player", imageName: "meeple_1", segmentIndex: 0, deleteVisible: true)
    ] {
        didSet {
            checkAddButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func checkAddButton() {
        if setupArray.count < 6 {
            addNewButton.isEnabled = true
        } else {
            addNewButton.isEnabled = false
        }
    }
    
    @IBAction func addNewbuttonClick(_ sender: UIButton) {
        
        setupArray.append(SetupCharacter(name: "player", imageName: "meeple_1", segmentIndex: 0, deleteVisible: false))
        tableView.reloadData()
    }
    
    
    @IBAction func playButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "toBoardVC", sender: [setupArray])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBoardVC" {
            let destination = segue.destination as! BoardVC
            destination.charArray = setupArray
        }
    }
    
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource, HomeCellDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        cell.configure(setup: setupArray[indexPath.row])
        cell.deleteButton.isHidden = setupArray[indexPath.row].deleteVisible
        cell.textFieldChange = { textChar in
            self.setupArray[indexPath.row].name = textChar
        }
        cell.delegate = self
        cell.selectionStyle = .none
        
        
        return cell
        
    }
    
    func didChangeSegmented(in cell: HomeCell, to index: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        
        setupArray[indexPath.row].imageName = "meeple_\(index + 1)"
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func didDeleteClicked(in cell: HomeCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        setupArray.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    
}

