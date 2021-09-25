//
//  DriverLoginVC.swift
//  HackthonProject
//
//  Created by prashant-iOS on 25/09/21.
//

import UIKit
import FirebaseFirestore

class DriverLoginVC: BaseVC {

    @IBOutlet weak var texfield: UITextField!
    @IBOutlet weak var buttonAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ibaction(_ sender: Any) {
        if let text = texfield.text, !text.isEmpty{
            
            print("text==>", text)
            loginDriver(by: text)
        }
    }
    
    func loginDriver(by id:String){
        
        
        
        let query = database.collection("drivers")
                    .whereField("driverId", isEqualTo: id)
        
        
        query.getDocuments { (querySnapshot, err) in
            if let docs = querySnapshot?.documents {
                print("docs===>", docs)
                print("docs===>", docs.count)
                if docs.count == 0{
                    self.view.toastview(view: self.view, message: "Invalid User")
                }else{
                    self.GetRequestVC(docs: docs.first!)
                }
                //self.saveDataByRefrence(docs: docs)
                
            }else{
                self.view.toastview(view: self.view, message: "Invalid User")
            }
        }
    }
    
    func GetRequestVC(docs:QueryDocumentSnapshot){
        let vc = AppUtility.initViewController(storyBoard:"Main", vcIdentifier:"GetRequestVC") as! GetRequestVC
        vc.driver = docs
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
