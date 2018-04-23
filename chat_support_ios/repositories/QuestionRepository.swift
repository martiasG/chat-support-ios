//
//  QuestionRepository.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 22/04/2018.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class QuestionDao{
    static let instance:QuestionDao = QuestionDao()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveQuestion(question: QuestionDto) -> QuestionEntity{
        let questionEntity = QuestionEntity(context: context)
        questionEntity.title = question.title
        questionEntity.messageDetail = question.description
        questionEntity.type = question.type
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        return questionEntity
    }
    
    func updateQuestionStatus(objectId: String){
        let questions = getAllQuestionsEntities()
        for question in questions{
            if(objectId == question.objectID.uriRepresentation().absoluteString){
                question.syncronized = true
            }
        }
        
        do{
            try context.save()
        }catch{
            print("Error updating question with id: \(objectId)")
        }
    }
    
    func getAllQuestionsNotSynced() -> [QuestionDto]{
        let request : NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
        
        var questions:[QuestionEntity] = []
        do{
            try questions = self.context.fetch(request)
        }catch{
            print("Error getting entities \(error)")
        }
        
        var questionsDto:[QuestionDto] = []
        for question in questions{
            if(!question.syncronized){
                let questionDto = QuestionDto()
                questionDto.id = question.objectID.uriRepresentation().absoluteString
                questionDto.title = question.title
                questionDto.description = question.messageDetail
                questionDto.type = question.type
                questionDto.synced = question.syncronized
                questionsDto.append(questionDto)
            }
        }
        
        return questionsDto
    }
    
    func getAllQuestions() -> [QuestionDto]{
        let request : NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
        
        var questions:[QuestionEntity] = []
        do{
            try questions = self.context.fetch(request)
        }catch{
            print("Error getting entities \(error)")
        }
        
        var questionsDto:[QuestionDto] = []
        for question in questions{
            if(question.deleteDate == nil){
                let questionDto = QuestionDto()
                questionDto.id = question.objectID.uriRepresentation().absoluteString
                questionDto.title = question.title
                questionDto.description = question.messageDetail
                questionDto.type = question.type
                questionDto.synced = question.syncronized
                questionsDto.append(questionDto)
            }
        }
        
        return questionsDto
    }
    
    func getAllQuestionsEntities() -> [QuestionEntity]{
        let request : NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
        
        var questions:[QuestionEntity] = []
        do{
            try questions = self.context.fetch(request)
        }catch{
            print("Error getting entities \(error)")
        }
        
        return questions
    }
}
