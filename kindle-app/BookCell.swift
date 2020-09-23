//
//  BookCell.swift
//  kindle-app
//
//  Created by Andrews Frempong on 22/09/2020.
//  Copyright © 2020 Andrews Frempong. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell{
    
    var book: Book?{
        didSet{
            
            self.bookTitleLabel.text = book?.title
            self.bookAuthorLabel.text = book?.author
            
            // MARK: download book cover image
            let coverImageUrl = book?.coverImageUrl
            if let unwrappedCoverImageUrl = coverImageUrl{
                let bookCoverImageUrl = URL(string: unwrappedCoverImageUrl)
                
                // reset image before fetch
                self.bookCoverImageView.image = nil
                
                if let bookCoverImageUrl = bookCoverImageUrl{
                    URLSession.shared.dataTask(with: bookCoverImageUrl) { (data, response, error) in
                        if(error != nil) {
                            print("******Error while getting book cover image")
                        }
                        
                        if let data = data{
                            // print("*********Data ===> ", data)
                            DispatchQueue.main.async {
                                let image = UIImage(data: data)
                                // set image
                                self.bookCoverImageView.image = image
                            }
                            
                        }
                    
                    }.resume()
                }
            }
           
        }
    }
    
    // MARK: private properties
    private let bookCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // imageView.backgroundColor = .green
        return imageView
    }()
    
    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.backgroundColor = .red
        return label
    }()
    
    private let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.backgroundColor = .red
        return label
    }()
    
    // MARK: override methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        let selectedView: UIView = {
            let v = UIView()
//            v.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
            v.backgroundColor = UIColor.rgbValues(red: 85, green: 85, blue: 85)
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        selectedBackgroundView = selectedView
        
        addSubview(bookCoverImageView)
//        bookCoverImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
//        bookCoverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
//        bookCoverImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
//        bookCoverImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        bookCoverImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, width: 70)
        
         addSubview(bookTitleLabel)
//        bookTitleLabel.leftAnchor.constraint(equalTo: bookCoverImageView.rightAnchor, constant: 8).isActive = true
//        bookTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
//        bookTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        bookTitleLabel.centerYAnchor.constraint(equalTo: bookCoverImageView.centerYAnchor, constant: -8).isActive = true
        bookTitleLabel.anchor(right: rightAnchor, left: bookCoverImageView.rightAnchor, paddingRight: 8, paddingLeft: 8, height: 20)
        bookTitleLabel.centerY(inView: contentView, constant: -8)
        
         addSubview(bookAuthorLabel)
//        bookAuthorLabel.leftAnchor.constraint(equalTo: bookCoverImageView.rightAnchor, constant: 8).isActive = true
//        bookAuthorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
//        bookAuthorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        bookAuthorLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 4).isActive = true
        bookAuthorLabel.anchor(top: bookTitleLabel.bottomAnchor, right: rightAnchor, left: bookCoverImageView.rightAnchor, paddingTop: 4, paddingRight: 8, paddingLeft: 8, height: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
