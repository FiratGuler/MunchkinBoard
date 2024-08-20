//
//  HomeCell.swift
//  MunchkinBoard
//
//  Created by Fırat Güler on 1.06.2024.
//

import UIKit

protocol HomeCellDelegate {
    func didChangeSegmented(in cell : HomeCell ,to index: Int)
    func didDeleteClicked(in cell : HomeCell)
}

class HomeCell: UITableViewCell {

    @IBOutlet weak var charSkin: UIImageView!
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var skinSegmented: UISegmentedControl!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate : HomeCellDelegate?
    var textFieldChange : ((String) -> Void)?
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.didDeleteClicked(in: self)
    }
    @IBAction func skinSegmented(_ sender: UISegmentedControl) {
        delegate?.didChangeSegmented(in: self, to: skinSegmented.selectedSegmentIndex)
    }
    
    func configure (setup : SetupCharacter) {
        charSkin.image = UIImage(named: setup.imageName)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerName.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
extension HomeCell : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text{
            textFieldChange?(text)
        }
    }
  
}
