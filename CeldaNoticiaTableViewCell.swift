//
//  CeldaNoticiaTableViewCell.swift
//  AppsNews
//
//  Created by KevinLA on 11/03/24.
//

import UIKit

class CeldaNoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var ImagenNoticiaIV: UIImageView!
    @IBOutlet weak var descricionNoticiasLabel: UILabel!
    @IBOutlet weak var titulonoticia: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
