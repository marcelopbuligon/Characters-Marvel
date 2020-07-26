//
//  TableViewCell.swift
//  Characters-Marvel
//
//  Created by Marcelo Pagliarini Buligon on 24/07/20.
//  Copyright © 2020 Marcelo Pagliarini Buligon. All rights reserved.
//

import UIKit

class CharactersViewCell: UITableViewCell {

    @IBOutlet weak var arrowImage: UIImageView?
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var charactereImage: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var footerLabel: UILabel?
    
    static let identifier = "CharactersCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupContainerView()
        arrowImage?.image = UIImage(systemName: "arrow.right")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func configure(presenter: CharactersViewCellPresenter) {
        presenter.attachView(self)
    }
    
    private func setupContainerView() {
        containerView?.layer.shadowOffset = CGSize(width: 5, height: 5)
        containerView?.layer.shadowOpacity = 0.3
        containerView?.layer.shadowRadius = 5
        containerView?.layer.shadowColor = AppColor.shadow.cgColor
        
        containerView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        charactereImage?.layer.maskedCorners = [.layerMinXMinYCorner]

        charactereImage?.layer.cornerRadius = 30
        containerView?.layer.cornerRadius = 30
    }
}

extension CharactersViewCell: CharactersViewCellPresenterDelegate {
    func setupImage(imageUrl: String) {
        charactereImage?.loadImage(from: imageUrl)
    }
    
    func setupTitle(title: String) {
        titleLabel?.text = title
    }
    
    func setupDescription(description: String) {
        descriptionLabel?.text = description
    }
    
    func setupFooterLabel(text: String) {
        footerLabel?.text = text
    }
}
