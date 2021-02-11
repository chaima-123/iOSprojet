//
//  CommentTableViewCell.swift
//  MiniProjet
//
//  Created by mac  on 11/12/2020.
//

import UIKit
protocol MyCellDelegate: AnyObject {
    func btnCloseTapped(cell: CommentTableViewCell)
    func btnDeleteTapped(cell: CommentTableViewCell)

}
class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentText: UILabel!
    
    @IBOutlet weak var commentaire: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnSupp: UIButton!
    
    @IBOutlet weak var btnModif: UIButton!
    weak var delegate: MyCellDelegate?

    
    
    override func awakeFromNib()
    {
       super.awakeFromNib()
    }
    @IBAction func modifier(_ sender: Any) {
        delegate?.btnCloseTapped(cell: self)

    }
    
    @IBAction func supprimer(_ sender: Any) {
        delegate?.btnDeleteTapped(cell: self)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

    }
    @IBOutlet weak var viewCell: UIView!
    

  
   
}
