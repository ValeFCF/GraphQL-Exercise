//
//  LaunchTableViewCell.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 16/07/21.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func bind(launch: LaunchPastListQuery.Data.LaunchesPast) {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        titleLabel.text = launch.missionName
        if let dateString = launch.launchDateLocal {
            setDate(dateString: dateString)
        }
    }
    
    private func setDate(dateString: String) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        if let date = dateFormatterGet.date(from: dateString) {
            print(dateFormatterPrint.string(from: date))
            dateLabel.text = dateFormatterPrint.string(from: date)
        }
    }
}
