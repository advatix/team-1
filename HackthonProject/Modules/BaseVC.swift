//
//  BaseVC.swift
//  HackthonProject
//
//  Created by prashant-iOS on 25/09/21.
//

import UIKit
import FirebaseFirestore

class AppUtility: NSObject {
    static func initViewController(storyBoard:String, vcIdentifier:String) -> UIViewController  {
        let controller = UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: vcIdentifier)
        return controller
    }
}

class BaseVC: UIViewController {

    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackButton()
        // Do any additional setup after loading the view.
    }
    
    func initBackButton(){
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.barStyle = .black
        //
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
}
