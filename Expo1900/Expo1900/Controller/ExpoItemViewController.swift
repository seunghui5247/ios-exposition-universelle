//
//  ExpoItemViewController.swift
//  Expo1900
//
//  Created by 천승희 on 2022/09/27.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var workImage: UIImageView!
}

class ExpoItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var items: [ExpositionData]? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.titleLabel.text = items?[indexPath.row].name
        cell.descriptionLabel.text = items?[indexPath.row].shortDesc
        cell.workImage.image = UIImage(named: items?[indexPath.row].imageName ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pushVC: ExpoItemDetailViewController = self.storyboard?.instantiateViewController(identifier: "expoItemDetailPage") else {
            return
        }
        pushVC.item = items?[indexPath.row]
        
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let expoData: NSDataAsset = NSDataAsset.init(name: "items") else {
            return
        }
        let jsonDecoder = JSONDecoder()

        do {
            self.items = try jsonDecoder.decode([ExpositionData].self, from: expoData.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.navigationController?.isNavigationBarHidden = false
    }
}
