//
//  CountryFlagsModuleInteractorManager.swift
//  ShowmeSomeNetflix
//
//  Created by Michel Goni on 18/07/2017.
//  Copyright (c) 2016, Personal. All rights reserved.
//

import Foundation

protocol CountryFlagsModuleInteractorManager {
    
    func getFlagsItems(completionHandletr: @escaping (([Array<Any>]) ->Void))
}
