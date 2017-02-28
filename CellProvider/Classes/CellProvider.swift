//
//  CellProviding.swift
//  GenericCells
//
//  Created by Shaps Mohsenin on 06/08/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit

/**
 *  This is a simple wrapper around a cell to provide Generics and type safety. You should generally never need to retain this anywhere.
 */
public struct CellProvider<C: ReusableCell, V: ReusableCellHosting> {
    
    /// Use this property to get the dequeue cell
    public unowned let cell: C
    
    /**
     Initializes this provider with the specified configuration
     
     - parameter hostView:        The view that will host the cell
     - parameter indexPath:       The indexPath where this cell will be presented
     - parameter configuration:   A closure that allows the caller to configure the cell
     
     - returns: A new cell provider
     */
    public init(hostView: V, indexPath: IndexPath, configure: (C) -> Void) {
        let cell = hostView.dequeueReusableCell(ofType: C.self, for: indexPath)
        configure(cell)
        self.cell = cell
    }
    
    /**
     Initializes this provider with the specified configuration
     
     - parameter hostView:        The view that will host the cell
     - parameter reuseIdentifier: The reuseIdentifier for the cell
     - parameter indexPath:       The indexPath where this cell will be presented
     - parameter configuration:   A closure that allows the caller to configure the cell
     
     - returns: A new cell provider
     */
    public init(hostView: V, reuseIdentifier: String, indexPath: IndexPath, configure: (C) -> Void) {
        let cell = hostView.dequeueReusableCell(with: reuseIdentifier, for: indexPath) as C
        configure(cell)
        self.cell = cell
    }
    
}
