//
//  TableViewCell.swift
//  Sandbox
//
//  Created by Yosuke Ito on 2023/06/14.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var iconNameLabel: UILabel!
    @IBOutlet weak var iconImageView: ImageLoadingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ content: IconListType) {
        self.iconImageView.image = content.iconImage
        self.iconImageView.showIndicator(timeout: 6.0)
        self.iconNameLabel.text = content.iconName
    }
    
}
