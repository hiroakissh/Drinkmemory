//
//  CategoryViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseFirestore


class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addbutton: UIButton!
    
    //var userdrinkdatas:[String:[String]] = ["drinkname":[],"drinkimage":[]]
    var userdrinkdatas = [String:[String]]()
    var janlu = "コーヒー"
    

    var db = Firestore.firestore()
    var imageString = String()
    
    let drinkdbmodel = DrinkDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        UISetting()
        configureTableView()
        
        
        // Do any additional setup after loading the view.
    }
    
    func UISetting(){
        
        tableView.layer.cornerRadius = 15.0
        addbutton.layer.cornerRadius = 20.0
    }
    func configureTableView(){
        
        tableView.rowHeight = 60
        tableView.layer.cornerRadius = 20.0
        tableView.clipsToBounds = true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("セルの数を決めるとき" + janlu)
        userdrinkdatas = drinkdbmodel.readDrinkData(janlu: janlu)
        
        print("最初に呼ばれる辞書")
        print(userdrinkdatas)
        //ここでFirebase内のデータの数を返す、senderで判別する
        return userdrinkdatas["drinkname"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let drinkname = UserDefaults.standard.string(forKey: "drinkname")
        
        //UI
        cell.layer.cornerRadius = 20.0
        cell.layer.masksToBounds = true
        
        cell.drinknameLabel.text = drinkname
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 //セルの下部のスペース
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let view = UIView()
        view.tintColor = .clear //透明にする
        
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
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    

}
