//
//  CategoryViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func UISetting(){
        
//        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], for: .selected)
        
    }

    @IBAction func segmentedControl(_ sender: Any) {
        
        
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
