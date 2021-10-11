//
//  ViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var crateaccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIsetting()
        
        // Do any additional setup after loading the view.
    }
    func UIsetting() {
        
        signinButton.layer.cornerRadius = 20.0
        crateaccountButton.layer.cornerRadius = 20.0
        
    }
    


}

