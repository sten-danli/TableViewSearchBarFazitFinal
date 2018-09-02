//
//  DetailViewController.swift
//  MincraftDicFazitFinal
//
//  Created by Dan Li on 28.08.18.
//  Copyright © 2018 DanStenLee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detaiData:DataModle!
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var textField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(detaiDatas: detaiData)
    }

    func setup(detaiDatas:DataModle){
        myImageView.image=UIImage(named: "\(detaiData.name)")
        nameLabel.text=detaiData.name
        textField.text=detaiData.info
    }

}
