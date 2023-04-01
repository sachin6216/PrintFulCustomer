//
//  ProductDetailsViewController.swift
//  PrintFulCustomer
//
//  Created by Sachin on 31/03/23.
//

import UIKit
import Combine
import SDWebImage

class ProductDetailsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDescDropDown: UIButton!
    @IBOutlet weak var sizeCollectionView: UICollectionView! {
        didSet {
            self.sizeCollectionView.delegate = self
            self.sizeCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var bgDescView: UIView!
    @IBOutlet weak var heightSizeCollection: NSLayoutConstraint!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    // MARK: - Variables
    var viewModel = ProductDetailsViewModel()
    private var subscriptions = Set<AnyCancellable>()
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationUI()
        self.subscribers()
        self.viewModel.model.isSelectedSizeIndex = 0
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.getProductDetails(controller: self)
    }
    // MARK: - IBOutlets Action
    @IBAction func btnDescDropDownAct(_ sender: UIButton) {
        self.viewModel.model.isDescDropExpand.toggle()
        self.bgDescView.isHidden = self.viewModel.model.isDescDropExpand
        self.btnDescDropDown.setImage(UIImage.init(systemName: self.viewModel.model.isDescDropExpand ? "chevron.down" : "chevron.up"), for: .normal)
    }
    @objc func btnBack() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Extra Methods
    /// Set UI properties
    func setNavigationUI() {
        self.navigationItem.title = "Products Details"
        let leftBarBtn = UIBarButtonItem.init(image: UIImage.init(systemName: "chevron.backward"), style: .done, target: self, action: #selector(btnBack))
        self.navigationItem.leftBarButtonItem = leftBarBtn
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.tintColor = .red
        self.btnContinue.layer.cornerRadius = 10
        self.imgProduct.layer.cornerRadius = 10
    }
    // MARK: - APIs
    /// Update data on UI
    fileprivate func loadDataUpdateUI() {
        let dataResponseDetails = self.viewModel.model.productDetailsResponse
        self.imgProduct.sd_setImage(with: URL.init(string: dataResponseDetails?.product?.image ?? ""), placeholderImage: #imageLiteral(resourceName: "palaceholder"), options: .highPriority, context: nil)
        self.lblPrice.text = "\(Locale.current.localizedCurrencySymbol(forCurrencyCode: dataResponseDetails?.product?.currency ?? "") ?? "") \(dataResponseDetails?.variants?[self.viewModel.model.isSelectedSizeIndex ?? 0].price ?? "")"
        self.lblDesc.text = dataResponseDetails?.product?.description ?? ""
        self.lblProductName.text = dataResponseDetails?.product?.title ?? ""
        self.bgDescView.isHidden = dataResponseDetails?.product?.description?.isEmpty ?? true
        
        let numItems = dataResponseDetails?.variants?.count ?? 1// total number of items
        let numColumns = 4 // number of items per column
        let collectionViewHeight = 40// height of the UICollectionView

        let numRows = Int(ceil(Double(numItems) / Double(numColumns)))
        let totalHeight = collectionViewHeight * (numRows)
        self.heightSizeCollection.constant = CGFloat(totalHeight)
        self.sizeCollectionView.reloadData()
    }
    
    /// Subscribe the publisher to get callbacks from the change events.
    func subscribers() {
        self.viewModel.getProductDetailsPublisher.sink { _ in
            self.loadDataUpdateUI()
        }.store(in: &subscriptions)
    }
}
// MARK: - Extensions
extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.model.productDetailsResponse?.variants?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sizeCell", for: indexPath) as? SizeCollectionViewCell else { return UICollectionViewCell() }
        let dataItem = self.viewModel.model.productDetailsResponse?.variants?[indexPath.row]
        let isSelectedIndex = self.viewModel.model.isSelectedSizeIndex == indexPath.row
        cell.bgView.layer.borderColor = isSelectedIndex ? UIColor.label.cgColor : UIColor.systemGray4.cgColor
        cell.lblSize.textColor = isSelectedIndex ? UIColor.label : UIColor.systemGray4
        cell.lblSize.text = dataItem?.size ?? ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.sizeCollectionView.frame.width / 4) - 8, height: 35)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.model.isSelectedSizeIndex = (self.viewModel.model.isSelectedSizeIndex == indexPath.row) ? nil : indexPath.row
        self.lblPrice.text = "\(Locale.current.localizedCurrencySymbol(forCurrencyCode: self.viewModel.model.productDetailsResponse?.product?.currency ?? "") ?? "") \(self.viewModel.model.productDetailsResponse?.variants?[self.viewModel.model.isSelectedSizeIndex ?? 0].price ?? "")"
        self.sizeCollectionView.reloadData()
    }
}

