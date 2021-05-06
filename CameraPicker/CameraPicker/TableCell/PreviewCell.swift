//
//  PreviewCell.swift
//  CameraPicker
//
//  Created by ilomidze on 03.05.21.
//

import UIKit


class PreviewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var pictureNameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    var picData: PicData!
    var indexPathRow: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pictureNameTextField.delegate = self
        
        if picData == nil {
            picData = PicData()
        }
        if indexPathRow == nil {
            indexPathRow = 0
        }
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initCell(picData: PicData, at indexPathRow: Int) {
        self.picData = picData
        self.indexPathRow = indexPathRow
        
        picImageView.image = UIImage(data: picData.picture)
        pictureNameTextField.text = picData.name
        dateLabel.text = picData.date
        placeLabel.text = picData.location
    }
    
    // picture name text setting and storing in data
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let picName = textField.text {
            pictureNameTextField.text = textField.text
            picData.name = picName
            
            let coreDataManager = CoreDataManager()
            coreDataManager.modifyName(name: picName, at: indexPathRow)
        }
        return true
    }
    
}
