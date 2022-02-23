//
//  AddViewController.swift
//  MyReminders
//
//  Created by Eslam Ali  on 22/02/2022.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bodyField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    public var completion : ((String, String, Date) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyField.delegate = self
        titleField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapSaveButton(){
        if let title =  titleField.text, !title.isEmpty,
           let body =  bodyField.text, !body.isEmpty {
            let date  = datePicker.date
        
            self.completion?(title,body,date)
        }
    }

 

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
