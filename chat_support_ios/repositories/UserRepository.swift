//
//  UserRepository.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 22/04/2018.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class UserDao{
    static let instance:UserDao = UserDao()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func userRegistrationIsComplete() -> Bool{
        let request : NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        var user:UserEntity?
        do{
            let users = try context.fetch(request)
            
            if(users.count > 0){
                user = users[0]
            }
        }catch{
            print("Error getting entities \(error)")
        }
        
        if((user?.company?.isEmpty)! ||
            (user?.country?.isEmpty)! ||
            (user?.email?.isEmpty)! ||
            (user?.phone?.isEmpty)! ||
            (user?.name?.isEmpty)! ||
            (user?.lastname?.isEmpty)! ||
            (user?.email?.isEmpty)!){
            return false
        }
        
        return true
    }
}
