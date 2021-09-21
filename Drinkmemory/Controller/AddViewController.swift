//
//  AddViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseFirestore

class AddViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,SendDBOKdelegate{

    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var jamluTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var EmptyLabel: UILabel!
    
    var sendToDBModel = SendoToDBImageModel()
    var urlString = String()
    
    var pickerView:UIPickerView = UIPickerView()
    var janluList:[String] = ["コーヒ","紅茶","日本茶","中国茶","その他"]
    
    var db = Firestore.firestore()
    var imagestring = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UISetting()
        
        nameTextField.delegate = self
        jamluTextField.delegate = self
        commentTextField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, view.frame.size.width, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([doneItem,cancelItem], animated: true)
        
        self.jamluTextField.inputView = pickerView
        self.jamluTextField.inputAccessoryView = toolbar
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        jamluTextField.resignFirstResponder()
        commentTextField.resignFirstResponder()
        
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return janluList.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.jamluTextField.text = janluList[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return janluList[row]
    }
    
    @objc func cancel() {
        
        self.jamluTextField.text = ""
        self.jamluTextField.endEditing(true)
    }

    @objc func done() {
        self.jamluTextField.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
            return CGRect(x: x, y: y, width: width, height: height)
        }
    
    @IBAction func addDrinkimage(_ sender: Any) {
        
        print("tapsucess")
        showAlert()
        
    }
    
    
    @IBAction func AddDrinklist(_ sender: Any) {
        
        if nameTextField.text != "" && jamluTextField.text != "" && commentTextField.text != ""{
            print(nameTextField.text!)
            print(jamluTextField.text!)
            print(commentTextField.text!)
            
            UserDefaults.standard.setValue(nameTextField.text, forKey: "drinkname")
            
            //ImageをstorageにしてURL化する
            
            //dbに保存
            if let drinkname = nameTextField.text, let janlu = jamluTextField.text,
                let comment = commentTextField.text,
                let sender = Auth.auth().currentUser?.email{
                
                db.collection("drinkmemory").addDocument(
                    data:["sender":sender,
                          "drinkname":drinkname,
                          "janlu":janlu,
                          "imageString":imagestring,
                          "Comment":comment,
                          "date":Date().timeIntervalSince1970]) { (error) in
                    
                    if error != nil{
                        print(error.debugDescription)
                        return
                    }
                    
                    
                }
                performSegue(withIdentifier: "backmainVC", sender: nil)
            }
            
        }else {
            EmptyLabel.text = "記入されてない箇所があります"
            return
        }
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
        
        print("picker起動")
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

