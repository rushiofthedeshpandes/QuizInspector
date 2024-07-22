//
//  HomeTableCell.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 21/07/24.
//

import UIKit

class HomeTableCell: UITableViewCell {
    
    public static var identifier: String{
        get{
            return K.HomeTableCell
        }
    }
    
    public static func register() -> UINib{
        UINib(nibName: K.HomeTableCell, bundle: nil)
    }

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func setupCell(viewModel : Category){
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.name
            self.idLabel.text = "\(viewModel.id)"
        }
    }
    
}
