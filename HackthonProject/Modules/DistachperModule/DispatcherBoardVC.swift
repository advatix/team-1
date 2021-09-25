//
//  DispatcherBoardVC.swift
//  HackthonProject
//
//  Created by prashant-iOS on 25/09/21.
//

import UIKit
import FirebaseFirestore

class DispatcherBoardVC: BaseVC {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tableView: UITableView!
    
    var orders:[QueryDocumentSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getOrders()
        tableView.dataSource    =   self
        tableView.delegate      =   self
        self.navigationController?.navigationItem.title = "Orders"
    }
    
    func getOrders(){
        let query = database.collection("orders")
        //
        query.getDocuments { (querySnapshot, err) in
            if let docs = querySnapshot?.documents {
                self.orders = docs
                print("orders===>", self.orders.count)
                self.tableView.reloadData()
            }else{
                print("no record fournd")
            }
        }
    }

}

extension DispatcherBoardVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if(!(cell != nil)){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        }
        //
        let obj = orders[indexPath.row].data()
        cell?.textLabel?.text       = "Order ID: \(obj["orderId"] ?? "N?A")"
        cell?.detailTextLabel?.text = "Capecity: \(obj["capacity"] ?? "N?A")"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let obj = orders[indexPath.row].data()
        //initBroardCastRequestVC(order: orders[indexPath.row])
        
        let order       = orders[indexPath.row]
        let orderId     = "\(order["orderId"]!)"
        let location    = order["shipFromLocation"] as? GeoPoint

        //print("orderId==>", orderId)
        //print("lat==>", location)
        self.findDriver(latitude: location!.latitude, longitude: location!.longitude, distance: 1, orderId: orderId)
    }
    
    
    func initBroardCastRequestVC(order: QueryDocumentSnapshot){
        let vc = AppUtility.initViewController(storyBoard:"Main", vcIdentifier:"BroardCastRequestVC") as! BroardCastRequestVC
        vc.selectedOrder = order
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func findDriver(latitude: Double, longitude: Double, distance: Double, orderId: String) {

        print("calling===>")
        
        // ~1 mile of lat and lon in degrees
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182

        let lowerLat = latitude - (lat * distance)
        let lowerLon = longitude - (lon * distance)

        let greaterLat = latitude + (lat * distance)
        let greaterLon = longitude + (lon * distance)

        let lesserGeopoint  = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        print("lesserGeopoint==>",lesserGeopoint)
        print("greaterGeopoint==>",greaterGeopoint)
        
        let docRef = database.collection("drivers")
        let query = docRef.whereField("driverLocation", isGreaterThan: lesserGeopoint)
                          .whereField("driverLocation", isLessThan: greaterGeopoint)
                          .whereField("driverStatus", isEqualTo: true)
                    

        print("query==>",query)
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                
                if let obj = snapshot?.documents{
                    print("obj===>", obj.count)
                    self.saveDataByRefrence(docs: obj, orderId: orderId)
                }
            
            }
        }
    }
    
    func saveDataByRefrence(docs: [QueryDocumentSnapshot], orderId: String){

        let driverCollection = database.collection("driver")

        var userRef: DocumentReference?
        for docSnapshot in docs {
            print("documentID===>", docSnapshot.documentID)
            print("searchdata===>", docSnapshot.data())
            
            userRef = driverCollection.document(docSnapshot.documentID)
            //var k: Int = random() % 10;
            if let receiveByRef = userRef{
                let query = database.collection("job")
                query.document().setData([
                    "jobId"     : random(digits: 10),
                    "assignBy"  : "1001",
                    "receiveBy" : docSnapshot.data()["driverId"] ?? 101,
                    "jobStatus" : false,
                    "orderId"   : orderId
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
        appDelegate.initLocalNotification(title: "Alert", subTitle: "This Order notified to \(docs.count) drivers")
        self.view.toastview(view: self.view, message: "This Order notified to \(docs.count) drivers ")
    }
    
    func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }
}
