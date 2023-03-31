//
//  SizeCollectionViewCell.swift
//  PrintFulCustomer
//
//  Created by Sachin on 31/03/23.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    // sizeCell
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.cornerRadius = 5
    }

}
