//
//  CategoryCollectionViewCell.swift
//  PrintFulCustomer
//
//  Created by Sachin on 31/03/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    /// categoryCell
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgItem.layer.cornerRadius = 10
    }

}
