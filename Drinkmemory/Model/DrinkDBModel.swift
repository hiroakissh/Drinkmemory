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
    
     //drinkデータをFirebase Storeにデータを作成
    func createDrinkData(drinkname: String, janlu: String, comment: String, drinkimagestring: String, sender: String){
        
        db.collection(user!.uid).addDocument(
            data:["sender":sender,
                  "drinkname":drinkname,
                  "janlu":janlu,
                  "imageString":drinkimagestring,
                  "Comment":comment,
                  "date":Date().timeIntervalSince1970]) { (error) in
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            
        }
        
    }
    
    //drinkデータをユーザとジャンルごとに取得
    func readDrinkData(janlu: String) -> [String:[String]]{
        

        var datas:[String:[String]] = ["drinkname":[],"drinkimage":[]]
        
        db.collection(user!.uid).getDocuments { (snaps,error) in
            if error != nil {
                print(error.debugDescription)
                return
            }else{
                print(snaps?.documents as Any)
                guard let snaps = snaps else {return}
                for document in snaps.documents {
                    let drinkdata = document.data()
                    print("クラス内のジャンル" + janlu)
                    
                    if (drinkdata["janlu"]! as! String == janlu){
                        
                        datas["drinkname"]?.append(drinkdata["drinkname"]! as! String)
                        datas["drinkimage"]?.append(drinkdata["imageString"]! as! String)
                        //print(datas)
                    }else{
                        print("nomatch")
                    }
                
                }
            }
        }
        return datas
    }
    
     //drinkの画像データを圧縮してFirebasestorageに保存、UserDefalutに値を保存
    func uploaddrinkimage(data:Data, drinkname:String){
        
        
        let image = UIImage(data: data)
        let drinkImage = image?.jpegData(compressionQuality: 0.1)
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child(user!.uid + "/" + drinkname + ".jpg")
        
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
    
    
}
