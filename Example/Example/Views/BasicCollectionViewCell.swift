//
//  BasicCollectionViewCell.swift
//  Example
//
//  Created by Randhir Kumar on 07/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import RKUIKit

class BasicCollectionViewCell: UICollectionViewCell, NibLoadable {

    @IBOutlet weak private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8.0
    }

    func configCell(model: LandingModel) {
        titleLabel.text = model.title
    }
}
