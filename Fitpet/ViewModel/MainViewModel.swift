//
//  MainViewModel.swift
//  Fitpet
//
//  Created by kyo on 2022/08/01.
//

import RxDataSources
import RxAlamofire
import RxCocoa
import RxSwift

struct MainViewModel: ViewModelType {

  private(set) var cities = ["Seoul", "London", "Chicago"]
  private let bag = DisposeBag()

  struct Input {
    let viewDidLoad: Observable<()>
  }

  struct Output {
    let sections: Driver<[WeatherSection]>
  }

  func transform(input: Input) -> Output {

    let sections =
    input.viewDidLoad
    .flatMap {
      Observable.zip(
        self.cities.map { RxAlamofire.requestData(.get, self.getUrl($0)) }
      )
    }
    .map { list -> [WeatherSection] in

      var sections = [WeatherSection]()
      for (index, weather) in list.enumerated() {
        let list = try DB.ForecastWeather.decode(data: weather.1).list
        let section = WeatherSection(cityTitle: cities[index], items: list.unique(value: {$0.date} ))
        sections.append(section)
      }
      return sections
    }
    .asDriver(onErrorJustReturn: [])

    return Output(sections: sections)
  }

  private func getUrl(_ city: String) -> String {
    return "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(Const.API_KEY_WHETHER)"
  }

}
