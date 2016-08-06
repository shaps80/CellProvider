//
//  CellProviding.swift
//  GenericCells
//
//  Created by Shaps Mohsenin on 06/08/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

/**
 *  This could be a ViewController or an external class that knows how to configure the cell and return it
 */
public protocol CellProviding {
  
  /**
   Returns a cell provider
   
   - parameter indexPath: The indexPath for the cell to configure
   - parameter dataView:  The view that will host this cell
   
   - returns: A cell provider
   */
  func cellProvider<D: DataView>(forRowAt indexPath: NSIndexPath, in dataView: D) -> CellProvider
}

/**
 *  This is a simple wrapper around a cell to provide Generics and type safety. You should generally never need to retain this anywhere.
 */
public struct CellProvider {
  
  /// Use this property to get the dequeue cell
  public unowned let cell: DataCell
  
  /**
   Initializes this provider with the specified configuration
   
   - parameter dataView:        The view that will host the cell
   - parameter reuseIdentifier: The reuseIdentifier for the cell
   - parameter indexPath:       The indexPath where this cell will be presented
   - parameter registerCell:    If true, calls dataView.registerClass... for you
   - parameter configuration:   A closure that allows the caller to configure the cell
   
   - returns: A new cell provider
   */
  public init<C: DataCell, V: DataView>(dataView: V, reuseIdentifier: String, indexPath: NSIndexPath, registerCell: Bool, @noescape configure: (C) -> Void) {
    if registerCell {
      dataView.registerClass(C.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    guard let cell = dataView.dequeueCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? C else {
      fatalError("Invalid cell type returned!")
    }
    
    configure(cell)
    self.cell = cell
  }
  
}

/**
 *  Represents a general 'cell' type to provide conformance for UITableViewCell and UICollectionViewCell
 */
public protocol DataCell: AnyObject {
  static var reuseIdentifier: String { get }
  var reuseIdentifier: String? { get }
  static func classForCoder() -> AnyClass
}

extension DataCell {
  
  /// By default, this simply returns the class name e.g. "PersonCell"
  public static var reuseIdentifier: String {
    return NSStringFromClass(self).componentsSeparatedByString(".").last!
  }
}

/**
 *  Represents a general 'view' type to provide conformance for UITableView and UICollectionView. Includes register and dequeue calls so that we can handle both types, or even your own DataView types
 */
public protocol DataView {
  func registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String)
  func dequeueCellWithReuseIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> DataCell
}

// Auto opt-in to the appropriate protocols for convenience

extension UITableViewCell: DataCell { }
extension UICollectionViewCell: DataCell { }

extension UICollectionView: DataView {
  public func dequeueCellWithReuseIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> DataCell {
    return dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
  }
}

extension UITableView: DataView {
  public func registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
    registerClass(cellClass, forCellReuseIdentifier: identifier)
  }
  
  public func dequeueCellWithReuseIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> DataCell {
    return dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
  }
}

