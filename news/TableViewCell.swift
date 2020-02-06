//
//  TableViewCell.swift
//  news
//
//  Created by Roman Dvoritskiy on 05.02.2020.
//  Copyright © 2020 Roman Dvoritskiy. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imagesView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var author: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
