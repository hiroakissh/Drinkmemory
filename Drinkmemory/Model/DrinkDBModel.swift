//
//  DrinkDBModel.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/09/15.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class DrinkDBModel{
    
    let user = Auth.auth().currentUser
    
    let db = Firestore.firestore()
    
    init(){}
    
    
    func createDrinkData(_ drinkname: String, _ janlu: String, _ comment: String, _ imageurl: URL){
        
        db.collection(user!.uid).document(janlu).setData([
            "drinkname"    : drinkname,
            "comment"      : comment,
            "drinkimageurl": imageurl
        ])
        
    }
    
    func readDrinkData(_ janlu: String){
        
        db.collection(user!.uid).document(janlu).getDocument { (DocumentSnapshot, error) in
            
            if error != nil{
                print(error.debugDescription)
                return
            }else{
                
               // if let value =
                
            }
            
        }
        
    }
    
    func uploaddrinkimage(data:Data,_ drinkname:String){
        
        let image = UIImage(data: data)
        let drinkImage = image?.jpegData(compressionQuality: 0.1)
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child("drinkimage/" + user!.uid + drinkname + ".jpg")
        
        storageRef.putData(drinkImage!, metadata: nil) { (metaData, error) in
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                
                UserDefaults.standard.setValue(url?.absoluteString, forKey: "drinkimage")
                
            }
            
        }
        
        
    }
    //商品の名前、感想、画像を送る
//    {
//    "user":{
//        "coffee":{
//            "name":"sample",
//            "image":"imagestoragepath",
//            }
//        "blacktea":{
//            "name":"sample",
//            "image":"imagestoragepath",
//            }
//        }
//    }
    
    
}
