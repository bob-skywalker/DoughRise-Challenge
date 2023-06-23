//
//  Item.swift
//  DoughRise-Challenge
//
//  Created by bo zhong on 6/22/23.
//

import Foundation


struct CategoryItem: Codable, Identifiable{
    let id = UUID()
    let icon: String
    let name: String
    let budget: Int
    var spent: Int
    
    var percentSpent: Double{
        return budget == 0 ? 0 : Double(spent) / Double(budget)
    }
    


}
