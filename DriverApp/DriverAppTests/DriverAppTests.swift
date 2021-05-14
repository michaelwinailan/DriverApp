//
//  DriverAppTests.swift
//  DriverAppTests
//
//  Created by Michael Winailan on 5/14/21.
//

@testable import DriverApp
import XCTest

class DriverAppTests: XCTestCase {
    var uploadViewModel: UploadViewModel!
    var cityViewModel: CityViewModel!
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        uploadViewModel = nil
        cityViewModel = nil
        super.tearDown()
    }
    
    func test_city_table_view_cell() throws {
        cityViewModel = CityViewModel(driver: Driver())
        cityViewModel.operatingCities = ["San Francisco", "Los Angeles", "Austin"]
        
        let firstIndexPath = IndexPath(row: 0, section: 0)
        let firstCell = CityTableViewCell()
        cityViewModel.setCellTitle(cell: firstCell, indexPath: firstIndexPath, cityVC: CityViewController())
        let firstCellName:String = firstCell.cityNameButton.titleLabel!.text!
        XCTAssertEqual("San Francisco", firstCellName)
        
        let otherIndexPath = IndexPath(row: cityViewModel.operatingCities.count, section: 0)
        let otherCell = CityTableViewCell()
        cityViewModel.setCellTitle(cell: otherCell, indexPath: otherIndexPath, cityVC: CityViewController())
        let otherCellName:String = otherCell.cityNameButton.titleLabel!.text!
        XCTAssertEqual("Other", otherCellName)
    }
    
    func test_upload_progress_is_valid() throws {
        uploadViewModel = UploadViewModel(driver: Driver(), isPresentedByConfirmVC: false)
        XCTAssertEqual(0.22, uploadViewModel.progress)
        
        uploadViewModel = UploadViewModel(driver: Driver(), isPresentedByConfirmVC: true)
        XCTAssertEqual(0.67, uploadViewModel.progress)
    }
}
