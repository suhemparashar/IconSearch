//
//  IconSearchViewController.swift
//  IconSearch
//
//  Created by suhemparashar on 28/05/23.
//

import UIKit

class IconSearchViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = IconSearchViewModel()
    let loaderView = LoaderView()
    
    private var queryParam: String
    
    init(queryParam: String) {
        self.queryParam = queryParam
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"IconSearchCellVC", bundle: nil), forCellReuseIdentifier: "Reusable Cell")
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
        viewModel.getSearchResults(queryParam: queryParam)
        titleLabel.text = "Search Results for - \(queryParam)"
    }
    
}

extension IconSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getIconCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let imageURL = viewModel.getIconPreview(index: indexPath.row) ?? ""
        let isPremium = viewModel.checkIfIconIsPremium(index: indexPath.row) ?? false
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reusable Cell", for: indexPath) as! IconSearchCellVC
        
        viewModel.setUpImageView(imageURLString: imageURL) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.iconPreview.image = image
                }
            } else {
               print("image request failed")
            }
        }
        
        if isPremium {
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


extension IconSearchViewController: IconDownloadDelegate {
    
    func apiCallDidComplete() {
        DispatchQueue.main.async {
            self.loaderView.hide()
            self.tableView.reloadData()
        }
    }
    
}
