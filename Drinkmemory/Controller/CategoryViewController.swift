//
//  CategoryViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage


class CategoryViewController: UIViewController {
    
    @IBOutlet var categoryview: CatergoryView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var addbutton: UIButton!
    
    var userdrinkdatas:[String:[String]] = ["drinkname":[],"drinkimage":[]]
    var janlu = "コーヒー"
    
    let user = Auth.auth().currentUser
    var db = Firestore.firestore()
    var imageString = String()
    
    let drinkModel = DrinkDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UISetting()
        
        drinkModel.notificationCenter.addObserver(self, selector: #selector(self.ChangeCell(_:)), name: .init( NSNotification.Name(rawValue: DrinkDBModel.notificationName)), object: nil)
 
        // Do any additional setup after loading the view.
    }
    
    func UISetting(){
        addbutton.layer.cornerRadius = 20.0
    }
    
    @objc func ChangeCell(_ notification: Notification){
        
        categoryview.previewCell()
        
    }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0: janlu = "コーヒー"
        case 1: janlu = "紅茶"
        case 2: janlu = "日本茶"
        case 3: janlu = "中国茶"
        case 4: janlu = "その他"
        default:
            janlu = "コーヒー"
        }
        categoryview.loaddrinkdata(janlu: janlu)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    

}
