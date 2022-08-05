//
//  MainViewModelTests.swift
//  FitpetTests
//
//  Created by kyo on 2022/08/03.
//

import XCTest
@testable import Fitpet

import RxCocoa
import RxSwift
import RxTest


class MainViewModelTests: XCTestCase {
  private var vm: MainViewModel!
  private var bag: DisposeBag!
  private var scheduler: TestScheduler!
  
  override func setUpWithError() throws {
    scheduler = TestScheduler(initialClock: 0)
    vm = MainViewModel()
    bag = DisposeBag()
  }

  override func tearDownWithError() throws {
    scheduler = nil
    vm = nil
    bag = nil
  }
  
  func test_city_weather() {

    let viewDidLoadTestableObservable = scheduler.createHotObservable([
        .next(20, ())
    ])

    let sectionTestableObserver = self.scheduler.createObserver([WeatherSection].self)

    let input = MainViewModel.Input(viewDidLoad: viewDidLoadTestableObservable.asObservable())
    
    vm.transform(input: input)
      .sections
      .drive(sectionTestableObserver)
      .disposed(by: bag)

    self.scheduler.start()
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Any test you write for XCTest can be annotated as throws and async.
    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
