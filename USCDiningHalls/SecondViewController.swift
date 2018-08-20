//
//  SecondViewController.swift
//  USCDiningHalls
//
//  Created by Will Ducharme on 6/29/18.
//  Copyright © 2018 Will DuCharme. All rights reserved.
//

import UIKit
import SwiftSoup

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var villageBreakfastTV: UITableView!
    @IBOutlet weak var villageBrunchTV: UITableView!
    @IBOutlet weak var villageLunchTV: UITableView!
    @IBOutlet weak var villageDinnerTV: UITableView!
    
    
    var villageBreakfastList: [String] = []
    var villageBrunchList: [String] = []
    var villageLunchList: [String] = []
    var villageDinnerList: [String] = []
    
    let cellIdentifier : String = "cell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        villageBreakfastTV.dataSource = self;
        villageBrunchTV.dataSource = self;
        villageLunchTV.dataSource = self;
        villageDinnerTV.dataSource = self;
        villageBreakfastTV.delegate = self;
        villageBrunchTV.delegate = self;
        villageLunchTV.delegate = self;
        villageDinnerTV.delegate = self;
        
        
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
                        if try currDinHall.text() == "USC Village Dining Hall" {
                            if count == 0 {//Breakfast
                                print("BREAKFAST")
                                let undesiredElements = try dinHall.select("span")
                                print(try undesiredElements.text())
                                print("END")
                                try undesiredElements.remove()
                                let menuItems = try dinHall.select("li")
                                for menuItem in menuItems {
                                    villageBreakfastList.append(try (menuItem.text()))
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
                                    villageBrunchList.append(try (menuItem.text()))
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
                                    villageLunchList.append(try (menuItem.text()))
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
                                    villageDinnerList.append(try (menuItem.text()))
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
        if tableView == villageBreakfastTV {
            return(villageBreakfastList.count)
        }
        else if tableView == villageBrunchTV {
            return(villageBrunchList.count)
        }
        else if tableView == villageLunchTV {
            return(villageLunchList.count)
        }
        else if tableView == villageDinnerTV {
            return(villageDinnerList.count)
        }
        else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        if tableView == villageBreakfastTV {
           // let cellB = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellB")
            cell.textLabel?.text = villageBreakfastList[indexPath.row]
            return(cell)
        }
        else if tableView == villageBrunchTV {
            //let cellBru = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellBru")
            cell.textLabel?.text = villageBrunchList[indexPath.row]
            return(cell)
        }
        else if tableView == villageLunchTV {
            //let cellLunch = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellLunch")
            cell.textLabel?.text = villageLunchList[indexPath.row]
            return(cell)
        }
        else if tableView == villageDinnerTV {
            //let cellDinner = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellDinner")
            cell.textLabel?.text = villageDinnerList[indexPath.row]
            return(cell)
        }
        else {
            //let cellB = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellB")
            cell.textLabel?.text = villageBreakfastList[indexPath.row]
            return(cell)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

