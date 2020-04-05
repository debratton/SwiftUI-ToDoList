//
//  DateExtensions.swift
//  ToDoList
//
//  Created by David E Bratton on 4/4/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import Foundation
import SwiftUI

class DateExtensions {
    
    static let shared = DateExtensions()
    
    func convertDate(type: String, passedDate: Date) -> String {
        switch type {
        case "Full":
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .full
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        case "Long":
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .long
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        case "Medium":
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .medium
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        case "Short":
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .short
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        default:
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .none
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        }
    }
    
    func convertTime(type: String, passedDate: Date) -> String {
        switch type {
        case "Full":
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.timeStyle = .full
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        case "Long":
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.timeStyle = .long
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        case "Medium":
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.timeStyle = .medium
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        case "Short":
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.timeStyle = .short
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        default:
            let dateToConvert = passedDate
            let formatter1 = DateFormatter()
            formatter1.timeStyle = .none
            let theDate = (formatter1.string(from: dateToConvert))
            return "\(theDate)"
        }
    }
}
