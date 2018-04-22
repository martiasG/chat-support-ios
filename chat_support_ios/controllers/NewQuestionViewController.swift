//
//  NewQuestionViewController.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 4/14/18.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import UIKit

protocol NewQuestionDelegate {
    func addNewQuestion(question:QuestionDto)
}

class NewQuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate{
    let type = ["SDK", "Firmware", "Custom", "Manuals"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.type.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    
    var delegate:NewQuestionDelegate?
    
    //MARK - Outlets
    @IBOutlet weak var issueTypePicker: UIPickerView!
    @IBOutlet weak var subjetTextArea: UITextField!
    @IBOutlet weak var detailTextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        issueTypePicker.delegate = self
        issueTypePicker.dataSource = self
        subjetTextArea.delegate = self
        detailTextArea.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK -Actions
    @IBAction func onSaveButtonPressed(_ sender: Any) {
        let questionDto = QuestionDto()
        questionDto.title = subjetTextArea.text
        questionDto.description = detailTextArea.text
        questionDto.type = type[issueTypePicker.selectedRow(inComponent: 0)]
        
        delegate?.addNewQuestion(question: questionDto)
        
        QuestionService.instance.saveNewQuestion(questionDto)
        
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        detailTextArea.becomeFirstResponder()
        
        //By returning no the new line wont be passed over to the textView
        return false
    }
    
    /* Updated for Swift 4 */
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
