//
//  projectModel.swift
//  ProjectManager
//
//  Created by Aaron on 2023/01/11.
//

import Foundation

struct Project: Hashable {
    var title: String
    var description: String
    var date: String
    let identifier = UUID()
}
