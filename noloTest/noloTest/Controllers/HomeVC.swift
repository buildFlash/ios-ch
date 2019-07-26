//
//  ViewController.swift
//  noloTest
//
//  Created by Aryan Sharma on 26/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import UIKit
import Dollar

class HomeVC: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLaunchesLabel: UILabel!
    
    
    private let cellID = "LaunchCell"
    
    
    var sections = Dictionary<String,Array<Launch>>()
    var sortedSections = [String]()
    var launchList = [Launch]() {
        didSet {
            totalLaunchesLabel.text = "\(launchList.count)"

            self.launchList.sort { (o1, o2) -> Bool in
                return o1.launch_date_utc < o2.launch_date_utc
            }
            sections = Dollar.groupBy(launchList, callback: { $0.launch_year })
            sortedSections = sections.keys.sorted()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        setupViews()
    }
    
    private func setupViews() {
        totalView.layer.cornerRadius = totalView.frame.height/2
        totalView.dropShadow()
        
        greetingLabel.text = getGreeting() + ", Aryan"
        
        setupTableView()
    }

    private func fetchData() {
        APIService.shared.fetchLaunches(after: "2014-01-01") { (result) in
            switch result {
            case .error(let err) :
                Alert.handleError(err)
                break
                
            case .success(let res):
                self.launchList = res
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            }
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "LaunchCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    private func getGreeting() -> String {
        var greeting = "Good Morning"
        let date = Date()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date)
        guard let hourInt = Int(currentHour.description) else { return greeting }
        
        if hourInt >= 12 && hourInt <= 18 {
            greeting = "Good Afternoon"
        } else if hourInt >= 0 && hourInt <= 12 {
            greeting = "Good Morning"
        } else if hourInt >= 18 && hourInt <= 24 {
            greeting = "Good Evening"
        }
        return greeting
    }

}


extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let launch = launchList[indexPath.row]
        let message = "Rocket used: \(launch.rocket.rocket_name)" + "\n" + "Mission ID: \(launch.mission_id.first ?? "N/A")" + "\n" + "Flight # \(launch.flight_number)"
        
        Alert.showOKSCAlert(message: message, title: launch.mission_name)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 40,
                                                y: 10,
                                                width: UIScreen.main.bounds.width,
                                                height: 30))
        returnedView.backgroundColor = UIColor(red: 246.0/255.0,
                                               green: 244.0/255.0,
                                               blue: 241.0/255.0,
                                               alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 40,
                                          y: 0,
                                          width: UIScreen.main.bounds.width,
                                          height: 30))
        label.font = UIFont(name: "AvenirNext-Bold", size: 13)
        label.textColor = .darkGray
        label.text = sortedSections[section]
        returnedView.addSubview(label)
        
        return returnedView
    }

}

extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[sortedSections[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? LaunchCell,
            let launch = sections[sortedSections[indexPath.section]]?[indexPath.row] {
            cell.initWith(launch: launch)
            return cell
        }
        return UITableViewCell()
    }
    
}
