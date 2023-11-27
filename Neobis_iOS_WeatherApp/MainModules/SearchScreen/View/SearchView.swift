import Foundation
import UIKit
import SnapKit

class SearchView: UIView {
    
    private let systemBounds = UIScreen.main.bounds
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(rgb: 0x30A2C5).cgColor,
            UIColor(rgb: 0x00242F).cgColor
        ]
        gradient.locations = [0, 1]
        return gradient
    }()
    
    private lazy var subView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search location", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        addSubview(view)
        gradient.frame = systemBounds
        view.layer.addSublayer(gradient)
        view.addSubview(subView)
        view.addSubview(exitButton)
        view.addSubview(locationSearchBar)
        view.addSubview(historyTableView)
    }
    
    private func setConstraints() {
        self.view.snp.makeConstraints{(make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        self.subView.snp.makeConstraints{(make) in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview().offset(systemBounds.height * 0.1)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        self.exitButton.snp.makeConstraints{(make) in
            make.top.trailing.equalTo(subView).inset(18)
        }
        self.locationSearchBar.snp.makeConstraints{(make) in
            make.top.equalTo(exitButton.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(32)
        }
        self.historyTableView.snp.makeConstraints{(make) in
            make.top.equalTo(locationSearchBar.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(32)
            make.bottom.equalTo(subView)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        print(textSearched)
    }
}
