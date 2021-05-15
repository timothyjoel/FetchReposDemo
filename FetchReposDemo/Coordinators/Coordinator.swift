//
//  Coordinators.swift
//  FetchReposDemo
//
//  Created by Tymoteusz Stokarski on 15/05/2021.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController? { get set }
    func start()
    
}

protocol Cooordinating {
    var coordinator: Coordinator? { get set }
}
