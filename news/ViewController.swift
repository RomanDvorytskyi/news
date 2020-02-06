//
//  ViewController.swift
//  news
//
//  Created by Roman Dvoritskiy on 05.02.2020.
//  Copyright © 2020 Roman Dvoritskiy. All rights reserved.
//

import UIKit
import SafariServices
import NewsAPISwift
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    
    var refreshC = UIRefreshControl()
    var source = "country=us"
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Func.shared.articles?.count ?? 0
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()

       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if Func.shared.articles?[indexPath.item].headline != nil && Func.shared.articles?[indexPath.item].description != nil {
            cell.title.text = Func.shared.articles?[indexPath.item].headline
            print(indexPath.row)
            cell.author.text = Func.shared.articles?[indexPath.item].author
            cell.descriptions.text = Func.shared.articles?[indexPath.item].descriptions
            if Func.shared.articles?[indexPath.item].imageUrl != nil {
                cell.imagesView.downloadImage(from: (Func.shared.articles?[indexPath.item].imageUrl!)!)
                
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Func.shared.articles?[indexPath.item].url != nil {
            let url = Func.shared.articles?[indexPath.item].url
            if let urlS = URL(string: url!) {
                let vc = SFSafariViewController(url: urlS)
                vc.delegate = self
                present(vc, animated: true, completion: nil)
            }
            
        }
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func addRefresh() {
        refreshC = UIRefreshControl()
        refreshC.tintColor = UIColor.gray
        refreshC.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.addSubview(refreshC)
    }
    @objc func refreshList() {
        refreshC.endRefreshing()
        tableView.reloadData()
        print("S")
        Func.shared.fetchArticles(fromSource: source)
        
    }
        let menuManager = MenuManager()
    @IBAction func menuPress(_ sender: Any) {
        menuManager.openMenu()
        menuManager.mainVC = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        Func.shared.fetchArticles(fromSource: source)
        addRefresh()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        //        tableView.tableFooterView = UIView.init(frame: .zero)
        // Do any additional setup after loading the view.
    }
    
    
}

extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        task.resume()
    }
}

