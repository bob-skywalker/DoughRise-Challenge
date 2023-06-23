//
//  CategoryItemViewModel.swift
//  DoughRise-Challenge
//
//  Created by bo zhong on 6/22/23.
//

import Foundation


class CategoryItemViewModel: ObservableObject {
    @Published var categoryItems = [CategoryItem]()
}
