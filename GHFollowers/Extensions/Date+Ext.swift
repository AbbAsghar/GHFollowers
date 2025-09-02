//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Syed Asghar Abbas on 04/10/24.
//  Copyright © 2024 Asghar. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
