//
//  CategoryViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SDWebImage


class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addbutton: UIButton!
    
    //var userdrinkdatas:[String:[String]] = ["drinkname":[],"drinkimage":[]]
    var userdrinkdatas:[String:[String]] = ["drinkname":[],"drinkimage":[]]
    var janlu = "コーヒー"
    
    let user = Auth.auth().currentUser
    var db = Firestore.firestore()
    var imageString = String()
    
    let drinkdbmodel = DrinkDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.contentInset = UIEdgeInsets(top: 0.0,left: 5.0,bottom: 0.0,right: 5.0)
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        UISetting()
        configureTableView()
        loaddrinkdata(janlu: janlu)
        
        
        // Do any additional setup after loading the view.
    }
    
    func UISetting(){
        addbutton.layer.cornerRadius = 20.0
    }
    func configureTableView(){

//        tableView.rowHeight = 60
//        tableView.layer.cornerRadius = 20.0
//        tableView.clipsToBounds = true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(userdrinkdatas)
        //ここでFirebase内のデータの数を返す、senderで判別する
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return userdrinkdatas["drinkname"]!.count

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return userdrinkdatas["drinkname"]!.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let userdrinkdatasname = userdrinkdatas["drinkname"]![indexPath.row]
        let userdrinkdatasimage = userdrinkdatas["drinkimage"]![indexPath.row]
        
        
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 20.0
        cell.layer.shadowOffset = CGSize(width: 3, height: 1)
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5
        
        cell.drinknameLabel.text = userdrinkdatasname
        cell.drinkImage.sd_setImage(with: URL(string: userdrinkdatasimage),completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.5
//    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

//    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        view.tintColor = .clear //透明にする
//
//    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
   
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginHeaderView = UIView()
        marginHeaderView.backgroundColor = .clear
        return marginHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let marginFooterView = UIView()
        marginFooterView.backgroundColor = .clear
        return marginFooterView
    }
    
    
    
//    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        view.tintColor = .black //透明にする
//
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = .black
//    }
    

    


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

        loaddrinkdata(janlu: janlu)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    func loaddrinkdata(janlu: String) {
        db.collection(user!.uid).getDocuments { [self] (snapShot, error) in
            self.userdrinkdatas = ["drinkname":[],"drinkimage":[]]
            if error != nil{
                print(error.debugDescription)
                return
            }else{
                for document in snapShot!.documents {
                    let drinkdata = document.data()
                    print(janlu)
                    if (drinkdata["janlu"]! as! String == janlu){
                        self.userdrinkdatas["drinkname"]?.append(drinkdata["drinkname"] as! String)
                        self.userdrinkdatas["drinkimage"]?.append(drinkdata["imageString"] as! String)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.userdrinkdatas.count, section: 0)
                            print(indexPath)
                            //self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }else{
                        print("nomatch")
                    }
                }
            }
        }
    }

}
