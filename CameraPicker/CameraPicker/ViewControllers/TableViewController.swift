//
//  File.swift
//  CameraPicker
//
//  Created by ilomidze on 06.05.21.
//

import Foundation
import UIKit


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //-
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        picturesData.count
    }
    
    //-
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as? PreviewCell else
        {
            fatalError("Cant Get Cell For Table")
        }
        
        cell.selectionStyle = .none
        
        let picData = picturesData[indexPath.row]
        cell.initCell(picData: picData, at: indexPath.row)
        
        return cell
    }
    
    //-
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {     
        guard let vc = storyboard?.instantiateViewController(identifier: "DetailedViewController") as? DetailedViewController
        else {
            fatalError("Cant instantiate DetailedViewController")
        }
        
        let picData = picturesData[indexPath.row]
        vc.imageData = picData.picture
        vc.title = picData.name
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //-
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            picturesData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            
            let coreDataManager = CoreDataManager()
            coreDataManager.removeCoreDataElem(ind: indexPath.row)
        }
    }
}
