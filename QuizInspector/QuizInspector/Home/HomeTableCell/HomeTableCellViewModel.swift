//
//  HomeTableCellViewModel.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 21/07/24.

import Foundation

class HomeTableCellViewModel{
    var id : Int
    var title : String
    
    init(category: Category){
        self.id = category.id
        self.title = category.name
    }
  
}
