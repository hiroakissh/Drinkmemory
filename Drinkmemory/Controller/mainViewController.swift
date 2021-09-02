//
//  mainViewController.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/08/31.
//

import UIKit
import Firebase
import FirebaseAuth


class mainViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapimageView(_ sender: Any) {
        
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.originalImage] as? UIImage != nil {
            
            let selectedImage = info[.originalImage] as! UIImage
            iconImageView.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "どちらを使いますか", preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.doCamera()
        }
        
        let actionAlbum = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.doAlbum()
        }
        
        let actionCancel = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(actionCamera)
        alertController.addAction(actionAlbum)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
        
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
