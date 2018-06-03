//Spoiler alert! Solutions below....

import UIKit
import RxSwift
import RxTest
import RxSwiftFramework

/**
 * Riddle 1
 
 * Transform the given [value] into an Observable that emits the value and then completes.
 *
 * Use case: You want to transform some value to the reactive world.
 */

func solve1(value: Int) -> Observable<Int> {
    return Observable.just(value)
}

var testScheduler = TestScheduler(initialClock: 0)
var observerInt = testScheduler.createObserver(Int.self)
solve1(value: 5).subscribe(observerInt)
testScheduler.start()

if observerInt.events == [Recorded.next(0,5), Recorded.completed(0)] {
    print("Riddle 1 : solved!")
} else {
    print("Riddle 1 : failed!")
}


/**
 * Riddle 2
 
 * Increment each emitted value of the given [source] by 1.
 *
 * Use case: You want to transform the data.
 */
func solve2(source: Observable<Int>) -> Observable<Int> {
    return source.map { $0 + 1 }
}

testScheduler = TestScheduler(initialClock: 0)
observerInt = testScheduler.createObserver(Int.self)
solve2(source: Observable.from([1,5,9])).subscribe(observerInt)
testScheduler.start()

if observerInt.events == [Recorded.next(0,2),Recorded.next(0,6),Recorded.next(0,10),Recorded.completed(0)] {
    print("Riddle 2 : solved!")
} else {
    print("Riddle 2 : failed!")
}


/**
 * Riddle 3
 
 * Don't emit odd numbers from the [source] Observable.
 *
 * Use case: You want to filter certain items out.
 */
func solve3(source: Observable<Int>) -> Observable<Int> {
    return source.filter { $0 % 2 == 0 }
}

testScheduler = TestScheduler(initialClock: 0)
observerInt = testScheduler.createObserver(Int.self)
solve3(source: Observable.from(0...10)).subscribe(observerInt)
testScheduler.start()

if observerInt.events == [Recorded.next(0,0),Recorded.next(0,2),Recorded.next(0,4),Recorded.next(0,6),Recorded.next(0,8),Recorded.next(0,10),Recorded.completed(0)] {
    print("Riddle 2 : solved!")
} else {
    print("Riddle 2 : failed!")
}


/**
 * Riddle 4
 
 * Implement a toggle mechanism. With a starting value of false.
 * Every time [source] emits, we want to negate the previous value.
 *
 * Use case: Some button that can toggle two states. For instance a switch.
 */
func solve4(source: Observable<Int>) -> Observable<Bool> {
    return source.scan(false, accumulator: { (toggle, _) -> Bool in
        return !toggle
    })
}

testScheduler = TestScheduler(initialClock: 0)
var observerBool = testScheduler.createObserver(Bool.self)

solve4(source: Observable.from(1...3)).subscribe(observerBool)
testScheduler.start()

if observerBool.events == [Recorded.next(0, true), Recorded.next(0, false), Recorded.next(0, true), Recorded.completed(0)] {
    print("Riddle 4 : solved!")
} else {
    print("Riddle 4 : failed!")
}


/**
 * Riddle 5
 
 * Sum up the latest values of [first] and [second] whenever one of the Observables emits a new value.
 *
 * Use case: Two input fields in a calculator that need to be summed up and the result should be updated every time one of the inputs change.
 */
func solve5(first: Observable<Int>, second: Observable<Int>) -> Observable<Int> {
    return Observable.combineLatest(first, second) { $0 + $1 }
}

testScheduler = TestScheduler(initialClock: 0)
observerInt = testScheduler.createObserver(Int.self)

let subject1 = BehaviorSubject<Int>(value: 0)
let subject2 = BehaviorSubject<Int>(value: 0)

solve5(first: subject1, second: subject2).subscribe(observerInt)
testScheduler.start()

var solved = true
solved = observerInt.events == [Recorded.next(0,0)] && solved

subject1.onNext(2)
solved = observerInt.events == [Recorded.next(0,0), Recorded.next(0,2)] && solved

subject2.onNext(5)
solved = observerInt.events == [Recorded.next(0,0), Recorded.next(0,2), Recorded.next(0,7)] && solved

subject1.onNext(-3)
solved = observerInt.events == [Recorded.next(0,0), Recorded.next(0,2), Recorded.next(0,7), Recorded.next(0,2)] && solved

if solved {
    print("Riddle 5 : solved!")
} else {
    print("Riddle 5 : failed!")
}
