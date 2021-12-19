//
//  AddItemViewControllerDelegate.swift
//  ToDoListApp
//
//  Created by Linah abdulaziz on 11/05/1443 AH.
//

import Foundation
import UIKit
protocol AddItemViewControllerDelegate :class{
    func itemSaved( with object: ToDoListItem)
}
