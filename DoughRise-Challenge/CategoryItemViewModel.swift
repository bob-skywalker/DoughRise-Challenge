//
//  CategoryItemViewModel.swift
//  DoughRise-Challenge
//
//  Created by bo zhong on 6/22/23.
//

import Foundation


class CategoryItemViewModel: ObservableObject {
    @Published var categoryItems = [CategoryItem]()
    @Published var budget: Int = 5000
    
    var totalLeft: Int {
        budget - categoryItems.reduce(0) { $0 + $1.spent }
    }
    
    var amountSpend: Int {
        budget - totalLeft
    }
    
    var percentTracker: Double {
        Double(amountSpend) / Double(budget)
    }
}
