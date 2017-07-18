//
//  CountriesDetailDefaultViewController.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 12/7/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import UIKit

class CountriesDetailDefaultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewPadding : CGFloat = 0
    let heightForImage: CGFloat = 113
    let insetCollection : CGFloat = 5
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 25
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CountryDetailCell", bundle: nil), forCellWithReuseIdentifier: "CountryCell")
        setCollectionViewPadding()
        self.setUpCustomLayout()
    }
    
    fileprivate func setUpCustomLayout () {
        
        let layout = ContryFlagsLayout()
        layout.numberOfColumns = 3
        collectionView.collectionViewLayout = layout
        layout.cellPadding = 5
        layout.delegate = self
    }
    
    open func showInView(_ aView: UIView!, withImage image : UIImage?, withMessage message: String?, animated: Bool) {
      
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
    
    
    func setCollectionViewPadding() {
        
        let screenWidth = self.view.frame.width
        collectionViewPadding = (screenWidth - (3 * 113)) / 4
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: collectionViewPadding, left: collectionViewPadding, bottom: collectionViewPadding, right: collectionViewPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 113, height: 113)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionViewPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 55
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as! CountryCollectionViewCell
       
        return cell
        
    }
    
    
    
}

extension CountriesDetailDefaultViewController: RandomSizeCellsDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
      
        return heightForImage
    }
}
