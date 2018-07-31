//
//  FlickaloreTests.swift
//  FlickaloreTests
//
//  Created by Aaqib Hussain on 25/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import XCTest
@testable import Flickalore
import FlickrKit

class FlickaloreTests: XCTestCase {
    
    var user: User!
    override func setUp() {
        super.setUp()
        user = User(userName: "iaaqibhussain", name: "Aaqib Hussain", userId: "122321", accessToken: URL(string: "https://kodesnippets.com")!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProfileModel() {
        let dummyNumberOfItems = 8
        let dummyUrlAtIndexZero = "https://farm1.static.flickr.com/269/19866604203_d4844b464d_z.jpg"
        let dummyUrlAtIndexSeven = "https://farm9.static.flickr.com/8586/16654466322_2292749dcd_z.jpg"
        let mockModel = MockFlickrKit()
        let profileViewModel = ProfileViewModel(flickrKit: mockModel, user: user)
        profileViewModel.getPhotos()
        XCTAssertEqual(dummyNumberOfItems, profileViewModel.numberOfItems)
        XCTAssertEqual(dummyUrlAtIndexZero, profileViewModel.itemAtIndex(index: 0).absoluteString)
        XCTAssertEqual(dummyUrlAtIndexSeven, profileViewModel.itemAtIndex(index: 7).absoluteString)
    }
    
    func testExploreModel() {
        
        let dummyUrlAtZeroIndex = "https://farm1.static.flickr.com/941/29840068448_348f60c2a4_z.jpg"
        let dummyUrlAtFourthIndex = "https://farm1.static.flickr.com/930/29852550978_f89573be44_z.jpg"
        let dummyDataCount = 5
        let mockModel = MockFlickrKit()
        let exploreViewModel = ExploreViewModel(flickrKit: mockModel, user: user)
            exploreViewModel.getExplore()
        XCTAssertEqual(dummyDataCount, exploreViewModel.numberOfItems)
        XCTAssertEqual(dummyUrlAtZeroIndex, exploreViewModel.itemAtIndex(index: 0).absoluteString)
        XCTAssertEqual(dummyUrlAtFourthIndex, exploreViewModel.itemAtIndex(index: 4).absoluteString)
        }
        
}

