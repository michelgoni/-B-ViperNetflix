//
//  LanguagesModuleDefaultInteractorManager.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 22/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import Foundation

class LanguagesModuleDefaultInteractorManager: LanguagesModuleInteractorManager {

    var flagsArray : [Array<Any>]
    
    init(flagsArray: [Array<Any>]) {
        self.flagsArray = flagsArray
    }
}
