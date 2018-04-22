//
//  UserProfileControllerViewController.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 19/04/2018.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import UIKit
import CoreData

class UserProfileControllerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let countries = ["Argentina", "Chile", "Bolivia", "Paraguay"]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCountry:String?
    var user:UserEntity?
    
    //MARK: - Outlets
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var nameTextArea: UITextField!
    @IBOutlet weak var lastNameTextArea: UITextField!
    @IBOutlet weak var emailTextArea: UITextField!
    @IBOutlet weak var phoneNumberTextArea: UITextField!
    @IBOutlet weak var companyNameTextArea: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        let request : NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do{
            let users = try context.fetch(request)
            
            if(users.count > 0){
                user = users[0]
            }
        }catch{
            print("Error getting entities \(error)")
        }
        
        countryPicker.selectRow(0, inComponent: 0, animated: false)
        if(self.user != nil){
            nameTextArea.text = self.user?.name
            lastNameTextArea.text = self.user?.lastname
            phoneNumberTextArea.text = self.user?.phone
            emailTextArea.text = self.user?.email
            companyNameTextArea.text = self.user?.company
            countryPicker.selectRow(self.countries.index(of: (user?.country)!)!, inComponent: 0, animated: false)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }

    @IBAction func onSaveUserData(_ sender: Any) {
        if(self.user == nil){
            self.user = UserEntity(context: context)
        }
        
        self.user?.name = nameTextArea.text
        self.user?.lastname = lastNameTextArea.text
        self.user?.email = emailTextArea.text
        self.user?.phone = phoneNumberTextArea.text
        self.user?.company = companyNameTextArea.text
        self.user?.country = self.countries[countryPicker.selectedRow(inComponent: 0)]
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
