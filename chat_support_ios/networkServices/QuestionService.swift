//
//  QuestionService.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 21/04/2018.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

public class QuestionService{
    static let instance = QuestionService()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveNewQuestion(_ question:QuestionDto){
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
        
        let parameters: Parameters = [
            "agent": "ZK_Center",
            "intfVer": "1.0.0",
            "lang": "zh-CN",
            "platform": "zkweb",
            "sessionId": "59F89739-5F8E-E72F-108E-13D74A592862",
            "sys": "ZK_Center",
            "tz": "-3:00",
            "payload": [
                "params": [
                    "id": "",
                    "name": user?.name,
                    "lastName": user?.lastname,
                    "email": user?.email,
                    "phone": user?.phone,
                    "countryName": user?.country,
                    "supplier": user?.company,
                    "category": question.type,
                    "serialNumber": "12342",
                    "software":"",
                    "questTitle": question.title,
                    "problemDesc": question.description, "uploadfile":"{'fileKey':'402858045e3c12c0015e3cbfdb34002a','name':'t3.jpg','time':'2017-09-01','realPath':'upload/files/20170901172240uOsANak2.jpg'}"
                ],
                "datafmt": 1
            ]
        ]
        
        Alamofire.request("http://service.zkteco.com/latinAmerica/cusTicket/save.action",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
            .responseData{ response in
                switch response.result{
                    case .success:
                        print("200OK \(response)")
                    case .failure(let error):
                        print("ERROR \(error)")
                }
            }
    }
}
