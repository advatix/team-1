//
//  BroardCastRequestVC.swift
//  HackthonProject
//
//  Created by prashant-iOS on 25/09/21.
//

import UIKit
import FirebaseFirestore

class BroardCastRequestVC: BaseVC {

    var orderID:String?
    var selectedOrder:QueryDocumentSnapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        if let order = selectedOrder{
            let orderId = order["orderId"]
            let location    = order["shipFromLocation"] as? GeoPoint
            
            print("orderId==>", orderId)
            print("lat==>", location)
            //self.findDriver(latitude: location?.latitude!, longitude: location?.longitude!, distance: 3)
            self.findDriver(latitude: location!.latitude, longitude: location!.longitude, distance: 25)
        }
    }
    
    func findData(by location:GeoPoint, orderId:String){
        let query = database.collection("drivers")
                    //.whereField("name", isEqualTo: "ravi")
        query.getDocuments { (querySnapshot, err) in
            if let docs = querySnapshot?.documents {
                print("docs===>", docs)
                print("docs===>", docs.count)

                //self.saveDataByRefrence(docs: docs)
            }else{
                print("no record fournd")
            }
        }
    }
    
    func saveDataByRefrence(docs: [QueryDocumentSnapshot]){

        let driverCollection = database.collection("driver")

        var userRef: DocumentReference?
        for docSnapshot in docs {
            print("documentID===>", docSnapshot.documentID)
            print("searchdata===>", docSnapshot.data())
            //
            userRef = driverCollection.document(docSnapshot.documentID)
            
            if let receiveByRef = userRef{
                let query = database.collection("broadcastJob")
                query.document().setData([
                    "jobId"     : Int.random(in: 0..<6),
                    "assignBy"  : receiveByRef,
                    "receiveBy" : receiveByRef,
                    "jobStatus" : false,
                    "orderId"   : "sdsd"
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    func findDriver(latitude: Double, longitude: Double, distance: Double) {

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

        print("query==>",query)
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                
                print("working")
                
                
                for document in snapshot!.documents {
                    print("PKS===>\(document.documentID) => \(document.data())")
                }
            }
        }

    }
}



