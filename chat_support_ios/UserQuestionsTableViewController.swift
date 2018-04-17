//
//  ViewController.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 4/11/18.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import UIKit
import CoreData

class UserQuestionsTableViewController: UITableViewController, DetailsParametersControllerProtocol, NewQuestionDelegate {
    
    var mockData = [QuestionEntity]()
    var selectedQuestionID:Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request : NSFetchRequest<QuestionEntity> = QuestionEntity.fetchRequest()
        
        do{
            try mockData = context.fetch(request)
        }catch{
            print("Error getting entities \(error)")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Table data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        //Do something with the cell
        cell.textLabel?.text = mockData[indexPath.row].messageDetail
        
        cell.accessoryType = mockData[indexPath.row].syncronized ? .checkmark : .detailButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        let cell = tableView.cellForRow(at: indexPath)
        
        mockData[indexPath.row].syncronized = !mockData[indexPath.row].syncronized
        cell?.accessoryType = mockData[indexPath.row].syncronized ? .checkmark : .detailButton
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedQuestionID = indexPath.row
        
        tableView.rectForRow(at: indexPath)
        
        performSegue(withIdentifier: "QuestionDetailSegue", sender: nil)
    }
    
    func getQuestionId() -> Int{
        return self.selectedQuestionID
    }
    
    func addNewQuestion(question: QuestionEntity) {
        mockData.append(question)
        
        tableView.reloadData()
    }
    
    func getQuestionDetail() -> String {
        return mockData[self.selectedQuestionID].messageDetail!
    }
    
    //MARK - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "QuestionDetailSegue"){
            let controller = segue.destination as? QuestionDetailViewController
            controller?.questionDetailDelegate = self
        }else if(segue.identifier == "newQuestionSegue"){
            let controller = segue.destination as? NewQuestionViewController
            controller?.delegate = self
        }
    }
}
