//
//  ViewController.swift
//  CameraPicker
//
//  Created by ilomidze on 03.05.21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var camButton: UIButton!
    
    var picturesData = [PicData]()
    
    internal var locationManager: CLLocationManager?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PreviewCell", bundle: nil), forCellReuseIdentifier: "PreviewCell")
        prepUserLocation()
        loadCoreData()
    }
    
    
    // Loads core data to picturesData
    func loadCoreData() {
        let coreDataManager = CoreDataManager()
        picturesData = coreDataManager.fetchFromCoreData() ?? [PicData]()
    }
    
    
    
    //-
    @IBAction func camButAction(_ sender: Any) {
        let picker = UIImagePickerController()
        
        initPicker(picker: picker)
    }
    
    //-
    @IBAction func clearButAction(_ sender: Any) {
        let ac = UIAlertController(title: "Clear All The Data", message: "Are you sure? Data can't be restored", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { [weak self] _ in
            self?.picturesData.removeAll()
            
            let coreDataManager = CoreDataManager()
            coreDataManager.clearCoreData()
            
            self?.tableView.reloadData()
        }))
        present(ac, animated: true, completion: nil)
    }
}


