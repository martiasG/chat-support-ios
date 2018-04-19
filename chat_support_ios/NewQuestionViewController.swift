//
//  NewQuestionViewController.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 4/14/18.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import UIKit

protocol NewQuestionDelegate {
    func addNewQuestion(question:QuestionEntity)
}

class NewQuestionViewController: UIViewController {
    var delegate:NewQuestionDelegate?
    
    //MARK - Outlets

//    @IBOutlet weak var DetailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK -Actions
    @IBAction func onSaveButtonPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let question = QuestionEntity(context: context)
//        question.messageDetail = DetailTextField.text
        
         (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        delegate?.addNewQuestion(question: question)
        
        navigationController?.popViewController(animated: true)
    }
    
}
