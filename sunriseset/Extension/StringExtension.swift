//
//  StringExtension.swift
//  sunriseset
//
//  Created by Mohammed Al-Quraini on 8/14/21.
//

import UIKit

extension String {
    func timeToHoursAndMinutes12() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm:ss a" //Your date format
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        //according to date format your date string
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        dateFormatter.dateFormat = "hh:mm a"
        let formattedDate = dateFormatter.string(from: date)
        
        
        
        
        return formattedDate
        
        
    }
    
    func dayLengthString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else {
            fatalError()
        }
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: date)

        return formattedDate
    }
}
