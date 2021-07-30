//
//  FeaturedView.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 17/07/21.
//

import UIKit

class FeaturedView: UIView {

    private let kContentXibName = "FeaturedView"
    @IBOutlet var contentView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var siteLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var rocketLabel: UILabel!
    @IBOutlet var webButton: UIButton!
    @IBOutlet var videoButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(kContentXibName,
                                 owner: self,
                                 options: nil)
        addSubview(contentView)
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleWidth,
                                        .flexibleHeight]
    }

}
