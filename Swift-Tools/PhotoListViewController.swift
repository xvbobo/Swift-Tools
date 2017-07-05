//
//  PhotoListViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/6/16.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos

class PhotoListViewController: BaseViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    ///取得的资源结果，用了存放的PHAsset
    
    var allPhotos =  PHFetchResult<PHAsset>()
    var myCollectionView : UICollectionView!
    var bigImageView : UIImageView! = nil
    var bigImagesDataSource = [UIImage]()
    var imagesDataSource = [UIImage]()
    let width = (UIScreen.main.bounds.width - 40)/3
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "相册"
        setPhotoListUI()
        getData()
        
    }
    
    func setPhotoListUI() {
        bigImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width:UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height - 64))
        bigImageView.backgroundColor = .lightGray
        bigImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageClick))
        bigImageView.addGestureRecognizer(tap)
        bigImageView.isHidden = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: width, height: width)
        myCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(PhotoCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        myCollectionView.backgroundColor = .white
        view.addSubview(myCollectionView)
        view.insertSubview(bigImageView, aboveSubview: myCollectionView)
    }
    func imageClick() {
        bigImageView.isHidden = true
    }
    func getData() {
        allPhotos.enumerateObjects({ (objectImage, count, stop) in
            self.imagesDataSource.append (self.PHAssetToUIImage(asset: objectImage , size: CGSize(width: self.width, height: self.width)))
            self.bigImagesDataSource.append (self.PHAssetToUIImage(asset: objectImage , size: CGSize(width: objectImage.pixelWidth, height: objectImage.pixelHeight)))
            
        })
        
        self.myCollectionView.reloadData()

    }
    //size:裁剪图片的大小
    func PHAssetToUIImage(asset: PHAsset , size: CGSize) -> UIImage {
        var image = UIImage()
        
        // 新建一个默认类型的图像管理器imageManager
        let imageManager = PHImageManager.default()
        
        // 新建一个PHImageRequestOptions对象
        let imageRequestOption = PHImageRequestOptions()
        
        // PHImageRequestOptions是否有效
        imageRequestOption.isSynchronous = true
        
        // 缩略图的压缩模式设置为无
        imageRequestOption.resizeMode = .none
        
        // 缩略图的质量为高质量，不管加载时间花多少
        imageRequestOption.deliveryMode = .highQualityFormat
        
        // 按照PHImageRequestOptions指定的规则取出图片
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
            (result, _) -> Void in
            image = result!
        })
        return image
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.imagesDataSource.count%3 == 0 {
            return self.imagesDataSource.count/3

        }else {
            return self.imagesDataSource.count/3 + 1

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        if 3 * indexPath.section + indexPath.item < self.imagesDataSource.count {
            cell.updateImage(image: self.imagesDataSource[3 * indexPath.section + indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.bigImagesDataSource[3 * indexPath.section + indexPath.item]
        bigImageView.isHidden = false
        bigImageView.contentMode = .scaleAspectFit
        bigImageView.image = image
    }

    override func backToUpView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
