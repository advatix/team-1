//
//  GetRequestVC.swift
//  HackthonProject
//
//  Created by prashant-iOS on 25/09/21.
//

import UIKit
import FirebaseFirestore

class GetRequestVC: BaseVC {

    var driver:QueryDocumentSnapshot?
    
    var resultByDB: [QueryDocumentSnapshot] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData(by: "")
    }
    

    func initTableView(){
        // config tableView
        tableView.rowHeight     = UITableView.automaticDimension
        tableView.dataSource    = self
        tableView.tableFooterView = UIView()
        
        // Auto resizing the height of the cell
        self.tableView.layoutMargins    = UIEdgeInsets.zero
        self.tableView.separatorInset   = UIEdgeInsets.zero
        tableView.estimatedRowHeight    = 44.0
        tableView.rowHeight             = UITableView.automaticDimension
        // cell setup
        tableView.register(UINib(nibName: "BroadCastRequestTVCell", bundle: nil), forCellReuseIdentifier: "BroadCastRequestTVCell")
    }

    func getData(by name:String){
        
        let driverId = driver?.data()["driverId"]!
        
        //print("driverId==>",driverId)
        let query = database.collection("job")
                    .whereField("driverId", isEqualTo: driverId)
        
        query.addSnapshotListener { (querySnapshot, err) in
            if let docs = querySnapshot?.documents {
                print("docs===>", docs)
                print("docs===>", docs.count)
                self.resultByDB = docs
                self.initTableView()
                self.tableView.reloadData()
            }else{
                print("no record fournd")
            }
        }
    }
}

extension GetRequestVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultByDB.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BroadCastRequestTVCell") as! BroadCastRequestTVCell
        cell.configureCell(tableView: tableView, objects: resultByDB[indexPath.row], indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
