
import Foundation
import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    private var firstLabel: UILabel {
        let label = UILabel()
        label.text = "На этой неделе"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }
    
    private var calendarImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints {(make) in
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
        }
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(calendarImageView)
        
        addSubview(stackView)
    }
}
