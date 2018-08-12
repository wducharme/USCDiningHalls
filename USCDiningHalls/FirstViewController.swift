//
//  FirstViewController.swift
//  USCDiningHalls
//
//  Created by Will Ducharme on 6/29/18.
//  Copyright © 2018 Will DuCharme. All rights reserved.
//

import UIKit
import SwiftSoup

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var EVKBreakfastTV: UITableView!
    @IBOutlet weak var EVKBrunchTV: UITableView!
    @IBOutlet weak var EVKLunchTV: UITableView!
    @IBOutlet weak var EVKDinnerTV: UITableView!
    
    var EVKBreakfastList: [String] = []
    var EVKBrunchList: [String] = []
    var EVKLunchList: [String] = []
    var EVKDinnerList: [String] = []
    
    let cellIdentifier : String = "cell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EVKBreakfastTV.dataSource = self;
        EVKBrunchTV.dataSource = self;
        EVKLunchTV.dataSource = self;
        EVKDinnerTV.dataSource = self;
        EVKBreakfastTV.delegate = self;
        EVKBrunchTV.delegate = self;
        EVKLunchTV.delegate = self;
        EVKDinnerTV.delegate = self;
        
        
        let myURLString = "http://hospitality.usc.edu/residential-dining-menus/"
        
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            do {
                let doc = try SwiftSoup.parse(myHTMLString)
                do {
                    let mealCourse = try doc.select("fw-accordion-title-inner")
                    let dinHallList = try doc.getElementsByClass("col-sm-6 col-md-4")
                    var count = 0
                    print(try dinHallList.size())
                    for dinHall in dinHallList {
                        let currDinHall = try dinHall.select("h3.menu-venue-title")
                        if try currDinHall.text() == "Everybody's Kitchen" {
                            if count == 0 {//Breakfast
                                print("BREAKFAST")
                                let undesiredElements = try dinHall.select("span")
                                print(try undesiredElements.text())
                                print("END")
                                try undesiredElements.remove()
                                let menuItems = try dinHall.select("li")
                                for menuItem in menuItems {
                                    EVKBreakfastList.append(try (menuItem.text()))
                                }
                            }
                            else if count == 1 { //Brunch
                                print("BRUNCH")
                                let undesiredElements = try dinHall.select("span")
                                print(try undesiredElements.text())
                                print("END")
                                try undesiredElements.remove()
                                let menuItems = try dinHall.select("li")
                                for menuItem in menuItems {
                                    EVKBrunchList.append(try (menuItem.text()))
                                }
                            }
                            else if count == 2 { //Lunch
                                print("LUNCH")
                                let undesiredElements = try dinHall.select("span")
                                print(try undesiredElements.text())
                                print("END")
                                try undesiredElements.remove()
                                let menuItems = try dinHall.select("li")
                                for menuItem in menuItems {
                                    EVKLunchList.append(try (menuItem.text()))
                                }
                            }
                            else if count == 3 { //Dinner
                                print("DINNER")
                                let undesiredElements = try dinHall.select("span")
                                print(try undesiredElements.text())
                                print("END")
                                try undesiredElements.remove()
                                let menuItems = try dinHall.select("li")
                                for menuItem in menuItems {
                                    EVKDinnerList.append(try (menuItem.text()))
                                }
                            }
                            count += 1
                        }
                    }
                } catch {
                }
            }catch {
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == EVKBreakfastTV {
            return(EVKBreakfastList.count)
        }
        else if tableView == EVKBrunchTV {
            return(EVKBrunchList.count)
        }
        else if tableView == EVKLunchTV {
            return(EVKLunchList.count)
        }
        else if tableView == EVKDinnerTV {
            return(EVKDinnerList.count)
        }
        else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        if tableView == EVKBreakfastTV {
            // let cellB = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellB")
            cell.textLabel?.text = EVKBreakfastList[indexPath.row]
            return(cell)
        }
        else if tableView == EVKBrunchTV {
            //let cellBru = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellBru")
            cell.textLabel?.text = EVKBrunchList[indexPath.row]
            return(cell)
        }
        else if tableView == EVKLunchTV {
            //let cellLunch = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellLunch")
            cell.textLabel?.text = EVKLunchList[indexPath.row]
            return(cell)
        }
        else if tableView == EVKDinnerTV {
            //let cellDinner = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellDinner")
            cell.textLabel?.text = EVKDinnerList[indexPath.row]
            return(cell)
        }
        else {
            //let cellB = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellB")
            cell.textLabel?.text = EVKBreakfastList[indexPath.row]
            return(cell)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

