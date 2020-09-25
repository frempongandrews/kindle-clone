//
//  BookPageController.swift
//  kindle-app
//
//  Created by Andrews Frempong on 22/09/2020.
//  Copyright © 2020 Andrews Frempong. All rights reserved.
//

import UIKit

class BookPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var book: Book?{
        didSet{
            navigationItem.title = book?.title
        }
    }
    
    
    // MARK: custom methods
    
    func setupNavbarStyles () {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeBook))
    }
    
    func setupBookPage() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        layout?.minimumLineSpacing = 0
        collectionView.isPagingEnabled = true
    }
    
    @objc func closeBook() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbarStyles()
        
        // register collection view cell
        collectionView.register(BookPageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = .white
        
        setupBookPage()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! BookPageCell
        
        if let selectedBook = book{
            let currentPage = selectedBook.pages[indexPath.item]
            cell.page = currentPage
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let selectedBook = book{
            return selectedBook.pages.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
}
