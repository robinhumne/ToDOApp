//
//  DataTableViewCell.swift
//  ToDoApp
//
//  Created by pikateck on 19/12/21.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    //UIView
    @IBOutlet var vw_bg: UIView!
    
    //UILabel
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
