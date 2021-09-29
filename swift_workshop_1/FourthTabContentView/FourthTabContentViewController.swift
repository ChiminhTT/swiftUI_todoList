//
//  FourthTabContentViewController.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/24/21.
//

import UIKit
import SwiftUI
import Combine

class FourthTabContentViewController: UITableViewController {
    
    var itemListController: ItemListController?
    private let cellReuseIdentifier = "itemTableViewCell"
    private var storage = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListController?.itemList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ItemTableViewCell
        
        // set the text from the data model
        cell.titleLabel.text = itemListController?.itemList[indexPath.row].value ?? ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath),
            let itemListController = itemListController
        else {
            return
        }
        
        cell.isSelected = false
        
        var view = SecondTabContentView(itemListController: itemListController)
        view.mode = .edit
        view.item = itemListController.itemList[indexPath.row]
        let hostingVC = UIHostingController(rootView: view)
        show(hostingVC, sender: self)
    }
}

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

struct FourthTabContentViewControllerWrapper: UIViewControllerRepresentable {
    
    @ObservedObject var itemListController: ItemListController
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = FourthTabContentViewController()
        viewController.itemListController = itemListController
        itemListController.itemListDidChange =  { [weak viewController] in
            viewController?.reloadData()
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard let viewController = uiViewController as? FourthTabContentViewController else {
            return
        }
        viewController.itemListController = itemListController
    }
}

