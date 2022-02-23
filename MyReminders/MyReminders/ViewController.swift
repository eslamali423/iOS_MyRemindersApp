//
//  ViewController.swift
//  MyReminders
//
//  Created by Eslam Ali  on 22/02/2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabelView: UITableView!
    var model = [Reminders]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate =  self
        tabelView.dataSource = self
    // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapTestButton(_ sender: Any) {
    // allow the noitification to use the app
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                print("success ")
                self.confguireTest()
            }
            else {
                print("error ouccerd ")
            }
        }}
    
    func confguireTest()   {
        let content =  UNMutableNotificationContent()
        content.title = "hello"
        content.body = "this is long body for notification. this is long body for notification. this is long body for notification."
        content.sound = .default
        
        let targetDate =  Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour , .minute, .second], from: targetDate), repeats: false)
        
        let request =  UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("something went worng")
            }
            
        }
        
    }
    
    
    @IBAction func didTapAddButton(_ sender: Any) {
        // move to add view vontroller
        let addVC = storyboard?.instantiateViewController(identifier: "addID") as! AddViewController
        addVC.modalPresentationStyle = .fullScreen
        addVC.title = "Add New Reminder"
        addVC.navigationItem.largeTitleDisplayMode = .never
        addVC.navigationItem.backBarButtonItem?.title = "Back"
        addVC.completion = { title , body , date in
         // to do it in the main thread
           
           
            self.navigationController?.popToRootViewController(animated: true)
            let new  = Reminders(title: title, body: body, date: date)
            self.model.append(new)
            self.tabelView.reloadData()
            
   
            let content =  UNMutableNotificationContent()
                content.title =  title
                content.body = body
                content.sound = .default
                let triggerDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate), repeats: false)
            
                let request  =  UNNotificationRequest(identifier: "some_id", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { (error) in
                    if error != nil {
                        print("something went wrong")
                    }
                }
          
            
        }

        
        
        navigationController?.pushViewController(addVC, animated: true)
    }
    // tabelview fucntions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data =  model[indexPath.row]
        cell.textLabel?.text = data.title
        return cell
    }
    


}// view controller

struct Reminders {
  var  title  : String
   var body : String
    var date :  Date
}

