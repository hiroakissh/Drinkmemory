//
//  AddViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var jamluTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var AddButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UISetting()

        // Do any additional setup after loading the view.
    }
    
    func UISetting(){
        
        backgroundLabel.layer.cornerRadius = 20.0
        nameTextField.layer.cornerRadius = 15.0
        jamluTextField.layer.cornerRadius = 15.0
        commentTextField.layer.cornerRadius = 15.0
        AddButton.layer.cornerRadius = 20.0
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

