//
//  BookPageCell.swift
//  kindle-app
//
//  Created by Andrews Frempong on 23/09/2020.
//  Copyright © 2020 Andrews Frempong. All rights reserved.
//

import UIKit

class BookPageCell: UICollectionViewCell {
    
    var page: Page?{
        didSet{
            textLabel.text = page?.text
        }
    }
    
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(textLabel)
        textLabel.anchor(right: rightAnchor, left: leftAnchor, paddingRight: 16, paddingLeft: 16)
        textLabel.centerX(inView: contentView, constant: 0)
        textLabel.centerY(inView: contentView, constant: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
