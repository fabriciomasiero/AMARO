//
//  FMAMProductViewController.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit
import SwiftyPickerPopover



class FMAMProductViewController: FMBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Propertys
    var product: FMAMProducts!
    var products: NSArray! = nil
    
    var btnBarCart: UIBarButtonItem!
    
    // MARK: IBOutlets
    @IBOutlet var tblView: UITableView!
    @IBOutlet var btnAddToCard: UIButton!
    
    
    // MARK: - Initialization Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = product.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.tblView.tableFooterView = UIView.init(frame: CGRect.zero)
        

        
        self.btnBarCart = UIBarButtonItem.init(image: UIImage.init(named: "imgCart"), landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(showCart))
        
        if (self.product.onCart == true) {
            self.navigationItem.rightBarButtonItem = self.btnBarCart
        }
        
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView Datasource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row == 0) {
            return 292.0
        } else if (indexPath.row == 1) {
            return 70.0
        } else {
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellImage", for: indexPath) as! FMAMProductCellTableViewCell
            cell.imgProduct.image = UIImage.init(named: "imgPlaceholderAmaro")
            if (self.product.pictureUrl != nil) {
                cell.imgProduct.af_setImage(withURL: self.product.pictureUrl)
            }
            return cell
            
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellName", for: indexPath) as! FMAMProductCellTableViewCell
            cell.lblProductName.text = self.product.name
            cell.lblProductPrice.text = self.product.actualPrice
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellSize", for: indexPath) as! FMAMProductCellTableViewCell
            
            
            cell.btnProductSize.addTarget(self, action: #selector(showSizes(sender:)), for: UIControlEvents.touchUpInside)
            cell.btnProductQuantity.addTarget(self, action: #selector(showQuantitys(sender:)), for: UIControlEvents.touchUpInside)
            
            
            
            if (self.product.sizeSelected != nil) {
                let title: String = self.product.sizeSelected.sizeToShow
                cell.btnProductSize .setTitle(title, for: UIControlState.normal)
            } else {
                cell.btnProductSize .setTitle("Tamanho", for: UIControlState.normal)
            }
            
            
            let title: String = "Quantidade: " + String(self.product.quantity)
            cell.btnProductQuantity .setTitle(title, for: UIControlState.normal)
            
            
            return cell
            
        }
    }

    // MARK: UIButtons Actions
    func showSizes(sender: UIButton) {
        let mutableSizes: NSMutableArray = NSMutableArray.init()
        
        for sizeObject in self.product.sizes as! [FMAMSizes] {
            mutableSizes.add(sizeObject.sizeToShow)
        }
        let sizes: NSArray = NSArray.init(array: mutableSizes)
        
        StringPickerPopover.appearFrom(
            originView: (sender.superview?.superview!.superview!.superview!)!,
            baseViewController: self,
            title: "Tamanho",
            choices: sizes as! [String],
            initialRow:0,
            doneAction: {
                selectedRow, selectedString in
                let mySize: FMAMSizes = self.product.sizes.object(at: selectedRow) as! FMAMSizes
                self.product.sizeSelected = mySize
                if (mySize.available == false) {
                    self.product.quantity = 0
                }
                self.tblView.reloadData()
        } ,
            cancelAction: {
                print("cancel")
        })
        
    }
    func showQuantitys(sender: UIButton) {
        
        var quantitys:NSArray!
        
        if (self.product.sizeSelected == nil) {
            quantitys = ["0"]
            
        } else {
            if (self.product.sizeSelected.available == true) {
                quantitys = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
            } else {
                quantitys = ["0"]
            }
        }
        StringPickerPopover.appearFrom(
            originView: (sender.superview?.superview!.superview!.superview!)!,
            baseViewController: self,
            title: "Quantidade",
            choices: quantitys as! [String],
            initialRow:0,
            doneAction: {
                selectedRow, selectedString in
                self.product.quantity = Int(selectedString)!
                print(self.product)
                self.tblView.reloadData()
        } ,
            cancelAction: {
                print("cancel")
        })
    }
    
    @IBAction func addProductToCart(_ sender: UIButton) {
        
        if (self.product.sizeSelected != nil && self.product.quantity > 0) {
            FMAMProductManager.shared.insertProductToCart(product: product, products: products)
            
            let alert = UIAlertController(title: "Atenção", message: "Item adicionado com sucesso ao carrinho", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.navigationItem.rightBarButtonItem = self.btnBarCart
        } else {
            let alert = UIAlertController(title: "Atenção", message: "É necessário inserir uma quantidade e um tamanho disponível", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func showCart() {
        self.performSegue(withIdentifier: "showCart", sender: nil)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showCart") {
            let cartVc: FMAMCartViewController = segue.destination as! FMAMCartViewController
            cartVc.products = self.products
        }
    }
}
