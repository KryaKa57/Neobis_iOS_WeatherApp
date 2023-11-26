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
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
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
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
    }
    
    public func configure(weatherList: List) {
        let tempInCelcius = Int(weatherList.main.temp - 273.15)
        weekDayLabel.text = getDayOfWeek(seconds: weatherList.dt)
        let icon = weatherList.weather.first?.icon
        let dayIcon = icon?.replacingOccurrences(of: "n", with: "d")
        
        statusImageView.downloaded(from: URL(string: "https://openweathermap.org/img/wn/\(dayIcon ?? "")@2x.png")!)
        degreeLabel.text = "\(tempInCelcius)°C"
    }
    
    private func getDayOfWeek(seconds: Int) -> String {
        switch (seconds / 86400) % 7 {
        case 1: return "Friday"
        case 2: return "Saturday"
        case 3: return "Sunday"
        case 4: return "Monday"
        case 5: return "Tuesday"
        case 6: return "Wednesday"
        default: return "Thursday"
        }
    }
}
