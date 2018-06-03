//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var str = "Hello, playground"

let disposeBag = DisposeBag()

func solve1(value: Int) -> Observable<Int> {
    return Observable.empty()
}

solve1(value: 5).subscribe(onNext: { value in
    if value == 5 {
        print("Riddle 1 : solved!")
    } else {
        print("Riddle 1 : failed :(")
    }
}).disposed(by: disposeBag)
