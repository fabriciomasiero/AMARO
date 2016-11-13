//
//  FMAMHomeViewController.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage
import Alamofire


class FMAMHomeViewController: FMBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Propertys
    var products: NSArray! = nil
    var filteredProducts: NSArray! = nil
    var allProducts: NSArray! = nil
    
    // MARK: IBoutlets
    @IBOutlet var tblView: UITableView!
    @IBOutlet var btnBarCart: UIBarButtonItem!
    @IBOutlet var btnBarFilter: UIBarButtonItem!
    
    
    // MARK: - Initialization Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        
        self.organizeItensToShow()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.rightBarButtonItems = nil
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.configureNavigationButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Basics Configurations
    private func configureTableView() {
        tblView.dataSource = self
        tblView.delegate = self
    }
    private func configureNavigationButtons() {
        if (FMAMProductManager.shared.retrieveProductsOnCartCount(products: self.allProducts) > 0) {
            self.navigationItem.rightBarButtonItems = [self.btnBarCart, self.btnBarFilter]
        } else {
            self.navigationItem.rightBarButtonItem = self.btnBarFilter
        }
    }
    private func organizeItensToShow() {
        self.allProducts = FMAMParser().getProducts()
        self.products = allProducts
        self.tblView.reloadData()
    }
    
    // MARK: Create Action Sheet
    private func createActionSheet() {
        let actionSheet: UIAlertController = UIAlertController (title: "Selecione o tipo de filtro", message: "Filtrar por:", preferredStyle: UIAlertControllerStyle.actionSheet)
        let btnCancel: UIAlertAction = UIAlertAction (title: "Cancelar", style: UIAlertActionStyle.cancel, handler: { action in
            print("Cancelado")
        })
        
        let btnLowerPriceToHigh: UIAlertAction = UIAlertAction (title: "$ > $$", style: UIAlertActionStyle.default, handler: { action in
            self.sortingByPrice(ascending: true)
            print("Menor para maior")
        })
        
        let btnHightPriceToLower: UIAlertAction = UIAlertAction (title: "$$ < $", style: UIAlertActionStyle.default, handler: { action in
            self.sortingByPrice(ascending: false)
            print("Maior para menor")
        })
        
        let btnOnSaleOffers: UIAlertAction = UIAlertAction (title: "Ofertas", style: UIAlertActionStyle.default, handler: { action in
            self.showOnlyOnSaleProducts()
            print("Apenas ofertas")
        })
        
        
        let btnAllProducts: UIAlertAction = UIAlertAction (title: "Relevância", style: UIAlertActionStyle.default, handler: { action in
            self.showAllProducts()
            print("Todos os produtos")
        })
        
        actionSheet.addAction(btnCancel)
        
        actionSheet.addAction(btnOnSaleOffers)
        
        actionSheet.addAction(btnHightPriceToLower)
        
        actionSheet.addAction(btnLowerPriceToHigh)
        
        actionSheet.addAction(btnAllProducts)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: Filters
    private func sortingByPrice(ascending: Bool) {
        let sortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "rawPrice", ascending: ascending)
        let sortedByPrice = (self.allProducts as NSArray).sortedArray(using: [sortDescriptor])
        
        self.filteredProducts = sortedByPrice as NSArray
        self.products = self.filteredProducts
        self.tblView.reloadData()
    }
    private func showAllProducts() {
        self.products = self.allProducts
        
        self.tblView.reloadData()
    }
    private func showOnlyOnSaleProducts() {
        let predicate = NSPredicate(format: "onSale == true")
        let sortedByPromo = (self.allProducts as NSArray).filtered(using: predicate)
        
        self.filteredProducts = sortedByPromo as NSArray
        self.products = self.filteredProducts
        self.tblView.reloadData()
    }
    
    
    // MARK: TableView Datasource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellProducts", for: indexPath) as! FMAMProductsCellTableViewCell
        let product: FMAMProducts = self.products.object(at: indexPath.row) as! FMAMProducts
        cell.lblProductName.text = product.name
        cell.imgProduct.image = UIImage.init(named: "imgPlaceholderAmaro")
        if (product.pictureUrl != nil) {
            cell.imgProduct.af_setImage(withURL: product.pictureUrl)
        }
        cell.lblProductsSize.text = product.installments
        if product.onSale == true {
            
            cell.lblProductsPrice.attributedText = product.getAttributedPrice()
            cell.viewRibbon.isHidden = false
            cell.lblRibbonDiscount.text = product.discountPorcentage + " OFF"
            
        } else {
            cell.lblProductsPrice.text = product.actualPrice
            cell.viewRibbon.isHidden = true
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product: FMAMProducts = self.products.object(at: indexPath.row) as! FMAMProducts
        self.performSegue(withIdentifier: "showProduct", sender: product)
    }
    
    
    // MARK: UIButton Actions
    @IBAction func filterProducts(_ sender: UIBarButtonItem) {
        self.createActionSheet()
    }
    
    @IBAction func openCart(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showCart", sender: nil)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showProduct") {
            let prodVc: FMAMProductViewController = segue.destination as! FMAMProductViewController
            prodVc.product = sender as! FMAMProducts!
            prodVc.products = self.allProducts
        } else if (segue.identifier == "showCart") {
            let cartVc: FMAMCartViewController = segue.destination as! FMAMCartViewController
            cartVc.products = self.allProducts
            
            
        }
    
    }
}
