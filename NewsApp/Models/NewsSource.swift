//
//  NewsSource.swift
//  NewsApp
//
//  Created by MacBook on 16.04.2022.
//

import Foundation

class Source:Codable {
    
    var name:String?
    
    init() {
    }
    
    init(name:String) {
        self.name = name
    }
}
