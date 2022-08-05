//
//  MainViewController.swift
//  Fitpet
//
//  Created by kyo on 2022/07/31.
//

import UIKit

import RxDataSources
import RxSwift
import SnapKit
import Nuke

class MainViewController: UIViewController {
  
  private let bag = DisposeBag()
  private var vm: MainViewModel!

  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.sectionHeaderHeight = 44
    tv.backgroundColor = .white
    tv.separatorStyle = .none
    tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    tv.registerCell(WeatherTableCell.self)
    tv.delegate = self
    return tv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func loadView() {
    super.loadView()
    
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalTo(Const.safeAreaTop)
      $0.left.right.bottom.equalTo(0)
    }
    
    binding()
  }
  
  func binding() {
    vm = MainViewModel()
    
    let input = MainViewModel.Input(viewDidLoad: rx.viewDidLoad)
    let output = vm.transform(input: input)
    
    let dataSource = RxTableViewSectionedReloadDataSource<WeatherSection> { dataSource, tableView, indexPath, item in
      let cell: WeatherTableCell = tableView.dequeueCell(indexPath)
      cell.item = item
      return cell
    }
    
    output.sections
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)
    
  }
  
}

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 2.0
    view.backgroundColor = .white
    view.clipsToBounds = true
    let cityLabel = UILabel()
    cityLabel.textColor = .gray
    cityLabel.text = vm.cities[section]
    cityLabel.font = .appleSDGothicRegular(ofSize: 26)
    view.addSubview(cityLabel)
    cityLabel.snp.makeConstraints {
      $0.left.equalTo(16)
      $0.centerY.equalTo(view)
    }
    
    return view
  }
}

class WeatherTableCell: BaseTVCell<DB.List>, ReUsable {
  let weatherImageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit
    return img
  }()

  let dayLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .appleSDGothicRegular(ofSize: 18)
    return label
  }()

  let weatherLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .appleSDGothicRegular(ofSize: 16)
    return label
  }()
  
  let tempLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .appleSDGothicRegular(ofSize: 14)
    return label
  }()

  let lineView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  
  override func setupView() {
    contentView.addSubview(dayLabel)
    contentView.addSubview(weatherImageView)
    contentView.addSubview(weatherLabel)
    contentView.addSubview(tempLabel)
    contentView.addSubview(lineView)

    dayLabel.snp.makeConstraints {
      $0.top.left.equalTo(16)
    }
    weatherImageView.snp.makeConstraints {
      $0.top.equalTo(dayLabel.snp.bottom).offset(4)
      $0.width.height.equalTo(40)
      $0.left.equalTo(dayLabel)
      $0.bottom.equalTo(-10)
    }
    weatherLabel.snp.makeConstraints {
      $0.bottom.equalTo(weatherImageView)
      $0.left.equalTo(weatherImageView.snp.right).offset(-4)
    }
    tempLabel.snp.makeConstraints {
      $0.right.equalTo(-16)
      $0.centerY.equalTo(weatherImageView)
    }
    lineView.snp.makeConstraints {
      $0.top.left.right.equalTo(0)
      $0.height.equalTo(1)
    }
  }
  
  override func bind(_ item: DB.List) {
    if !item.weather.isEmpty {
      if let url = getUrl(item.weather[0].icon) {
        var option = ImageLoadingOptions()
        option.placeholder = PlatformImage(named: "wi-cloud")
        Nuke.loadImage(with: url, options: option, into: weatherImageView)
      }
      weatherLabel.text = item.weather[0].main
    }

    if let date = item.date.dateType?.weatherDate {
      dayLabel.text = date
    }
    
    if let main = item.main {
      tempLabel.text = "Max: \(main.temp_max.celsius)°C  Min: \(main.temp_min.celsius)°C"
    }

  }

  private func getUrl(_ imgName: String) -> URL? {
    return URL(string: "http://openweathermap.org/img/wn/\(imgName)@2x.png")
  }
  
}

