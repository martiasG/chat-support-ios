//
//  Queue.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 21/04/2018.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import Foundation

public class RequestQueue{
    let userDefault = UserDefaults.standard
    
    static let instance:RequestQueue = RequestQueue()
    
    func insertNewRequest(_ question : QuestionEntity){
        var queue:[Int] = userDefault.array(forKey: "request_queue") ?? [Int]() as! [Int]

        var lastId:Int = queue.popLast() ?? 0

        question.requestId = lastId++
            
        queue.append(Int(question.requestId))
        userDefault.set(queue, forKey: "request_queue")
    }
}
