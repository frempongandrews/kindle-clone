//
//  ViewController.swift
//  kindle-app
//
//  Created by Andrews Frempong on 22/09/2020.
//  Copyright © 2020 Andrews Frempong. All rights reserved.
//

import UIKit

class BooksListController: UITableViewController {

    // MARK: Properties
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // view.backgroundColor = .systemGreen
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .darkGray
        
        setupNavBarStyles()
        setupTableView()
        fetchBooks()
    }
    
    // MARK: Override Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        let book = self.books[indexPath.row]
        cell.book = book
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPageController(collectionViewLayout: layout)
        let selectedBook = self.books[indexPath.row]
        bookPageController.book = selectedBook
        present(UINavigationController(rootViewController: bookPageController), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView: UIView = {
            let v = UIView()
            v.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
            return v
        }()
        
        let gridViewBtn: UIButton = {
           let button = UIButton()
            button.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }()
        
        let sortBtn: UIButton = {
            let button = UIButton()
            button.setImage(#imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }()
        
        let footerSegmentedControl: UISegmentedControl = {
            let sc = UISegmentedControl(items: ["cloud", "device"])
            sc.selectedSegmentIndex = 0
            sc.backgroundColor = .lightGray
            return sc
        }()
        
        // add subViews to footerView
        footerView.addSubview(gridViewBtn)
        footerView.addSubview(footerSegmentedControl)
        footerView.addSubview(sortBtn)
        
        gridViewBtn.anchor(left: footerView.leftAnchor, paddingLeft: 20, width: 30, height: 30)
        gridViewBtn.centerY(inView: footerView, constant: 0)
        
        sortBtn.anchor(right: footerView.rightAnchor, paddingRight: 20, width: 30, height: 30)
        sortBtn.centerY(inView: footerView, constant: 0)
        
        footerSegmentedControl.anchor(width: 200, height: 30)
        footerSegmentedControl.centerY(inView: footerView, constant: 0)
        footerSegmentedControl.centerX(inView: footerView, constant: 0)
        
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    // MARK: Custom Methods
    
    func setupNavBarStyles() {
        navigationItem.title = "Kindle"
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.customMenuItem(image: #imageLiteral(resourceName: "menu"), width: 30, height: 30, self, action: #selector(openSidebar))
        navigationItem.rightBarButtonItem = UIBarButtonItem.customMenuItem(image: #imageLiteral(resourceName: "amazon_icon"), width: 30, height: 30, self, action: #selector(openAmazonStore))
    }
    
    @objc func openAmazonStore() {
        print("*********open amazon store")
    }
    
    @objc func openSidebar() {
        print("*************open sidebar")
    }
    
    func setupTableView() {
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func fetchBooks() {
        let url = "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json"
        guard let requestUrl = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            if(error != nil) {
                print("***********Error while fetching books ===> ", error)
                return
            }
            
            guard let data = data else { return }
            
            var fetchedBooks: [Book] = []
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
                if let jsonBooksArr = json{
                    // print(jsonBooksArr)
                    
                    // constructing book
                    for bookObj in jsonBooksArr{
                        fetchedBooks.append(Book(bookDictionary: bookObj))
                    }
                    
                    // returning to main thread
                    DispatchQueue.main.async{
                        self.books = fetchedBooks
                        self.tableView.reloadData()
                    }
                }
                
            } catch let jsonError{
                print("**********Error serializing fetched json ===> ", jsonError)
            }
            
        }
        
        task.resume()
    }


}

