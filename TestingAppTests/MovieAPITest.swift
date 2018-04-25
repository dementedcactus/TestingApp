//
//  MovieAPITest.swift
//  TestingAppTests
//
//  Created by Richard Crichlow on 4/24/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import XCTest
@testable import TestingApp

class MovieAPITests: XCTestCase {
    
    //each test should test only one thing!!
    
    //meant to test if the api is able to grab the right data
    func testMovieAPI() {
        //XCTestExpectation is for testing asynchronous calls/network requests
        let movieResultsExpectation = XCTestExpectation(description: "movie results received")
        //start network request
        MovieAPI.manager.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                //Fail test
                XCTFail("Could not get data: \(error)")
            } else if let data = data {
                do {
                    //Network request fulfilled
                    movieResultsExpectation.fulfill()
                    let movieSearch = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    let movies = movieSearch.results
                    //Assert Test - test to compare two values, one being the actual number, the other being the expectation
                    //check count
                    XCTAssertEqual(movies.count, 67, "Number of results should be greater than 0 and less than 100") // There is also XCTAssertLessThan, GreaterThan, LessThanOrEqualToo, GreaterThanOrEqualToo, True, False, etc...
                    
                } catch {
                    //Fail test
                    XCTFail("Decoding error: \(error)")
                }
            }
        }
        //wait 10 seconds for results because it's async
        wait(for: [movieResultsExpectation], timeout: 10)
    }
    
    //test if movies exists
    func testMovieExists() {
        //XCTestExpectation is for testing asynchronous calls/network requests
        let movieResultsExpectation = XCTestExpectation(description: "movie results exist")
        //start network request
        MovieAPI.manager.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                //Fail test
                XCTFail("Could not get data: \(error)")
            } else if let data = data {
                do {
                    //Network request fulfilled
                    movieResultsExpectation.fulfill()
                    let movieSearch = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    let movies = movieSearch.results
                    //Assert Test - test to compare two values, one being the actual number, the other being the expectation
                    //check if first result is correct
                    XCTAssertEqual(movies[0].trackName, "Blue Collar Comedy Tour: One for the Road", "Movie does not exist")
                } catch {
                    //Fail test
                    XCTFail("Decoding error: \(error)")
                }
            }
        }
        //wait 10 seconds for results because it's async
        wait(for: [movieResultsExpectation], timeout: 10)
    }
    
    //test if any unrated movies exists
    func testUnratedMovieExists() {
        //XCTestExpectation is for testing asynchronous calls/network requests
        let movieResultsExpectation = XCTestExpectation(description: "movie results exist")
        //start network request
        MovieAPI.manager.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                XCTFail("Could not get data: \(error)")
            } else if let data = data {
                do {
                    //Network request fulfilled
                    movieResultsExpectation.fulfill()
                    let movieSearch = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    let movies = movieSearch.results
                    let unratedMovies = movies.filter({ (movies) -> Bool in
                        return movies.contentAdvisoryRating == "Unrated"
                    })
                    XCTAssertGreaterThan(unratedMovies.count, 0, "Number of results should be greater than 0")
                } catch {
                    XCTFail("Decoding error: \(error)")
                }
            }
        }
        //wait 10 seconds for results because it's async
        wait(for: [movieResultsExpectation], timeout: 10)
    }
}
