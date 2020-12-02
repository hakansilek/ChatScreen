//
//  Extensions.swift
//  ChatScreen
//
//  Created by Hakan Silek on 28.11.2020.
//

import UIKit


extension Date{
    static let humanFormat = "dd/MM/yyyy"
    static func dateFromString(stringDate: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = humanFormat
        return dateFormatter.date(from: stringDate) ?? Date()
    }
}
