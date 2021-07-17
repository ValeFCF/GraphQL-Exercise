//
//  LaunchDetailsCollectionViewCell.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 17/07/21.
//

import UIKit

class LaunchDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameShip: UILabel!
    @IBOutlet weak var homePort: UILabel!
    
    func bind(ship: LaunchPastListQuery.Data.LaunchesPast.Ship) {
        nameShip.text = ship.name
        homePort.text = ship.homePort
    }
}
