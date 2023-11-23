import Foundation
import SnapKit
import UIKit

class DailyWeatherCollectionViewCell : UICollectionViewCell {
    static var identifier = "WeeklyWeatherCell"
    let degreeLabel = UILabel()
    let statusImageView = UIImageView()
    let dateLabel = UILabel()
    let cellStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        degreeLabel.textColor = .white
        degreeLabel.font = UIFont.systemFont(ofSize: 18)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(degreeLabel)
        
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statusImageView)
        
        dateLabel.textColor = .white
        dateLabel.font = UIFont.boldSystemFont(ofSize: 18)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        cellStackView.addArrangedSubview(dateLabel)
        cellStackView.addArrangedSubview(statusImageView)
        cellStackView.addArrangedSubview(degreeLabel)
        cellStackView.distribution = .equalSpacing
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellStackView)
    }
    
    private func setConstraints() {
        self.cellStackView.snp.makeConstraints {(make) in
            make.width.equalTo(contentView)
            make.right.equalTo(contentView).inset(8)
        }

        self.statusImageView.snp.makeConstraints{(make) in
            make.height.equalTo(contentView.snp.height)
            make.width.lessThanOrEqualTo(statusImageView.snp.height).multipliedBy(1.2)
        }
    }
    
    public func configure(weather: Weather) {
        degreeLabel.text = "\(weather.degree)°C"
        statusImageView.image = UIImage(named: weather.statusImageName)
        dateLabel.text = weather.date
    }
}
