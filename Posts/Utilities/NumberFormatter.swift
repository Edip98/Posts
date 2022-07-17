//
//  NumberFormatter.swift
//  Posts
//
//  Created by Эдип on 18.07.2022.
//

import Foundation

public func decimalStyle(_ value: Int) -> String? {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: value))
}
