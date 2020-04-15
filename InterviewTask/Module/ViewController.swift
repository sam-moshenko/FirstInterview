//
//  ViewController.swift
//  InterviewTask
//
//  Created by Yeskendir Salgara on 4/15/20.
//  Copyright © 2020 Yeskendir Salgara. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UICollectionViewController {
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

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

        collectionView.delegate = nil
        collectionView.dataSource = nil
        
        viewModel.images
            .bind(
                to: collectionView.rx.items(
                    cellIdentifier: Identifier.imageCellId.rawValue,
                    cellType: ImageCollectionCell.self)) { (row, element, cell) in
                        cell.setup(image: element)
        }.disposed(by: disposeBag)

        collectionView.rx
            .willDisplayCell
            .map { $1.row }
            .bind(to: viewModel.willDisplay)
            .disposed(by: disposeBag)
    }
}

