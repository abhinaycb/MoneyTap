//
//  WikiCell.swift
//  MoneyTap
//
//  Created by Coffeebeans on 15/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation
import SDWebImage

import UIKit

class WikiCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.purple
        return titleLabel
    }()
    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = UIColor.darkGray
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        return descriptionLabel
    }()
    lazy var cellImageView: UIImageView = {
        let cellImageView=UIImageView()
        cellImageView.layer.borderWidth=1.0
        cellImageView.layer.borderColor = UIColor.black.cgColor
        cellImageView.layer.masksToBounds = false
        cellImageView.clipsToBounds=true
        cellImageView.layer.cornerRadius = 35.0
        return cellImageView
    }()
    
    func configure(title: String, description: String, language: String, imageObject: ImageObject?) {
        titleLabel.text = title
        descriptionLabel.text = description
        cellImageView.sd_setImage(with: URL(string: imageObject?.source ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        cellImageView.sd_setShowActivityIndicatorView(true)
        cellImageView.sd_setIndicatorStyle(.gray)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(cellImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
    
        setupConstraints()
    }
    
    func setupConstraints() {
        var allConstraints = [NSLayoutConstraint]()
        let views: [String: AnyObject] = ["titleLabel": titleLabel,
                                          "descriptionLabel": descriptionLabel,
                                          "cellImage": cellImageView]
        
        let titleLabelConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[titleLabel]-(>=10)-[cellImage]-|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += titleLabelConstraints
        
        let descriptionLabelConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[descriptionLabel]-(>=10)-[cellImage(70)]-|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += descriptionLabelConstraints
        
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(>=20)-[titleLabel]-(10)-[descriptionLabel]-(>=20)-|",
            options: [],
            metrics: nil,
            views: views)
        
        allConstraints += verticalConstraints
        
        allConstraints += [NSLayoutConstraint(item: cellImageView, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0),NSLayoutConstraint(item: cellImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 70.0)]
        NSLayoutConstraint.activate(allConstraints)
    }
}
