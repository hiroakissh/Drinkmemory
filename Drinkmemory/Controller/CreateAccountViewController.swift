//
//  CreateAccountViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI
import FirebaseAnonymousAuthUI

class CreateAccountViewController: UIViewController {
    
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIsetting()

        // Do any additional setup after loading the view.
    }
    
    func UIsetting() {
        
        emailTextField.layer.cornerRadius = 20.0
        passwordtextField.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        signinButton.layer.cornerRadius = 20.0
        createButton.layer.cornerRadius = 20.0
        
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
