//
//  CrashBlock.swift
//  KSCrashSample
//
//  Created by alex on 11.06.2023.
//

import Foundation

let crashBlock = {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        let a = [0]
        print(a[1])
    }
}