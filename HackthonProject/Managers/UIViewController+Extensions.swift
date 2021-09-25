//
//  UIViewController+Extensions.swift
//  XPDEL Driver
//
//  Created by prashant on 19/05/20.
//  Copyright © 2020 prashant. All rights reserved.
//

import UIKit.UIViewController
import Toast_Swift
import MBProgressHUD

extension UIViewController
{
    func toastview(view:UIView, message:String)
    {
        DispatchQueue.main.async{
            self.view.makeToast(message, duration: 2.0, position: .center)
        }
    }
    
    func showHUD(progressLabel:String){
        DispatchQueue.main.async{
            let windo = UIApplication.shared.keyWindow!
            let progressHUD = MBProgressHUD.showAdded(to: windo, animated: true)
            progressHUD.label.text = progressLabel
        }
    }
    
    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async{
            let windo = UIApplication.shared.keyWindow!

            MBProgressHUD.hide(for: windo, animated: isAnimated)
        }
    }
}

extension UIView
{
    func toastview(view:UIView, message:String)
    {
        DispatchQueue.main.async{
            self.makeToast(message, duration: 2.0, position: .center)
        }
    }
    
    func showHUD(progressLabel:String){
        DispatchQueue.main.async{
            //let windo = UIApplication.shared.keyWindow!
            let progressHUD         = MBProgressHUD.showAdded(to: self, animated: true)
            //progressHUD.mode        = .determinateHorizontalBar
            progressHUD.label.text  = progressLabel
        }
    }
    
    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self, animated: isAnimated)
        }
    }
}
