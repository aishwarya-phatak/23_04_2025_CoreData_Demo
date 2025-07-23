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
//      deleteStudentRecord()
        print("\n ------------------- After Deletion -------------------\n")
//      deleteStudentRecord()
//        updateStudentRecord()
//        retriveStudentRecords()
    }
    
    func getManagedContext()->NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }

    func insertStudentRecord(){
        let mContext = getManagedContext()
        
        let studentEntity = NSEntityDescription.entity(forEntityName: "Student",
                                                       in: mContext)
        
        let studentObject1 = NSManagedObject(entity: studentEntity!, insertInto: mContext)
        
        studentObject1.setValue("student1", forKey: "name")
        studentObject1.setValue("student110@gmail.com", forKey: "email")
        
//        let studentObj1 = NSManagedObject(entity: studentEntity!, insertInto: mContext)
//
//        studentObj1.setValue("Saurabh", forKey: "name")
//        studentObj1.setValue("saurabh.thakare@gmail.com", forKey: "email")
//        
//
//        let studentObj2 = NSManagedObject(entity: studentEntity!, insertInto: mContext)
//
//        studentObj2.setValue("Sauchita", forKey: "name")
//        studentObj2.setValue("suchita.tagare@gmail.com", forKey: "email")
//        
//        for i in 1...5{
//            let studentObj = NSManagedObject(entity: studentEntity!, insertInto: mContext)
//            studentObj.setValue("student\(i)", forKey: "name")
//            studentObj.setValue("student\(i)@gmail.com", forKey: "email")
//        }
//        
        do{
            try mContext.save()
        }catch{
            print("error occurred")
        }
    }
    
    func retriveStudentRecords(){
        let context1 = getManagedContext()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        let studentRecords = try! context1.fetch(fetchRequest) as! [NSManagedObject]
        
        for eachStudentObject in studentRecords{
            let extractedName = eachStudentObject.value(forKey: "name")
            let extractedEmail = eachStudentObject.value(forKey: "email")
            
            print("name -- \(extractedName!) ------ email -- \(extractedEmail!)")
        }
        
        do{
            try context1.save()
        }catch{
            print(error)
        }
    }
    
    func deleteStudentRecord(){
        let context1 = getManagedContext()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let predicate1 = NSPredicate(format: "name = %@", "Sauchita")
        
        fetchRequest.predicate = predicate1
        
        let studentRecords = try! context1.fetch(fetchRequest)
        
        let objectToBeDeleted = studentRecords[0] as! NSManagedObject
        
        context1.delete(objectToBeDeleted)
        
        do{
            try context1.save()
        }catch{
            print(error)
        }
    }
    
    func updateStudentRecord(){
        let context1 = getManagedContext()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")

        let predicate1 = NSPredicate(format: "email = %@", "student110@gmail.com")
        
        fetchRequest.predicate = predicate1
        
        let fetchedResults = try! context1.fetch(fetchRequest) as! [NSManagedObject]
        
        let objectToBeUpdated = fetchedResults[0]
        
        objectToBeUpdated.setValue("Prajakta", forKey: "name")
        objectToBeUpdated.setValue("prajakta.123@gmail.com", forKey: "email")
        
        do{
            try context1.save()
        }catch{
            print(error)
        }
    }
}
