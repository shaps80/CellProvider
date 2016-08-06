<img src="Cells.png" width=375 />

# Generic Cell Providers

Swift is great, but sometimes working with UIKit can be less safe than hanging off the edge of a cliff without a net.

My cell provider implementation ticks off the following:

* Type-safe cell providers
* Multiple cell types 
* Composited approach (the cell code doesn't have to exist inside your VC)

I actually wrote this code a long time ago for another library of mine, [Populate](http://github.com/shaps80/Populate). 

Populate also includes a more consistent API for dealing with data in your table/collection views. Including type-safety, NSFetchedResultsController-like bindings via a simple Swift array, value-types support, sectioning, sorting, and more.

## Example

```swift
final class ViewController: UITableViewController, DataCellProviding {
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // Note: this is the ONLY time we have to implicitly unwrap
    return cellProvider(forRowAt: indexPath, in: tableView).cell as! UITableViewCell
  }
  
  func cellProvider<D : DataView>(forRowAt indexPath: NSIndexPath, in dataView: D) -> DataCellProvider {
    let person = people[indexPath.item]
    
    if person.role == "Engineer" {
      return DataCellProvider(dataView: dataView, reuseIdentifier: PersonCell.reuseIdentifier, indexPath: indexPath, registerCell: true) {
        (cell: PersonCell) in // This is where type inference does its job
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.role
      }
    } else {
      // Here, we use the cell registered in the storyboard
      return DataCellProvider(dataView: dataView, reuseIdentifier: "SubtitleCell", indexPath: indexPath, registerCell: false) {
        (cell: UITableViewCell) in
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.role
      }
    }
  }
  
}
```

## Implementation

The key to implementing multiple type-safe cell handling, is the `DataCellProvider`. This is a simple value-type that you instantiate with generics, fetch the cell and then trash. We don't need to keep it around, since its simply providing a nice wrapper around the cell construction and configuration.

A class or struct can conform to `CellProviding`, which means this doesn't have to exist in your `UITableViewController`. In some of my projects, I've actually had a single file in my project that provides all the cells throughout my app. Your approach may differ but the composited, protocol-oriented approach I've chosen is quite flexible.

As you can see from the example above, your `cellForRowAtIndexPath...`

## Installation

This repo includes a simple sample project for your convenience, however in order to use the code, you simply need to copy `CellProvider.swift` into your project. 

Alternatively you can grab the code from GIST, [CellProvider.swift](https://gist.github.com/shaps80/eaa12e5fcddab90a4c6b2fbf321c96e6)

## Platforms and Versions

The following platforms and version have been tested:

* iOS 8.0 and greater
* Swift 2.2

## Author

[@shaps](http://twitter.com/shaps)

## License

All code is available under the MIT license. 
