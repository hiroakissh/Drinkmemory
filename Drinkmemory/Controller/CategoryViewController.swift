//
//  CategoryViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addbutton: UIButton!
    
    var db = Firestore.firestore()
    var imageString = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        
        // Do any additional setup after loading the view.
    }
    
    func UISetting(){
        
        tableView.layer.cornerRadius = 15.0
        addbutton.layer.cornerRadius = 20.0
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        
        let drinkname = UserDefaults.standard.string(forKey: "drinkname")
        cell.drinknameLabel.text = drinkname
        
        return cell
    }
    
    func configureTableView(){
        
        tableView.rowHeight = 450
    }

    @IBAction func segmentedControl(_ sender: Any) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
