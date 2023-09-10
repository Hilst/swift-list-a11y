//
//  ViewCode.swift
//  ListAccessibility
//
//  Created by Felipe Hilst on 04/08/23.
//

import Foundation

protocol ViewCode {
    func hierarchy()
    func constraints()
    func additional()
    func setupViewCode()
}

extension ViewCode {
    func setupViewCode() {
        hierarchy()
        constraints()
        additional()
    }
}
