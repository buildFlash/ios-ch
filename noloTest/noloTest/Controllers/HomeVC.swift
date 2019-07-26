//
//  ViewController.swift
//  noloTest
//
//  Created by Aryan Sharma on 26/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellID = "LaunchCell"
    private var launchList = [Launch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
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
        let nib = UINib(nibName: "LaunchCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }

}


extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
