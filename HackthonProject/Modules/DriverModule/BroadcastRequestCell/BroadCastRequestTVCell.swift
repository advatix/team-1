//
//  BroadCastRequestTVCell.swift
//  demoAppiOS
//
//  Created by prashant-iOS on 25/09/21.
//

import UIKit
import FirebaseFirestore

class BroadCastRequestTVCell: UITableViewCell {

    @IBOutlet weak var orderLbl: UILabel!
    @IBOutlet weak var pickUpLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var sendByLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(tableView: UITableView, objects:QueryDocumentSnapshot?, indexPath: IndexPath){
        print("object===>", objects?.data())
        
        if let obj = objects?.data(){
            orderLbl.text       = "\(obj["orderId"])"
            pickUpLbl.text      = "\(obj["jobId"])"
            deliveryLbl.text    = "10023"
            sendByLbl.text      = "Send By: Dispatcher"
        }else{
            orderLbl.text       = "N/A"
            pickUpLbl.text      = "N/A"
            deliveryLbl.text    = "N/A"
            sendByLbl.text      = "N/A"
        }
        
    }
}
