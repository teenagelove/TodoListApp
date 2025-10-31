//
//  Date+Ext.swift
//  TodoListApp
//
//  Created by Danil Kazakov on 31.10.2025.
//

import Foundation

extension Date {
    var shortDate: String {
        formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.twoDigits))
    }
}
