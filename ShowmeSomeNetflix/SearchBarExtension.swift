//
//  SearchBarExtension.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goñi on 2/4/17.
//  Copyright © 2017 Michel Goñi. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    var textColor:UIColor? {
        get {
            if let textField = self.value(forKey: "searchField") as? UITextField  {
                return textField.textColor
            } else {
                return nil
            }
        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as? UITextField  {
                textField.textColor = newValue
            }
        }
    }
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func getSearchBarTextField() -> UITextField? {
        
        return getViewElement(type: UITextField.self)
    }

    
    func setMagnifyingGlassColorTo(color: UIColor) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }
    
    func setPlaceholderTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName: color])
        }
    }
    
    func setTextFieldClearButtonColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            
            let button = textField.value(forKey: "clearButton") as! UIButton
            if let image = button.imageView?.image {
                button.setImage(image.transform(withNewColor: color), for: .normal)
            }
        }
    }
}
