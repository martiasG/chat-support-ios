//
//  ViewController.swift
//  chat_support_ios
//
//  Created by Matias Gonzalez on 4/11/18.
//  Copyright © 2018 Matias Gonzalez. All rights reserved.
//

import UIKit

class UserQuestionsTableViewController: UITableViewController, DetailsParametersControllerProtocol {
    
    let mockData = ["1", "2", "3", "4", "5"]
    var selectedQuestionID:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Table data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        //Do something with the cell
        cell.textLabel?.text = mockData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if(cell?.accessoryType == .checkmark){
            cell?.accessoryType = .none
        }else{
            cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedQuestionID = indexPath.row
        performSegue(withIdentifier: "QuestionDetailSegue", sender: nil)
    }
    
    func getQuestionId() -> Int{
        return self.selectedQuestionID
    }
    
    //MARK - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "QuestionDetailSegue"){
            let controller = segue.destination as? QuestionDetailViewController
            controller?.questionDetailDelegate = self
        }
    }
}
