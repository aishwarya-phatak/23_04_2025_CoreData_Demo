//
//  ViewController.swift
//  23_04_2025_CoreData_Demo
//
//  Created by Vishal Jagtap on 21/07/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        insertStudentRecord()
        retriveStudentRecords()
        deleteStudentRecord()
        print("\n ------------------- After Deletion -------------------\n")
        retriveStudentRecords()
//        deleteStudentRecord()
//        updateStudentRecord()
    }

    func insertStudentRecord(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let studentEntity = NSEntityDescription.entity(forEntityName: "Student",
                                                       in: managedContext)
        
        let studentObj1 = NSManagedObject(entity: studentEntity!, insertInto: managedContext)
        
        studentObj1.setValue("Saurabh", forKey: "name")
        studentObj1.setValue("saurabh.thakare@gmail.com", forKey: "email")
        
        
        let studentObj2 = NSManagedObject(entity: studentEntity!, insertInto: managedContext)
        
        studentObj2.setValue("Sauchita", forKey: "name")
        studentObj2.setValue("suchita.tagare@gmail.com", forKey: "email")
        
        for i in 1...5{
            let studentObj = NSManagedObject(entity: studentEntity!, insertInto: managedContext)
            studentObj.setValue("student\(i)", forKey: "name")
            studentObj.setValue("student\(i)@gmail.com", forKey: "email")
        }
        
        do{
            try managedContext.save()
        }catch{
            print("error occurred")
        }
    }
    
    func retriveStudentRecords(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        let studentRecords = try! managedContext.fetch(fetchRequest) as! [NSManagedObject]
        
        for eachStudentObject in studentRecords{
            let extractedName = eachStudentObject.value(forKey: "name")
            let extractedEmail = eachStudentObject.value(forKey: "email")
            
            print("name -- \(extractedName!) ------ email -- \(extractedEmail!)")
        }
        
        do{
            try managedContext.save()
        }catch{
            print(error)
        }
    }
    
    func deleteStudentRecord(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let predicate1 = NSPredicate(format: "name = %@", "Sauchita")
        
        fetchRequest.predicate = predicate1
        
        let studentRecords = try! managedContext.fetch(fetchRequest)
        
        let objectToBeDeleted = studentRecords[0] as! NSManagedObject
        
        managedContext.delete(objectToBeDeleted)
        
        do{
            try managedContext.save()
        }catch{
            print(error)
        }
    }
    
//    func updateStudentRecord(){
//        
//        
//    }
}
