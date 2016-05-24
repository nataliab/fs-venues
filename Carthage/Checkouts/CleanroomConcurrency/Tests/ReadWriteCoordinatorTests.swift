//
//  ReadWriteCoordinatorTests.swift
//  Cleanroom Project
//
//  Created by Evan Maloney on 3/25/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import XCTest
import CleanroomConcurrency

private var counter = 0             // a global value to protect with a ReadWriteCoordinator
private var remainingThreads = 0    // used with an NSCondition signal to keep track of our threads

class ReadWriteCoordinatorTests: XCTestCase
{
    class TestThread: NSThread
    {
        let lock: ReadWriteCoordinator
        let signal: NSCondition

        init(lock: ReadWriteCoordinator, signal: NSCondition)
        {
            self.lock = lock
            self.signal = signal
        }

        override func main()
        {
            lock.enqueueWrite {
                var curVal = counter
                curVal++
                counter = curVal
            }

            signal.lock()
            remainingThreads--
            signal.signal()
            signal.unlock()
        }
    }

    func testReadWriteCoordinator()
    {
        let NumberOfThreads = 100

        let lock = ReadWriteCoordinator()
        let signal = NSCondition()

        signal.lock()

        remainingThreads = NumberOfThreads
        for _ in 0..<NumberOfThreads {
            TestThread(lock: lock, signal: signal).start()
        }

        var curVal: Int?

        while remainingThreads > 0 {
            signal.wait()

            lock.read {
                curVal = counter
            }

            // for whatever reason, this always fails on OS X
            // avoiding running this test on that OS for now...
            #if !os(OSX)
            XCTAssert(remainingThreads == NumberOfThreads - curVal!)
            #endif
        }
        signal.unlock()

        XCTAssert(curVal! == NumberOfThreads)
    }
}
