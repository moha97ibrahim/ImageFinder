//
//  ViewController.swift
//  ImageFinder
//
//  Created by Mohammed Ibrahim on 26/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var optionBarItem: UIBarButtonItem!
    
    //MARK: - Properties
    let imageViewModel = ImageViewModel()
    private var numberOfColums : Int = 2
    private var images : [ImageModel] = []
    private var additionalImages : [ImageModel] = []
    var imageCache = NSCache<AnyObject, UIImage>()
    static var searchKey : String = ""
    
    //MARK: - UILifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init
        initView()
        
        imageViewModel.selctedColumn.bind{ [unowned self] data in
            self.numberOfColums = data
            self.collectionView.reloadData()
        }
        
        imageViewModel.fetchedData.bind{ data in
            if let safedata = data {
                DispatchQueue.main.async {
                    self.images = safedata
                    self.collectionView.reloadData()
                }
            }
        }
        
        imageViewModel.fetchedAdditionalData.bind{ [unowned self] data in
            if let safedata = data {
                DispatchQueue.main.async {
                self.additionalImages = safedata
                    self.images += additionalImages
                self.collectionView.reloadData()
                }
            }
        }
        
    }
    
    //MARK: - Methods
    
    func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constant.cellnibName, bundle: nil), forCellWithReuseIdentifier: Constant.cellIdentifier)
        
        searchBar.delegate = self
        
        optionBarItem.menu = getUIMenu()
    }
    
    func getUIMenu() -> UIMenu {
        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Two", comment: ""), image: nil , handler: { (_) in self.imageViewModel.selectedColumnOption(column: "two") } ),
            UIAction(title: NSLocalizedString("Three", comment: ""), image: nil, handler: { (_) in self.imageViewModel.selectedColumnOption(column: "three") }),
            UIAction(title: NSLocalizedString("Four", comment: ""), image: nil, handler: { (_) in self.imageViewModel.selectedColumnOption(column: "four") })
        ])
        return barButtonMenu
    }
}

//MARK: - UICollectionViewDelegate

extension ViewController : UICollectionViewDelegate {
    
}


//MARK: - UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellIdentifier, for: indexPath) as! ImageCollectionViewCell
        let temp = images as? [ImageModel]
        let image = temp?[indexPath.row].urls.regular
        if let safeImage = image {
            cell.configure(url: safeImage)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 4) / CGFloat(numberOfColums)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == images.count - 2 {
            imageViewModel.getNextPage(ViewController.searchKey)
        }
    }
    
    
   
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        ViewController.searchKey = searchBar.text!
        imageViewModel.getImages(searchBar.text!)
    }
}


