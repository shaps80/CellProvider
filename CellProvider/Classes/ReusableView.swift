//
//  ReusableView.swift
//  Pods
//
//  Created by Shahpour Benkau on 27/02/2017.
//
//

import UIKit

/**
 *  Represents a general 'cell' type to provide conformance for UITableViewCell and UICollectionViewCell
 */
public protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableCell { }
extension UICollectionViewCell: ReusableCell { }

/**
 *  Represents a general 'view' type to provide conformance for UITableView and UICollectionView. Includes register and dequeue calls so that we can handle both types, or even your own DataView types
 */
public protocol ReusableCellHosting {
    func register<C: ReusableCell>(cellClass: C.Type)
    func dequeueReusableCell<C: ReusableCell>(ofType cellClass: C.Type, for indexPath: IndexPath) -> C
}

extension UITableView: ReusableCellHosting {
    
    public func register<C: ReusableCell>(cellClass: C.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    public func dequeueReusableCell<C: ReusableCell>(ofType cellClass: C.Type, for indexPath: IndexPath) -> C {
        return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as! C
    }
    
}

extension UICollectionView {
    
    public func register<C: ReusableCell>(cellClass: C.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    public func dequeueReusableCell<C: ReusableCell>(ofType cellClass: C.Type, for indexPath: IndexPath) -> C {
        return dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as! C
    }
    
}
