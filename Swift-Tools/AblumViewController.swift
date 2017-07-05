//
//  AblumViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/5.
//  Copyright © 2017年 许菠菠. All rights reserved.
//  相册列表

import UIKit
import Photos
class AblumViewController: BaseViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var ablumTableView: UITableView!
    var dataSource = [PHAssetCollection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "相册"
        ablumTableView.delegate = self
        ablumTableView.dataSource = self
        ablumTableView.rowHeight = 50
        ablumTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ablum")
        fetchAllSystemAlbum()

        // Do any additional setup after loading the view.
    }
    func fetchAllSystemAlbum()  {
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        
        for i in 0..<smartAlbums.count {
            let collection = smartAlbums[i]
            if collection.isKind(of: PHAssetCollection.classForCoder()) {
                let assetsFetchResults : PHFetchResult  = PHAsset.fetchAssets(in: collection, options: nil)
                if assetsFetchResults.count != 0 && collection.localizedTitle != "视频" {
                    dataSource.append(collection)
                }
                
                
            }
            
        }
        ablumTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ablum")
        if dataSource.count > 0 {
            let collection = dataSource[indexPath.row]
            let fetchResult = PHAsset.fetchAssets(in: collection, options: nil)
            cell?.textLabel?.text = collection.localizedTitle! + "(\(fetchResult.count)张照片)"
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoListViewController = PhotoListViewController()
        let collection = dataSource[indexPath.row]
        let fetchResult : PHFetchResult = PHAsset.fetchAssets(in: collection, options: nil)
        photoListViewController.allPhotos = fetchResult
        self.navigationController?.pushViewController(photoListViewController, animated: true)
    }
    
    override func backToUpView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
