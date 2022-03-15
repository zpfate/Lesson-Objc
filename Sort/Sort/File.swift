//
//  File.swift
//  Sort
//
//  Created by Twisted Fate on 2022/2/16.
//

import Foundation

func mergeSort(arr: inout [Int])  {
    
    var tempArr = Array(repeating: 0, count: arr.count)
    
    mSort(arr: &arr, tempArr: &tempArr, left: 0, right: arr.count - 1)
}

func mSort(arr: inout [Int], tempArr: inout [Int], left: Int, right: Int) -> Void {
    
    if left < right {
        let mid = (left + right) / 2
        mSort(arr: &arr, tempArr: &tempArr, left: left, right: mid)
        mSort(arr: &arr, tempArr: &tempArr, left: mid + 1, right: right)
        
        merge(arr: &arr, tempArr: &tempArr, left: left, mid: mid, right: right)
    }
}

func merge(arr: inout [Int], tempArr: inout [Int], left: Int, mid: Int, right: Int) -> Void {
    
    var l_pos = left;
    var r_pos = mid + 1;
    var pos = left;
    
    while l_pos <= mid && r_pos <= right {
        ///  [9, 5, 2, 7, 12, 4, 3, 1, 11]
        if arr[l_pos] < arr[r_pos] {
            tempArr[pos] = arr[l_pos]
            l_pos += 1
        } else {
            tempArr[pos] = arr[r_pos]
            r_pos += 1
        }
        pos += 1

    }
    
    while l_pos <= mid {

        tempArr[pos] = arr[l_pos]
        pos += 1
        l_pos += 1
    }
    
    while r_pos <= right {
   
        tempArr[pos] = arr[r_pos]
        pos += 1
        r_pos += 1
    }
    
    var index = left
    while index <= right {
        arr[index] = tempArr[index]
        index += 1
    }
}
