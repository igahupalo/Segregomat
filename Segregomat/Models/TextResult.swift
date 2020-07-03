//
//  TextResult.swift
//  Segregomat
//
//  Created by Iga Hupalo on 03/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation

struct TextResult: Identifiable {
    var id = UUID()
    var text: String
    var isURL: Bool
}
