//
//  SecondViewController.swift
//  Swift-Tools
//
//  Created by 许菠菠 on 2017/7/18.
//  Copyright © 2017年 许菠菠. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource{

    var myTableView : UITableView!
    var dataArray : NSArray!
    var dataSouce = [CGSize]()
    let width = UIScreen.main.bounds.width
    var label : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "线程"
        label = UILabel(frame: CGRect(x: 0, y: self.view.frame.height/2, width: width, height: 40))
        label.text = "敬请期待"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: 2)
        myTableView = UITableView.init(frame: self.view.frame, style: .plain)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        myTableView.register(SecondCell.classForCoder(), forCellReuseIdentifier: "second")
        view.addSubview(myTableView)
        
        view.insertSubview(label, aboveSubview: myTableView)
        getDataSouce()
        // Do any additional setup after loading the view.
    }
    func getDataSouce()  {
        let path = Bundle.main.path(forResource: "Image", ofType: "plist")
        dataArray = NSArray.init(contentsOfFile: path!)
        DispatchQueue.global().async {
            for  imageName in self.dataArray {
                let url = URL.init(string: imageName as! String)
                do {
                    let data = try Data.init(contentsOf: url!)
                    let image = UIImage.init(data: data)
                    let size = image?.size
                    self.dataSouce.append(size!)
                }catch _ {

                }
            }
            DispatchQueue.main.async {
                self.label.isHidden = true
                self.myTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSouce.count > 0 {
            return dataArray.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSouce.count > 0 {
            let size = dataSouce[indexPath.row]
            let height = (width/size.width)*size.height
            return height
        }else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "second") as! SecondCell
        let string = self.dataArray[indexPath.row] as! String
        if dataSouce.count > 0 {
            let size = dataSouce[indexPath.row]
            let height = (width/size.width)*size.height
            cell.updateSecondCell(imageString: string, size:CGSize(width: width, height: height))
        }

        return cell
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
