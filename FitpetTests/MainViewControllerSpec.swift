//
//  MainViewControllerSpec.swift
//  FitpetTests
//
//  Created by kyo on 2022/08/03.
//

import Quick
import Nimble
import RxSwift
@testable import Fitpet

class MainViewControllerSpec: QuickSpec {
  
  override func spec() {
    var vc: MainViewController!

    beforeEach {
      vc = MainViewController()
    }

    describe("viewDidLoad") {
      expect(vc).notTo(beNil())
      let _ = vc.view
    }

    sleep(10)

    context("loaded") {
      expect(vc.tableView.numberOfRows(inSection: 0)).to(equal(6))
    }
    
  }
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
