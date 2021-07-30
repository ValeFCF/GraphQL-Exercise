//
//  LaunchDetailsCollectionViewCell.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 17/07/21.
//

import UIKit
import SDWebImage

class LaunchDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameShip: UILabel!
    @IBOutlet weak var homePort: UILabel!
    
    func bind(ship: LaunchPastListQuery.Data.LaunchesPast.Ship) {
        nameShip.text = ship.name
        homePort.text = ship.homePort
        if let imageString = ship.image {
            bindImage(imageString)
        }
    }
    
    private func bindImage(_ imageString: String) {
        let placeholder = UIImage(named: "placeholderImage")!
        imageView.sd_setImage(with: URL(string: imageString), placeholderImage: placeholder)
    }
}
