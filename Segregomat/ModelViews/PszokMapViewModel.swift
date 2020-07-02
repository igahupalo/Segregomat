//
//  MapViewModel.swift
//  Segregomat
//
//  Created by Iga Hupalo on 01/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class PszokMapViewModel: ObservableObject {
    @Published var pszoks: [Pszok] = []
    @ObservedObject var session = FirebaseSession()
    
    func fetchPszoks() {
        self.session.getPszoks(pszokMapViewModel: self)
    }
    
}
