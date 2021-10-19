//
//  AccountViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/09/12.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextFiled: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var ChangeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let checkModel = CheckPermission()
        checkModel.showCheckPermission()

        
    }
    
    
    func UISetting(){
        
        usernameTextFiled.layer.cornerRadius = 15.0
        backButton.layer.cornerRadius = 20.0
        logoutButton.layer.cornerRadius = 20.0
        ChangeButton.layer.cornerRadius = 20.0
        
        
    }
    
    @IBAction func logout(_ sender: Any) {
        //ログアウトして一番最初の画面に戻る
        let firabaseAuth = Auth.auth()
        do{
            try firabaseAuth.signOut()
        }catch let signOutError as NSError{
            print("Error signing out: %@", signOutError)
            return
        }
        
        performSegue(withIdentifier: "mainbackVC", sender: nil)
    }
    
    
    
    @IBAction func Changeprofile(_ sender: Any) {
        //画像とユーザネームの変更
//        //画像が選択されてなくても大丈夫なオプションに変更
//        if usernameTextFiled.text?.isEmpty != true && let image = profileImageView.image{
//
//
//        }
        
        
    }
    
    @IBAction func tapImageView(_ sender: Any) {
        //カメラからアルバムから
        showAlert()
        
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
            profileImageView.image = selectedImage
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
    
    
    @IBAction func backbuton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
