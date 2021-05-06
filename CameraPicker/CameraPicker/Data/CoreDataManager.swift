//
//  CoreDataManager.swift
//  CameraPicker
//
//  Created by ilomidze on 05.05.21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    //-
    func saveToCoreData(picData: PicData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
          
        let managedContext = appDelegate.persistentContainer.viewContext
          
        let entity = NSEntityDescription.entity(forEntityName: "PicturesDataS", in: managedContext)!
          
        let picCoreData = NSManagedObject(entity: entity, insertInto: managedContext)
          
        picCoreData.setValue(picData.picture, forKeyPath: "picture")
        picCoreData.setValue(picData.name, forKeyPath: "name")
        picCoreData.setValue(picData.date, forKeyPath: "date")
        picCoreData.setValue(picData.location, forKeyPath: "location")
        
        do {
           try managedContext.save()
         } catch let error as NSError {
           print("Could not save. \(error), \(error.userInfo)")
         }
    }
    
    //-
    func fetchFromCoreData() -> [PicData]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Cant creade codeData shared delegate")
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PicturesDataS")
        
        do {
            let picturesNSManagedObjectData = try managedContext.fetch(fetchRequest)
            let picturesData = nsManagedObjectToPicturesData(nsmod: picturesNSManagedObjectData)
            return picturesData
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    //-
    func modifyName(name: String, at ind: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Cant creade codeData shared delegate")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PicturesDataS")
        
        do {
            let managedObject = try managedContext.fetch(fetchRequest)
            managedObject[ind].setValue(name, forKey: "name")
            try managedContext.save()
            print("name modified successfully")
            
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
    }

    //-
    func modifyLocation(location: String, at ind: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Cant creade codeData shared delegate")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PicturesDataS")
        
        do {
            let managedObject = try managedContext.fetch(fetchRequest)
            managedObject[ind].setValue(location, forKey: "location")
            try managedContext.save()
            print("Location modified successfully")
            
        } catch let error as NSError {
            print("Could not Save. \(error), \(error.userInfo)")
        }
    }
    
    //-
    func clearCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Cant creade codeData shared delegate")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PicturesDataS")

        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(batchDeleteRequest)

        } catch {
            print("Cannot Clear The Core Data")
        }
    }
    
    //-
    func removeCoreDataElem(ind: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Cant creade codeData shared delegate")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PicturesDataS")
        
        do {
            let managedObject = try managedContext.fetch(fetchRequest)
            managedContext.delete(managedObject[ind])
            try managedContext.save()
        } catch let error as NSError {
            print("Could not remove element \(error), \(error.userInfo)")
        }
    }
    
    
    // Creates PicData object from CoreData - NSManagedObject object
    func nsManagedObjectToPicturesData(nsmod: [NSManagedObject]) -> [PicData] {
        var picturesData = [PicData]()
        for item in nsmod {
            let picture = item.value(forKey: "picture") as! Data
            let name = item.value(forKey: "name") as! String
            print("\n\nname - \(name)\n\n")
            let date = item.value(forKey: "date") as! String
            let location = item.value(forKey: "location") as! String
            
            let picData = PicData(picture: picture, name: name, dateStr: date, location: location)
            
            picturesData.append(picData)
        }
        return picturesData
    }
    
}
