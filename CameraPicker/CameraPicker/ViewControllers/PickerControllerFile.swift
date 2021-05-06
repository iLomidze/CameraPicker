//
//  PickerControllerFile.swift
//  CameraPicker
//
//  Created by ilomidze on 04.05.21.
//

import Foundation
import UIKit
import MapKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Set up picker for usage
    func initPicker(picker: UIImagePickerController) {
        picker.allowsEditing = true
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true)
    }
    
    // Take new photo and save it 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let pngData = image.pngData() {
            try? pngData.write(to: imagePath)
            
            let date = Date()
                        
            let picData = PicData(picture: pngData, name: "", date: date, location: "Loading Location...")
            picturesData.append(picData)
            
            setLocation(picData: picData)
            
            let coreDataManager = CoreDataManager()
            coreDataManager.saveToCoreData(picData: picData)
            
            tableView.reloadData()
        }
        dismiss(animated: true)
    }
    
    // Returns app documents directory
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    // Get coordinates and location
    func setLocation(picData: PicData) {
        locationManager?.requestLocation()
        
        var locationName = "Uknown Place"
        
        guard let location = locationManager?.location else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemark, error) in
            if error != nil {
                print("There was an error")
                return
            } else {
                if let place = placemark?[0] {
                    if let thoroughfare = place.subLocality {
                        locationName = thoroughfare
                    } else if let subLocality = place.locality {
                        locationName = subLocality
                    } else if let country = place.country {
                        locationName = country
                    } else {
                        return
                    }
                }
            }
            // App Specific Commands
            picData.location = locationName
            self?.tableView.reloadData()
            let coreDataManager = CoreDataManager()
            coreDataManager.modifyLocation(location: locationName, at: ((self?.picturesData.count)! - 1) )
        }
    }

}
