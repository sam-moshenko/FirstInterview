//
//  ViewController.swift
//  InterviewTask
//
//  Created by Yeskendir Salgara on 4/15/20.
//  Copyright © 2020 Yeskendir Salgara. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    enum Identifier: String{
        case imageCellId
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }

}
private extension ViewController{
    func configureTable(){
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: Identifier.imageCellId.rawValue)
    }
}

