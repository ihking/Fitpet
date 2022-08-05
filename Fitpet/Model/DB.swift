//
//  DB.swift
//  Fitpet
//
//  Created by kyo on 2022/07/30.
//

import RxDataSources
import RxCocoa

struct DB {
  
  struct ForecastWeather: Decodable {
    let cod: String
    let list: [List]
  }
  
  struct List: Decodable,
               Equatable,
               IdentifiableType {
    var identity: String { return "" }

    static func == (lhs: DB.List, rhs: DB.List) -> Bool {
      return lhs.date == rhs.date
    }

    let main: Main?
    let weather: [Weather]
    let dt_txt: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case main, dt_txt, weather
    }

    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

      main = try values.decodeIfPresent(Main.self, forKey: .main) ?? nil
      weather = try values.decodeIfPresent([Weather].self, forKey: .weather) ?? []
      dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt) ?? ""
      date = dt_txt.components(separatedBy: " ")[0]
    }

  }

  struct Main: Decodable {
    let temp_max: Double
    let temp_min: Double
  }

  struct Weather: Decodable {
    let main: String
    let icon: String
  }

}

struct WeatherSection: Equatable {
  var cityTitle: String
  var items: [Item]
}

extension WeatherSection: AnimatableSectionModelType {
  typealias Item = DB.List

  var identity: String {
    return cityTitle
  }

  init(original: WeatherSection, items: [DB.List]) {
    self = original
    self.items = items
  }

}
