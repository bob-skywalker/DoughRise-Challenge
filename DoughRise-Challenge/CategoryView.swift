//
//  CategoryView.swift
//  DoughRise-Challenge
//
//  Created by bo zhong on 6/22/23.
//

import SwiftUI

struct CategoryView: View {
    var category: String
    
    var body: some View {
        Text(category)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: "Food")
    }
}
