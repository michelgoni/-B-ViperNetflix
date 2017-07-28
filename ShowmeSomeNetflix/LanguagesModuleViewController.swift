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
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: LanguagesModulePresenter?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 25
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.tableView.layer.cornerRadius = 25
        self.tableView.layer.shadowOpacity = 0.8
          self.tableView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

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
    
}

// MARK: - LanguagesModuleView
extension LanguagesModuleViewController: LanguagesModuleView {

}
