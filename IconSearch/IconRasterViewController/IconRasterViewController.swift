//
//  IconRasterViewController.swift
//  IconSearch
//
//  Created by suhemparashar on 27/05/23.
//

import UIKit

class IconRasterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let setName: String?
    let rasterSizes: [RasterSizes]?
    let viewModel = IconRasterViewModel()
    
    
    init(setName: String?, rasterSizes: [RasterSizes]?){
        self.setName = setName
        self.rasterSizes = rasterSizes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"IconRasterCellVC", bundle: nil), forCellReuseIdentifier: "Reusable Cell")
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    func setUp(){
        tableView.dataSource = self
        titleLabel.text = setName
    }
    
}

extension IconRasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rasterSizes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let imageURL = rasterSizes?[indexPath.row].formats?[0].previewURL ?? ""
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reusable Cell", for: indexPath) as! IconRasterCellVC
        
        viewModel.setUpImageView(imageURLString: imageURL) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.iconImage.image = image
                }
            } else {
                print("image request failed")
            }
        }
        
        cell.actionButton.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        let downloadIcon = UIImage(systemName: "square.and.arrow.down")
        cell.actionButton.setImage(downloadIcon, for: .normal)
        cell.actionButton.setTitle("  Download", for: .normal)
        
        
        return cell
    }
    
}

