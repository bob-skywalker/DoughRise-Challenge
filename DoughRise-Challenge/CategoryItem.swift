//
//  Item.swift
//  DoughRise-Challenge
//
//  Created by bo zhong on 6/22/23.
//

import Foundation
import SwiftUI


struct CategoryItem: Codable, Identifiable{
    let id = UUID()
    let icon: String
    let name: String
    let budget: Int
    var spent: Int
    

    
    
    //computed property
    var percentSpent: Double{
        return budget == 0 ? 0 : Double(spent) / Double(budget)
    }
    
    var amountLeft: Int {
        budget - spent 
    }
    
    var categoryColor: Color {
        if icon == "takeoutbag.and.cup.and.straw.fill" {
            return Color.orange
        } else if icon == "graduationcap" {
            return Color.blue
        } else {
            return Color.yellow
        }
    }
    
}
