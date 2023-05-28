//
//  IconsetsViewController.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import UIKit

class IconsetsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = IconsetsViewModel()
    var category: String?
    var identifier: String?
    let loaderView = LoaderView()
    
    init(category: String, identifier: String){
        self.category = category
        self.identifier = identifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Reusable Cell")
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
        tableView.delegate = self
        titleLabel.text = "\(category ?? "")"
        
        loaderView.show()
        viewModel.getIconsets(identifier: self.identifier ?? "")
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension IconsetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getIconsetsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reusable Cell", for: indexPath)
        cell.textLabel?.text = viewModel.getIconsetName(index: indexPath.row)
        return cell
        
    }
}
extension IconsetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setName = viewModel.getIconsetName(index: indexPath.row)
        let setId = viewModel.getIconsetId(index: indexPath.row)
        let vc = IconDownloadViewController(setName: setName, setId: setId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension IconsetsViewController: IconsetsDelegate {
    func apiCallDidComplete() {
        DispatchQueue.main.async {
            self.loaderView.hide()
            self.tableView.reloadData()
        }
    }
    
    
}
