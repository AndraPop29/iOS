//
//  main.swift
//  exercise
//
//  Created by Andra Pop on 02/10/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import Foundation


  public class ListNode {
      public var val: Int
      public var next: ListNode?
      public init(_ val: Int) {
          self.val = val
          self.next = nil
    }
 }
 
class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let list1 = l1 else { return nil }
        guard let list2 = l2 else { return nil }
        var val1 = list1
        var val2 = list2
        var rest = 0
        
        var dummy = ListNode((val1.val + val2.val) % 10)
        var curr = dummy
        rest = val1.val + val2.val / 10
        while(val1.next != nil && val2.next != nil) {
            val1 = (val1.next)!
            val2 = (val2.next)!
            var newNode = ListNode((val1.val + val2.val) % 10 + rest)
            rest = val1.val + val2.val / 10

            curr.next = newNode

            curr = curr.next!
        }
        return dummy.next
        
    }
}
