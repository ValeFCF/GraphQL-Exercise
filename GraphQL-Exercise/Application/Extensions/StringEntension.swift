//
//  StringEntension.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 16/07/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var dateFormatted: String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        if let date = dateFormatterGet.date(from: self) {
            let dateText = String(format: "DATE_LABEL_CELL".localized,
                                  dateFormatterPrint.string(from: date))
            return dateText
        }
        return nil
    }
}
