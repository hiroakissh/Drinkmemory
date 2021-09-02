//
//  SigninViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseAuth

class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var Label: UILabel!
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignInButton(_ sender: Any) {
        
        let email = emailtextField.text
        let password = passwordtextField.text
        
        if email?.isEmpty != true && password?.isEmpty != true{
            
            Auth.auth().signIn(withEmail: email!, password: password!) { [self] (result,error) in
                
                if error != nil{
                    print(error.debugDescription)
                    self.Label.text = "アカウントが存在しません\n新規登録するか、再度お試しください"
                    
                }else{
                    
                    performSegue(withIdentifier: "mainVC", sender: nil)
                    
                }
                
            }
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
