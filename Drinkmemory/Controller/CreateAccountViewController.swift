//
//  CreateAccountViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateAccountViewController: UIViewController {
    
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func CreateAccountButton(_ sender: Any) {
        
        let email = emailTextField.text
        let password = passwordtextField.text
        
        if email?.isEmpty != true && password?.isEmpty != true{
            
            Auth.auth().createUser(withEmail: email!, password: password!) { [self](result,error) in
                if error != nil{
                    
                    print(error.debugDescription)
                    self.Label.text = "こちらのメールアドレスは既に存在している可能性があります"
                    
                }else{
                    
                    performSegue(withIdentifier: "mainVC2", sender: nil)
                    
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
