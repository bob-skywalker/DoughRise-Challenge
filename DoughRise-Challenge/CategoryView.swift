//
//  CategoryView.swift
//  DoughRise-Challenge
//
//  Created by bo zhong on 6/22/23.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var inputAmount: Int = 0
    var category: String
    
    var body: some View {
        VStack{
            Text("Category: \(category)")
                .font(.title2).bold()
            
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: "Food")
    }
}
