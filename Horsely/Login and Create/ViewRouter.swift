//
//  ViewRouter.swift
//  Horsely
//
//  Created by Saba Dawit on 10/27/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = "page1" {
        didSet {
            objectWillChange.send(self)
        }
    }
}
