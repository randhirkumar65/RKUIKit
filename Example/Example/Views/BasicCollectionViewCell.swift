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
    @IBOutlet private weak var infoButtonAction: UIButton!
    var infoActionClosure: ((UIButton) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8.0
        hideInfoButton()
    }

    @IBAction private func infoTapped(_ sender: UIButton) {
        infoActionClosure?(sender)
    }
    
    func hideInfoButton(isHide: Bool = true) {
        infoButtonAction.isHidden = isHide
        
    }
    
    func configCell(model: LandingModel) {
        titleLabel.text = model.title
    }
}
