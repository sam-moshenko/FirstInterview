//
//  ViewModel.swift
//  InterviewTask
//
//  Created by Semen Lebedev on 4/15/20.
//  Copyright © 2020 Yeskendir Salgara. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire
import RxAlamofire

class ViewModel {
    // Input
    var pageSize = 100
    var itemsLeftToLoad = 50
    let willDisplay = BehaviorRelay<Int>(value: 0)

    // Output
    let images = BehaviorSubject<[UIImage]>(value: [])

    let disposeBag = DisposeBag()

    init() {
        setupObservables()
    }

    func setupObservables() {
        willDisplay
            .withLatestFrom(images) { (willDisplay: $0, images: $1) }
            .flatMap { [unowned self] tuple -> Observable<[UIImage]> in
                let itemsLeft = (tuple.images.count - 1) - tuple.willDisplay
                if itemsLeft == self.itemsLeftToLoad || tuple.images.count == 0 {
                    return self.downloadImages(count: self.pageSize)
                } else {
                    return .empty()
                }
        }.scan([]) { (oldImages, newImages) -> [UIImage] in
            var result = oldImages
            result.append(contentsOf: newImages)
            return result
        }
        .bind(to: images).disposed(by: disposeBag)
    }

    private func downloadImages(count: Int) -> Observable<[UIImage]> {
        return Observable.from(0..<count)
            .reduce([Observable<UIImage>]()) { [unowned self] (images, _) in
                var images = images
                images.append(self.downloadImage())
                return images
        }.flatMap {
            Observable.zip($0)
        }
    }

    private func downloadImage() -> Observable<UIImage> {
        RxAlamofire.requestData(URLRequest(url: API.photo.url)).map {
            UIImage(data: $1)!
        }
    }
}
