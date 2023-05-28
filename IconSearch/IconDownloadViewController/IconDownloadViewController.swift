//
//  IconDownloadViewController.swift
//  IconSearch
//
//  Created by suhemparashar on 27/05/23.
//

import UIKit

class IconDownloadViewController: UIViewController {
    
    @IBOutlet weak var iconNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = IconDownloadViewModel()
    var setId: Int?
    var setName: String?
    let loaderView = LoaderView()
    
    init(setName: String?, setId: Int?){
        self.setId = setId
        self.setName = setName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"IconCellVC", bundle: nil), forCellReuseIdentifier: "Reusable Cell")
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    func setUp(){
        viewModel.delegate = self
        tableView.dataSource = self
        loaderView.show()
        viewModel.getIcons(setId: setId ?? 0)
        iconNameLabel.text = setName
        
    }
}

extension IconDownloadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getIconCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let imageURL = viewModel.getIconPreview(index: indexPath.row) ?? ""
        let isPremium = viewModel.checkIfIconIsPremium(index: indexPath.row) ?? false

        let cell = tableView.dequeueReusableCell(withIdentifier: "Reusable Cell", for: indexPath) as! IconCellVC
        cell.delegate = self
        cell.rasterSizes = viewModel.getRasterSizes(index: indexPath.row)
       
        viewModel.setUpImageView(imageURLString: imageURL) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.iconPreview.image = image
                }
            } else {
               print("image request failed")
            }
        }
        if  isPremium {
            cell.actionButton.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
            
            let downloadIcon = UIImage(systemName: "lock")
            cell.actionButton.setImage(downloadIcon, for: .normal)
            cell.actionButton.setTitle("  Premium", for: .normal)
            
        }else{
            cell.actionButton.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
            
            let downloadIcon = UIImage(systemName: "square.and.arrow.down")
            cell.actionButton.setImage(downloadIcon, for: .normal)
            cell.actionButton.setTitle("  Download", for: .normal)
        }
        return cell
    }
    
    
}


extension IconDownloadViewController: IconDownloadDelegate {
    func apiCallDidComplete() {
        DispatchQueue.main.async {
            self.loaderView.hide()
            self.tableView.reloadData()
        }
    }
    
}
extension IconDownloadViewController: IconCellVCDelegate {
    func buttonClicked(rasterSizes: [RasterSizes]?) {
        
        let vc = IconRasterViewController(setName: setName, rasterSizes: rasterSizes)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
