//
//  AddViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseFirestore

class AddViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,SendDBOKdelegate{

    
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var jamluTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var AddButton: UIButton!
    
    var sendToDBModel = SendoToDBImageModel()
    var urlString = String()
    
    var db = Firestore.firestore()
    var imagestring = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UISetting()
        
        let checkModel = CheckPermission()
        checkModel.showCheckPermission()
        sendToDBModel.sendDBOKdelegate = self
        // Do any additional setup after loading the view.
    }
    
    func UISetting(){
        
        backgroundLabel.layer.cornerRadius = 20.0
        nameTextField.layer.cornerRadius = 15.0
        jamluTextField.layer.cornerRadius = 15.0
        commentTextField.layer.cornerRadius = 15.0
        AddButton.layer.cornerRadius = 20.0
        
    }
    
    @IBAction func addDrinkimage(_ sender: Any) {
        
        print("tapsucess")
        showAlert()
        
    }
    
    
    @IBAction func AddDrinklist(_ sender: Any) {
        
        UserDefaults.standard.setValue(nameTextField.text, forKey: "drinkname")
        performSegue(withIdentifier: "backmainVC", sender: nil)
        
        //dbに保存
//        if let drinkname = nameTextField.text, let janlu = jamluTextField.text,let sender = Auth.auth().currentUser?.email{
//            
//            db.collection(<#T##collectionPath: String##String#>).addDocument(data: ["sender":sender,"drinkname":drinkname,"janlu":janlu,"imageString":imagestring,"date":Date().timeIntervalSince1970]) { (error) in
//                
//                if error != nil{
//                    print(error.debugDescription)
//                    return
//                }
//                
//            }
//            
//        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

    func doCamera(){
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    func doAlbum(){
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if info[.originalImage] as? UIImage != nil{
            
            let selectedImage = info[.originalImage] as! UIImage
            drinkImageView.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか？", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            
            self.doCamera()
            
        }
        
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            
            self.doAlbum()
            
        }
        
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
    
    }
    
    //URLが返ってきたら画面遷移
    func sendDBOKdelegate(url: String) {
        urlString = url
        if urlString.isEmpty != true{
            self.performSegue(withIdentifier: "", sender: nil)
        }
    }
}

