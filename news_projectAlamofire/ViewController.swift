//
//  ViewController.swift
//  news_projectAlamofire
//
//  Created by Berker Vergi on 1.12.2020.
//

import UIKit
import Alamofire
import Kingfisher

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
    
    override func viewDidLayoutSubviews() {
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
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCollectionViewCell
        cell.newsTitle.text = dataSourceArray[indexPath.row].title!
//        let url = URL(string: dataSourceArray[indexPath.row].urlToImage!)
        cell.layer.cornerRadius = 12
        if let newImage = dataSourceArray[indexPath.row].urlToImage {
            cell.newsImage.kf.setImage(with: URL(string:  newImage))
        }
        
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
            //            Tips CollectionView Layouts.
            let layout       = Collection.collectionViewLayout as? UICollectionViewFlowLayout
            let itemWidth    = Collection.bounds.width / 1.3
            let itemHeight   = Collection.bounds.height / 1.0
            layout!.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout!.invalidateLayout()
            return CGSize(width: itemWidth, height: itemHeight)
       
    }
    
}




