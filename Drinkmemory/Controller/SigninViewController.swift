//
//  SigninViewController.swift
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

class SigninViewController: UIViewController, FUIAuthDelegate {
    
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var createaccountButton: UIButton!
    
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    //認証に使用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth(),
        FUIEmailAuth(),
        FUIOAuth.twitterAuthProvider()
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UIsetting()
        
        //authUIのデリゲート
        self.authUI.delegate = self
        self.authUI.providers = providers
        

        // Do any additional setup after loading the view.
    }
    
    func UIsetting() {
        
        emailtextField.layer.cornerRadius = 20.0
        passwordtextField.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        signinButton.layer.cornerRadius = 20.0
        createaccountButton.layer.cornerRadius = 20.0
        
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
