//
//  DateExtension.swift
//  sunriseset
//
//  Created by Mohammed Al-Quraini on 8/14/21.
//

import UIKit

extension Date {
    func string(format: String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: self)
        }
}
