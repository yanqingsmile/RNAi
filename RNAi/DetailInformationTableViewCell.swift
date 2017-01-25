//
//  DetailInformationTableViewCell.swift
//  RNAi
//
//  Created by Vivian Liu on 1/16/17.
//  Copyright © 2017 Vivian Liu. All rights reserved.
//

import UIKit

class DetailInformationTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var sequenceLabel: CopyableLabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
