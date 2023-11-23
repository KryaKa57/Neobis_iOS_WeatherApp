import Foundation
import SnapKit
import UIKit

class DailyWeatherCollectionViewCell : UICollectionViewCell {
    static var identifier = "WeeklyWeatherCell"
    
    private let weekDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusImageView = UIImageView()
    private let degreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.layer.cornerRadius = 20
        stack.layer.borderColor = UIColor(rgb: 0xD4D4D4).cgColor
        stack.layer.borderWidth = 1
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weekDayLabel)
        statusStackView.addArrangedSubview(statusImageView)
        statusStackView.addArrangedSubview(degreeLabel)
        contentView.addSubview(statusStackView)
    }
    
    private func setConstraints() {
        self.weekDayLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView.layoutMarginsGuide)
        }
        self.statusStackView.snp.makeConstraints{(make) in
            make.top.equalTo(weekDayLabel.snp.bottom).offset(8)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.5)
            make.width.equalTo(contentView.snp.width)
            make.centerX.centerY.equalTo(contentView.layoutMarginsGuide)
        }
    }
    
    public func configure(weather: Weather) {
        degreeLabel.text = "\(weather.degree)°C"
        statusImageView.image = UIImage(named: weather.statusImageName)
        weekDayLabel.text = weather.dayOfWeek
    }
    
}
