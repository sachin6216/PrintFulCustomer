//
//  ProductViewController.swift
//  PrintFulCustomer
//
//  Created by Sachin on 31/03/23.
//

import UIKit
import Combine
import SDWebImage
class ProductViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    // MARK: - Variables
    var viewModel = ProductViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationUI()
        self.subscribers()
        self.registerCellXib()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.getProductList(controller: self)
    }
    // MARK: - IBActions
    @objc func btnBack() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Extra functions
    /// Register nib on UICollectionView
    fileprivate func registerCellXib() {
        self.collectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }
    /// Set UI properties
    func setNavigationUI() {
        let leftBarBtn = UIBarButtonItem.init(image: UIImage.init(systemName: "chevron.backward"), style: .done, target: self, action: #selector(btnBack))
        self.navigationItem.leftBarButtonItem = leftBarBtn
        self.navigationItem.title = "Products"
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.tintColor = .red
    }
    // MARK: - APIs
    /// Subscribe the publisher to get callbacks from the change events.
    func subscribers() {
        self.viewModel.getProductListPublisher.sink { _ in
            self.collectionView.reloadData()
        }.store(in: &subscriptions)
    }
    
}
// MARK: - Extension UI
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.model.dataResponse?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        let dataItem = self.viewModel.model.dataResponse?[indexPath.row]
        cell.imgItem.sd_setImage(with: URL.init(string: dataItem?.image ?? ""), placeholderImage: #imageLiteral(resourceName: "palaceholder"), options: .highPriority, context: nil)
        cell.lblItemName.text = dataItem?.title ?? ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.width / 2) - 8, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else { return }
        if let productId = self.viewModel.model.dataResponse?[indexPath.row].id {
            nextVc.viewModel.model.productId = "\(productId)"
            self.navigationController?.pushViewController(nextVc, animated: true)
        }
        
    }
}
