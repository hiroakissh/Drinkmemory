//
//  CheckPermission.swift
//  Drinkmemory
//
//  Created by HiroakiSaito on 2021/09/12.
//

import Foundation
import Photos


class CheckPermission{
    
    func showCheckPermission(){
        
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status){
            
            case .authorized:
                print("許可")
            
            case .denied:
                print("拒否")
                
            case .notDetermined:
                print("notDetermined")
                
            case .restricted:
                print("restricted")
                
            case .limited:
                print("limited")
                
            @unknown default: break
            
            }
            
        }
        
    }
    
}
