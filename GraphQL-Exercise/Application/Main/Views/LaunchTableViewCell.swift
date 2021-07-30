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
            dateLabel.text = dateString.dateFormatted
        }
    }
}
