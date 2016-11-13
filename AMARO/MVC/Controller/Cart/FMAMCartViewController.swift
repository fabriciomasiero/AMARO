//
//  FMAMCartViewController.swift
//  AMARO
//
//  Created by Fabrício Masiero on 12/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class FMAMCartViewController: FMBaseViewController, UITableViewDelegate, UITableViewDataSource  {
    
    // MARK: Propertys
    var itens: NSArray! = nil
    var products: NSArray! = nil

    // MARK: IBoutlets
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var tblView: UITableView!
    
    @IBOutlet var btnCheckout: UIButton!
    
    // MARK: - Initialization Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.tblView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        self.title = "Carrinho de compras"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.organizeItens()
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
    }
    
    // MARK: Organize Itens
    func organizeItens() {
        self.itens = FMAMProductManager.shared.retrieveProductsOnCart(products: self.products)
        var value: Float = 0
        for item in self.itens as! [FMAMProducts] {
            let pricePerItem: Float = item.rawPrice * Float(item.quantity)
            value = value + pricePerItem
        }
        var priceStr: String = "R$ " + String(value)
        priceStr = priceStr.replacingOccurrences(of: ".", with: ",")
        self.lblTotal.text = priceStr

        self.tblView.reloadData()
    }
    
    // MARK: TableView Datasource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itens.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCart", for: indexPath) as! FMAMCartCellTableViewCell
        let product: FMAMProducts = self.itens.object(at: indexPath.row) as! FMAMProducts
        cell.lblProductName.text = product.name
        cell.imgProduct.image = UIImage.init(named: "imgPlaceholderAmaro")
        if (product.pictureUrl != nil) {
            cell.imgProduct.af_setImage(withURL: product.pictureUrl);
        }
        
//        let price: Float = product.rawPrice * Float(product.quantity)
        
        
//        var priceStr: String = "R$ " + String(price)
        
//        priceStr = priceStr.replacingOccurrences(of: ".", with: ",")
        
        cell.lblProductPrice.text = product.actualPrice
        
        cell.btnProductQuantity.setTitle("Quantidade: " + String(product.quantity), for: UIControlState.normal)
        cell.btnProductQuantity.tag = indexPath.row
        cell.btnProductQuantity.addTarget(self, action: #selector(showQuantitys(sender:)), for: UIControlEvents.touchUpInside)
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let product: FMAMProducts = self.itens.object(at: indexPath.row) as! FMAMProducts
            FMAMProductManager.shared.removeProductOfCart(product: product)
            self.organizeItens()
        }
    }
    
    // MARK: UIButton Actions
    func showQuantitys(sender: UIButton) {
        
        let quantitys:NSArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
        let product: FMAMProducts = self.itens.object(at: sender.tag) as! FMAMProducts
        

        StringPickerPopover.appearFrom(
            originView: (sender.superview?.superview!.superview!.superview!)!,
            baseViewController: self,
            title: "Quantidade",
            choices: quantitys as! [String],
            initialRow:0,
            doneAction: {
                selectedRow, selectedString in
                product.quantity = Int(selectedString)!
                FMAMProductManager.shared.insertProductToCart(product: product, products: self.products)
                self.organizeItens()
        } ,
            cancelAction: {
                print("cancel")
        })
    }

    @IBAction func checkout(_ sender: UIButton) {
        let alert = UIAlertController(title: "Ah", message: "Agora só me contratando", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
