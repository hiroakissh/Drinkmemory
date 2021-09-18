//
//  SendToDBModel.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/09/13.
//

import Foundation
import FirebaseStorage

protocol SendDBOKdelegate {
    
    func sendDBOKdelegate(url:String)
    
}

class SendoToDBModel {
    
    var sendDBOKdelegate:SendDBOKdelegate?
    
    init (){
        
    }
    
    func sendDrinktextData(name:String,janlu:String){
        
//        let drinkname = UITextField(name: String)
//        let janlu     = UITextField(janlu: )
        
    }
    
    func sendDrinkImageData(data:Data){
        
        let image = UIImage(data: data)
        let profileImage = image?.jpegData(compressionQuality: 0.1) //1/10に圧縮
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        
        imageRef.putData(profileImage!, metadata: nil) { (metaData, error) in
            
            if error != nil{
                print(error.debugDescription)
                return
        }
            
            imageRef.downloadURL {  (url, error) in
                
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "userImage")
                self.sendDBOKdelegate?.sendDBOKdelegate(url:url!.absoluteString)
                
            }
            
        }
        
        
    }
    
}
   
