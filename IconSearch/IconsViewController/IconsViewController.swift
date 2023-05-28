//
//  IconsViewController.swift
//  IconSearch
//
//  Created by suhemparashar on 26/05/23.
//

import UIKit
import SearchTextField

class IconsViewController: UIViewController {

    @IBOutlet weak var searchTextField: SearchTextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = IconsViewModel()
    private var placeholderString: String = "   🔍 Search for you Favourite Icons !!  "
    
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
        viewModel.getCategories()
        searchFieldHandling()
    }
    
    func searchFieldHandling(){
        searchTextField.placeholder = placeholderString
        searchTextField.theme.font = UIFont.systemFont(ofSize: 18.0)
        searchTextField.userStoppedTypingHandler = {
            
            if let criteria = self.searchTextField.text {
                if criteria.count >= 1 {
                    
                    self.searchTextField.showLoadingIndicator()
                   
                    self.searchMoreItemsInBackground(criteria) { results in
                        self.searchTextField.filterStrings(results)
                        self.searchTextField.stopLoadingIndicator()
                    }
                }else{
                    self.searchTextField.filterStrings([])
                    self.tableView.isHidden = false
                    self.searchTextField.placeholder = self.placeholderString
                }
            }else{
                self.searchTextField.filterStrings([])
                self.tableView.isHidden = false
                self.searchTextField.placeholder = self.placeholderString
            }
        }
        
        searchTextField.itemSelectionHandler = { filteredResults, itemPosition in
            
            let item = filteredResults[itemPosition]
            let queryParam = item.title
            self.searchTextField.text = queryParam
            self.searchTextField.filterStrings([])
            self.tableView.isHidden = false
            self.view.endEditing(true)
            
            let vc = IconSearchViewController(queryParam: queryParam)
            self.navigationController?.pushViewController(vc, animated: true)
            self.searchTextField.text = ""
        }
    }

    func searchMoreItemsInBackground(_ word: String, completion: @escaping ([String]) -> Void) {
        
        var searchResults: [String] = []

        viewModel.getWords(word: word) { result in
            switch result {
            case .success(let model):
                searchResults = model.map { $0.word }
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                completion(searchResults)
            }
            
        }
    }

}

extension IconsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getCategoryCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reusable Cell", for: indexPath)
       
        cell.textLabel?.text = viewModel.getCategory(index: indexPath.row)
        return cell
    }
    
}

extension IconsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = viewModel.getCategory(index: indexPath.row) ?? ""
        let identifier = viewModel.getCategoryIdentifier(index: indexPath.row) ?? ""
        
        let iconsetsViewController = IconsetsViewController(category: category, identifier: identifier)
        self.navigationController?.pushViewController(iconsetsViewController, animated: true)
        self.view.endEditing(true)
    }
}

extension IconsViewController: IconsDelegate {
    func apiCallDidComplete() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
