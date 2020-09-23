//
//  models.swift
//  kindle-app
//
//  Created by Andrews Frempong on 22/09/2020.
//  Copyright © 2020 Andrews Frempong. All rights reserved.
//

import UIKit

class Book{
    let title: String
    let author: String
    let coverImageUrl: String
    let pages: [Page]
    
    init(title: String, author: String, coverImageUrl: String, pages: [Page]) {
        self.title = title
        self.author = author
        self.coverImageUrl = coverImageUrl
        self.pages = pages
    }
    
    init(bookDictionary: [String: Any]) {
        self.title = bookDictionary["title"] as? String ?? ""
        self.author = bookDictionary["author"] as? String ?? ""
        self.coverImageUrl = bookDictionary["coverImageUrl"] as? String ?? ""
        
        var bookPages: [Page] = []
        if let fetchedBookPages = bookDictionary["pages"] as? [[String: Any]]{
            for page in fetchedBookPages {
                if let pageText = page["text"] as? String{
                    bookPages.append(Page(number: 1, text: pageText))
                }
                
            }
        }
        
        self.pages = bookPages
    }
}

class Page{
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
