//
//  ViewController.swift
//  noloTest
//
//  Created by Aryan Sharma on 26/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLaunchesLabel: UILabel!
    
    
    private let cellID = "LaunchCell"
    private var launchList = [Launch]() {
        didSet {
            totalLaunchesLabel.text = "\(launchList.count)"
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
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? LaunchCell {
            cell.initWith(launch: launchList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
