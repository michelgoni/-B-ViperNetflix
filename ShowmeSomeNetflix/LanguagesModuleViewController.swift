//
//  LanguagesModuleViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 22/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import UIKit

class LanguagesModuleViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    var presenter: LanguagesModulePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:-View and animations items
    open func showInView(_ aView: UIView!, animated: Bool) {
        
        aView.addSubview(self.view)
        
        if animated {
            self.showAnimate()
        }
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    @IBAction func closePopUpView(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished){
                self.view.removeFromSuperview()
            }
        });
    }
}

// MARK: - LanguagesModuleView
extension LanguagesModuleViewController: LanguagesModuleView {

}
