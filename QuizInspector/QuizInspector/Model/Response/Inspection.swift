//
//  Inspection.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation

// MARK: - Root
struct Root: Codable {
    var inspection: Inspection
}

// MARK: - Inspection
struct Inspection: Codable {
    var area: Area
    var id: Int
    var inspectionType: InspectionType
    var survey: Survey
}


