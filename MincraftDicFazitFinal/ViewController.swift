//
//  ViewController.swift
//  MincraftDicFazitFinal
//
//  Created by Dan Li on 28.08.18.
//  Copyright © 2018 DanStenLee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var searchController:UISearchController!
    
    var tableData=DataModle.readFromBundle()
    var filteredArray:[DataModle]=[]
    var shouldSchowSearchResults=false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        
        tableView.dataSource=self
        tableView.delegate=self
    }
}

extension ViewController:UISearchResultsUpdating,UISearchBarDelegate{
    
    func configureSearchController(){
        searchController=UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater=self
        searchController.dimsBackgroundDuringPresentation=false
        searchController.searchBar.placeholder="Search here..."
        searchController.searchBar.delegate=self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.backgroundImage=UIImage(named: "Background")
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldSchowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldSchowSearchResults = false
        navigationController?.popToRootViewController(animated: true)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldSchowSearchResults{
            shouldSchowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText=searchController.searchBar.text, searchText != "" {
            filteredArray=tableData.filter{ data in
                return data.name.lowercased().contains(searchText.lowercased())
            }
        }else{
            
            filteredArray=tableData
        }
        tableView.reloadData()
        }
    
    }

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldSchowSearchResults{
            return filteredArray.count
        }else{
        return tableData.count
        }
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if shouldSchowSearchResults{
            cell.textLabel?.text=filteredArray[indexPath.row].name
            cell.detailTextLabel?.text=filteredArray[indexPath.row].info
            cell.imageView?.image=UIImage(named:"\(filteredArray[indexPath.row].name)")
            
        }else{
        
            cell.textLabel?.text=tableData[indexPath.row].name
            cell.detailTextLabel?.text=tableData[indexPath.row].info
            cell.imageView?.image=UIImage(named:"\(tableData[indexPath.row].name)")
        }
            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GotoDetailView"{
            let dvc=segue.destination as! DetailViewController
            let indexpath=tableView.indexPathForSelectedRow?.row
            if shouldSchowSearchResults{
                dvc.detaiData=filteredArray[indexpath!]
            }else{
                dvc.detaiData=tableData[indexpath!]
            }
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GotoDetailView", sender: nil)
        }
    }
    




