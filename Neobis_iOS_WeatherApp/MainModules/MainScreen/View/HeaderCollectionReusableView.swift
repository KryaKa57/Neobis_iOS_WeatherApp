//
//  HeaderCollectionReusableView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 23.11.2023.
//

import Foundation
import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    private var firstLabel: UILabel {
        let label = UILabel()
        label.text = "The Next 5 days"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        firstLabel.frame = bounds
    }
    
    public func configure() {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints {(make) in
            make.height.equalTo(UIScreen.main.bounds.width * 0.2)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
        }
        stackView.addArrangedSubview(firstLabel)
        
        addSubview(stackView)
    }
}
