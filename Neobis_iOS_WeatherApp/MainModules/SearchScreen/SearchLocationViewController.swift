//
//  SearchLocationViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 23.11.2023.
//

import Foundation
import UIKit

class SearchLocationViewController: UIViewController {
    
    private var searchView: SearchView!
    private let systemBounds = UIScreen.main.bounds
    private var locations = ["London", "Lissabon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createView()
        
        searchView.historyTableView.delegate = self
        searchView.historyTableView.dataSource = self
        
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
}

extension SearchLocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row]
        return cell
    }
}
