//
//  EventMeTableDelegate.swift
//  EventMe
//
//  Created by Harrison Anthony on 9/18/23.
//

import UIKit

extension EventMe {
    
    func setupTable() {
        
        self.tableView.delegate     = self
        self.tableView.dataSource   = self
        
        tableView.register(UINib(nibName: "EvemtCell", bundle: nil), forCellReuseIdentifier: "EventCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell {
            
            let event = self.event[indexPath.row]
            
            cell.name.text          = event.name
            cell.address1.text      = event.location.address1
            cell.cityStateZip.text  =
                String(format: "%@ %@  %@",
                       event.location.city,
                       event.location.state,
                       event.location.zip_code)
            cell.url.text           = "Website"
            cell.url.textColor      = .systemBlue
            createUrl(label: cell.url, urlString: event.url)
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func createUrl(label: UILabel, urlString: String) {
        let tap = Tap(target: self, action: #selector(tapped(_:)))
        tap.urlString                   = urlString
        label.isUserInteractionEnabled  = true
        label.addGestureRecognizer(tap)
        
    }
    
    @objc func tapped(_ sender: Tap) {
        print(sender.urlString)
        if let url = URL(string: sender.urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                
                success in
                
                if success {
                    print("Success!")
                } else {
                    print(String(format: "Can't open url: %@", sender.urlString))
                }
                
            })
        }
    }
}

