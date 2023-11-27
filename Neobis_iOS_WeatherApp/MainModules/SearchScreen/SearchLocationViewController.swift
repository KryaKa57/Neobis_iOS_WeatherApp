//
//  SearchLocationViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 23.11.2023.
//

import Foundation
import UIKit
import CSV

protocol DataDelegate: AnyObject {
    func sendData(city: String)
}


class SearchLocationViewController: UIViewController {
    var delegate: DataDelegate?
    
    private var searchView: SearchView!
    private let systemBounds = UIScreen.main.bounds
    
    private var locations: [String] = []
    var filteredLocations: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createView()
        self.addLocations()
        
        searchView.historyTableView.delegate = self
        searchView.historyTableView.dataSource = self
        searchView.locationSearchBar.delegate = self
        
        filteredLocations = locations
    }
    
    private func createView() {
        searchView = SearchView()
        searchView.frame = CGRect(x: 0, y: 0, width: systemBounds.width, height: systemBounds.height)
        searchView.center = view.center
        view.addSubview(searchView)
        
        searchView.exitButton.addTarget(self, action: #selector(toMainScreen), for: .touchUpInside)
    }
    
    @objc func toMainScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    private func addLocations() {
        let fileURL = Bundle.main.url(forResource: "cities_list", withExtension: "csv")!
        let stream = InputStream(url: fileURL)!
        let csv = try! CSVReader(stream: stream)
        csv.next()
        while let row = csv.next() {
            locations.append(row[0])
        }
    }
}

extension SearchLocationViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredLocations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sendData(city: filteredLocations[indexPath.row])
        toMainScreen()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filteredLocations = searchText.isEmpty ? locations : locations.filter { (item: String) -> Bool in
                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            
            searchView.historyTableView.reloadData()
        }
}
