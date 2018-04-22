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
    var mockData = [QuestionDto]()
    var selectedQuestionID:Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var noQuestionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named:"home_background"))
        self.tableView.backgroundView?.alpha = 0.8
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
        
        mockData = QuestionDao.instance.getAllQuestions()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Table data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noQuestionLabel.isHidden = mockData.count > 0
        
        return mockData.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        //Do something with the cell
        cell.textLabel?.text = mockData[indexPath.row].description
        
        cell.accessoryType = mockData[indexPath.row].synced! ? .checkmark : .detailButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        cell?.accessoryType = mockData[indexPath.row].synced! ? .checkmark : .detailButton

        DispatchQueue.main.async {
            self.selectedQuestionID = indexPath.row
            self.performSegue(withIdentifier: "QuestionDetailSegue", sender: nil)
        }
    }
    
    func getQuestionId() -> Int{
        return self.selectedQuestionID
    }
    
    func addNewQuestion(question: QuestionDto) {
        mockData.append(question)
        let indexPath = IndexPath(row: mockData.count-1, section: 0)
        
        tableView.rectForRow(at: indexPath)
    }
    
    func getQuestionDetail() -> String {
        return mockData[self.selectedQuestionID].description!
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
