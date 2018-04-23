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
    @IBOutlet weak var subjectRequiredLabel: UILabel!
    @IBOutlet weak var detailRequiredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        issueTypePicker.delegate = self
        issueTypePicker.dataSource = self
        subjetTextArea.delegate = self
        detailTextArea.delegate = self
        
        QuestionService.instance.syncQuestion()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK -Actions
    @IBAction func onSaveButtonPressed(_ sender: Any) {
        subjectRequiredLabel.isHidden = true
        detailRequiredLabel.isHidden = true
        
        if(subjetTextArea.text!.isEmpty){
            subjetTextArea.becomeFirstResponder()
            subjectRequiredLabel.isHidden = false
            return
        }else if(detailTextArea.text!.isEmpty){
            detailTextArea.becomeFirstResponder()
            detailRequiredLabel.isHidden = false
            return
        }
        
        if(!UserDao.instance.userRegistrationIsComplete()){
            let alert = UIAlertController(title: "User Registration is not complete", message: "It's recommended you complete it before continuing.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Complete Registration?", style: .default, handler: {
                action in
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "userProfileSegue", sender: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }))
            
            self.present(alert, animated: true)
            
            return
        }
        
        let questionDto = QuestionDto()
        questionDto.title = subjetTextArea.text
        questionDto.description = detailTextArea.text
        questionDto.type = type[issueTypePicker.selectedRow(inComponent: 0)]
        delegate?.addNewQuestion(question: questionDto)
        
        let questionEntity = QuestionDao.instance.saveQuestion(question: questionDto)
        questionDto.id = questionEntity.objectID.uriRepresentation().absoluteString
        
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
