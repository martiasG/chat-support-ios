//
//  QuestionDetailViewController.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 4/14/18.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import UIKit

protocol DetailsParametersControllerProtocol{
    func getQuestionId() -> Int
}

class QuestionDetailViewController: UIViewController {
    
    var questionDetailDelegate:DetailsParametersControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Question id selected: \(String(describing: questionDetailDelegate?.getQuestionId()))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
