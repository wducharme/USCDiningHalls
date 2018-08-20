//
//  ThirdViewController.swift
//  USCDiningHalls
//
//  Created by Will Ducharme on 6/29/18.
//  Copyright © 2018 Will DuCharme. All rights reserved.
//

import UIKit
import SwiftSoup

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ParksideBreakfastTV: UITableView!
    @IBOutlet weak var ParksideBrunchTV: UITableView!
    @IBOutlet weak var ParksideLunchTV: UITableView!
    @IBOutlet weak var ParksideDinnerTV: UITableView!
    
    var ParksideBreakfastList: [String] = []
    var ParksideBrunchList: [String] = []
    var ParksideLunchList: [String] = []
    var ParksideDinnerList: [String] = []
    
    let cellIdentifier : String = "cell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParksideBreakfastTV.dataSource = self;
        ParksideBrunchTV.dataSource = self;
        ParksideLunchTV.dataSource = self;
        ParksideDinnerTV.dataSource = self;
        ParksideBreakfastTV.delegate = self;
        ParksideBrunchTV.delegate = self;
        ParksideLunchTV.delegate = self;
        ParksideDinnerTV.delegate = self;
        
        
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
                        if try currDinHall.text() == "Parkside Restaurant & Grill" {
                            if count == 0 {//Breakfast
                                print("BREAKFAST")
                                let undesiredElements = try dinHall.select("span")
                                print(try undesiredElements.text())
                                print("END")
                                try undesiredElements.remove()
                                let menuItems = try dinHall.select("li")
                                for menuItem in menuItems {
                                    ParksideBreakfastList.append(try (menuItem.text()))
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
                                    ParksideBrunchList.append(try (menuItem.text()))
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
                                    ParksideLunchList.append(try (menuItem.text()))
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
                                    ParksideDinnerList.append(try (menuItem.text()))
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
        if tableView == ParksideBreakfastTV {
            return(ParksideBreakfastList.count)
        }
        else if tableView == ParksideBrunchTV {
            return(ParksideBrunchList.count)
        }
        else if tableView == ParksideLunchTV {
            return(ParksideLunchList.count)
        }
        else if tableView == ParksideDinnerTV {
            return(ParksideDinnerList.count)
        }
        else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        if tableView == ParksideBreakfastTV {
            // let cellB = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellB")
            cell.textLabel?.text = ParksideBreakfastList[indexPath.row]
            return(cell)
        }
        else if tableView == ParksideBrunchTV {
            //let cellBru = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellBru")
            cell.textLabel?.text = ParksideBrunchList[indexPath.row]
            return(cell)
        }
        else if tableView == ParksideLunchTV {
            //let cellLunch = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellLunch")
            cell.textLabel?.text = ParksideLunchList[indexPath.row]
            return(cell)
        }
        else if tableView == ParksideDinnerTV {
            //let cellDinner = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellDinner")
            cell.textLabel?.text = ParksideDinnerList[indexPath.row]
            return(cell)
        }
        else {
            //let cellB = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellB")
            cell.textLabel?.text = ParksideBreakfastList[indexPath.row]
            return(cell)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


