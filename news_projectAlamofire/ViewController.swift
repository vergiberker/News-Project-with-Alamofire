//
//  ViewController.swift
//  news_projectAlamofire
//
//  Created by Berker Vergi on 1.12.2020.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var dataSourceArray = [News]()
    
    @IBOutlet weak var helloLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var todayNewsLbl: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
//    newsCollectionView
    @IBOutlet weak var Collection: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        ApiManager.shared.newsRequest { (int, err, news) in
            if err == nil {
                self.dataSourceArray = news
                self.Collection.reloadData()
            }else{
                print(err?.localizedDescription)
            }
          
        }
        makeRounded()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func makeRounded()  {
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.gray.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }
    
}


// MARK: CollectionView Ext.
@available(iOS 12.0, *)
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCollectionViewCell
        cell.newsTitle.text = dataSourceArray[indexPath.row].title!
//        let url = URL(string: dataSourceArray[indexPath.row].urlToImage!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
        
    }
    
}




