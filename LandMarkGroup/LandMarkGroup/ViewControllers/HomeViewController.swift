//
//  HomeViewController.swift
//  LandMarkGroup
//
//  Created by Dutta, Soumitra on 15/05/19.
//  Copyright © 2019 Dutta, Soumitra. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var lblHeadline : UILabel!
    @IBOutlet weak var lblTimer : UILabel!
    @IBOutlet weak var btnINR : UIButton!
    @IBOutlet weak var btnAED : UIButton!
    @IBOutlet weak var btnSAR : UIButton!
    
    lazy var productItemViewModel : ProductItemViewModel =
        {
            return ProductItemViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpView()
        initViewModel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // productCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        ProductImageDownloadManager.shared.clearCache()
    }
    
    // MARK: - SetUp View Properties
    func setUpView(){
        btnAED.isSelected = true
        btnAED.backgroundColor = ProductConstants.customColor.customBlue
        btnAED.setTitleColor(UIColor.white, for: .normal)
        btnAED.layer.cornerRadius = 3
        btnAED.layer.borderWidth = 1
        btnINR.isSelected = false
        btnINR.backgroundColor = UIColor.gray
        btnINR.setTitleColor(UIColor.black, for: .normal)
        btnINR.layer.cornerRadius = 3
        btnINR.layer.borderWidth = 1
        btnSAR.isSelected = false
        btnSAR.backgroundColor = UIColor.gray
        btnSAR.setTitleColor(UIColor.black, for: .normal)
        btnSAR.layer.cornerRadius = 3
        btnSAR.layer.borderWidth = 1
        setUpCurrencyType()
    }
    
    
    // MARK: - Button Action
    @IBAction func Click_btnINR(_ sender: Any) {
        btnAED.isSelected = false
        btnAED.backgroundColor = UIColor.gray
        btnAED.setTitleColor(UIColor.black, for: .normal)
        btnINR.isSelected = true
        btnINR.backgroundColor = ProductConstants.customColor.customBlue
        btnINR.setTitleColor(UIColor.white, for: .normal)
        btnSAR.isSelected = false
        btnSAR.backgroundColor = UIColor.gray
        btnSAR.setTitleColor(UIColor.black, for: .normal)
        setUpCurrencyType()
    }
    @IBAction func Click_btnAED(_ sender: Any) {
        btnAED.isSelected = true
        btnAED.backgroundColor = ProductConstants.customColor.customBlue
        btnAED.setTitleColor(UIColor.white, for: .normal)
        btnINR.isSelected = false
        btnINR.backgroundColor = UIColor.gray
        btnINR.setTitleColor(UIColor.black, for: .normal)
        btnSAR.isSelected = false
        btnSAR.backgroundColor = UIColor.gray
        btnSAR.setTitleColor(UIColor.black, for: .normal)
        setUpCurrencyType()
    }
    @IBAction func Click_btnSAR(_ sender: Any) {
        btnAED.isSelected = false
        btnAED.backgroundColor = UIColor.gray
        btnAED.setTitleColor(UIColor.black, for: .normal)
        btnINR.isSelected = false
        btnINR.backgroundColor = UIColor.gray
        btnINR.setTitleColor(UIColor.black, for: .normal)
        btnSAR.isSelected = true
        btnSAR.backgroundColor = ProductConstants.customColor.customBlue
        btnSAR.setTitleColor(UIColor.white, for: .normal)
        setUpCurrencyType()
    }
    
    func setUpCurrencyType(){
        if btnAED.isSelected {
            productItemViewModel.currencyType = .AED
        }
        else if btnSAR.isSelected {
            productItemViewModel.currencyType = .SAR
        }
        else {
            productItemViewModel.currencyType = .INR
        }
        
        productCollectionView.reloadData()
    }
    
    
}


//MARK: - CollectionView Data Source And Delegates
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productItemViewModel.numberOfRows
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductListCollectionViewCell
        let cellViewModel = productItemViewModel.getProductCellViewModel(indexPath: indexPath)
        cell.productItemCellViewModel = cellViewModel
        cell.configureProductImage(collectionView: collectionView)
        return cell
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
    }
    
}

// MARK: - ViewModel Initialization And Binding
extension HomeViewController {
    
    // ViewModel And View Binding
    func initViewModel() {
        
        productItemViewModel.updateLabelTimeLeft = { [weak self] in
            DispatchQueue.main.async {
                self?.lblTimer.text = (self?.productItemViewModel.timerString)! + "  Left"
            }
        }
        productItemViewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.lblHeadline.text = self?.productItemViewModel.headline
            }
        }
        
        productItemViewModel.showHideLoading = { [weak self] in
            let loading = self?.productItemViewModel.isLoading ?? false
            if loading {
                LoadingOverlay.shared.showOverlay(view: self?.view)
            }
            else{
                LoadingOverlay.shared.hideOverlayView()
            }
        }
        
        productItemViewModel.reloadProductListCollection = { [weak self] in
            DispatchQueue.main.async {
                self?.productCollectionView.reloadData()
            }
            
        }
        
        productItemViewModel.showAlert = { [weak self] in
            DispatchQueue.main.async {
                CommonAlertView.showCommonAlert(viewController: self!, title: ProductConstants.projectName, message: (self?.productItemViewModel.alertMessage)!, OkButtonTitle: "OK")
            }
            
        }
        
        productItemViewModel.initFetch()
    }
}

// MARK: - Collection View Cell Properties and Cell Configuration
class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblOroiginalPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var productItemCellViewModel : ProductItemCellViewModel? {
        
        didSet {
            lblTitle.text = productItemCellViewModel?.name
            imgProduct.layer.masksToBounds = true
            imgProduct.layer.cornerRadius = 2
            lblDiscountPrice.text = productItemCellViewModel?.price
        }
    }
    
    
}

// MARK: - Setup ProductImage in Cell
fileprivate extension ProductListCollectionViewCell {
    func configureProductImage(collectionView: UICollectionView) {
        ProductImageDownloadManager.shared.setUpProductImage(imageView: imgProduct, collectionView: collectionView,  indexPath: productItemCellViewModel!.cellIndex! as NSIndexPath, urlString: (productItemCellViewModel?.imageUrl)!)
    }
}

