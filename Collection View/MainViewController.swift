//
//  ViewController.swift
//  Collection View
//
//  Created by Alex Kagarov on 7/13/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Constants
    let basicColor = #colorLiteral(red: 0.2374775112, green: 0.3320055604, blue: 0.6643337607, alpha: 1)
    let loadingBatchSize = 9
    let padding: CGFloat = 16
    
    // MARK: - Variables
    var lastItemId = 0
    var isFetching = false
    var responseCells = [Response]()
    var netSvc = NetworkService()
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchBar()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
    // MARK: - Functions
    // MARK: Navigation Bar style setup
    func setupNavBar() {
        self.navigationController?.navigationBar.backgroundColor = basicColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "DINAlternate-Bold", size: 24)!]
    }
    
    // MARK: Search Bar setup
    func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        if #available(iOS 11.0, *) {
            navigationItem.searchController = search
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: search.searchBar)
        }
    }
    
    // MARK: Get data from JSON response
    func getData() {
        let batchUrl = "https://api.github.com/users?since=\(lastItemId)&per_page=\(loadingBatchSize)"
        netSvc.getData(batchUrl) { data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseResult = try decoder.decode([Response].self, from: data)
                for responseCell in responseResult {
                    self.responseCells.append(responseCell)
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.getLastId()
            }
            catch let jsonError {
                print(jsonError)
            }
        }
    }
    
    // MARK: Switching flag and organizing data loading
    func beginBatchFetch() {
        isFetching = true
        print("fetching data")
        getData()
    }
    
    // MARK: Get ID of last item (for pagination)
    func getLastId() {
        if let lastId = responseCells.last?.id {
            lastItemId = lastId
            print("Last item ID is \(lastItemId) ")
        }
    }
}

// MARK: - Extensions
// MARK: CollectionView Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            beginBatchFetch()
        }
    }
}

// MARK: CollectionView DataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionNib = UINib(nibName: "CustomHeaderCollectionReusableView", bundle: nil)
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        collectionView.register(sectionNib, forSupplementaryViewOfKind: kind, withReuseIdentifier: "customSectionHeader")
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "customSectionHeader", for: indexPath)
        header.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 225*self.view.frame.width/320)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return responseCells.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? CustomCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.id.text = "\(responseCells[indexPath.row].id ?? -1)"
            cell.name.text = responseCells[indexPath.row].login
            cell.type.text = responseCells[indexPath.row].type
            if let isLiked = responseCells[indexPath.row].siteAdmin {
                switch isLiked {
                case true:
                    cell.likeBtn.backgroundColor = basicColor
                    cell.likeBtn.tintColor = .white
                case false:
                    cell.likeBtn.backgroundColor = .white
                    cell.likeBtn.tintColor = basicColor
                }
            }
            
            if let imageUrl = URL(string: responseCells[indexPath.row].avatarUrl!) {
                cell.avatar.downloadImage(from: imageUrl)
            }
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadingCell", for: indexPath) as? LoadingCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.spinner.startAnimating()
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: CollectionView Delegate FlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (3 * padding)) / 2
        switch indexPath.section {
        case 0:
            return CGSize(width: itemSize, height: 1.5*itemSize)
        case 1:
            return CGSize(width: itemSize, height: itemSize)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            let height = 225*self.view.frame.width/320
            let width = self.view.frame.width
            return .init(width: width, height: height)
        case 1:
            return .init(width: 0, height: 0)
        default:
            return .init(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: padding, left: padding, bottom: padding, right: padding)
    }
}
