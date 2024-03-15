//
//  ViewController.swift
//  project1
//
//  Created by Omar Makran on 2/3/2024.
//

// which means “this file will reference the iOS user interface toolkit.”
import UIKit

// means I want to create a new screen of data called ViewController, based on UIViewController.
// UITableViewController adds the ability to show rows of data that can be scrolled and selected.
class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        // This super call means “tell Apple’s UIViewController to run its own code before I run mine.
        super.viewDidLoad()
        
        // title
        title = "Storm Viewer"
        // That enables large titles across our app.
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // This is a data type that lets us work with the filesystem,
        // and in our case we'll be using it to look for files.
        let fm = FileManager.default
        
        // Bundle is a directory containing our compiled program and all our assets.
        // This line says, "tell me where I can find all those images I added to my app."
        // Exclamation mark (!) is used for force unwrapping.
        let path = Bundle.main.resourcePath!
        
        // That is set to the contents of the directory at a path.
        // The items constant will be an array of strings containing filenames.
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this a picture to Load!
                pictures.append(item)
                pictures.sort()
            }
        }
        print(pictures)
    }
    // Showing lots of rows.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  pictures.count
    }
    // Dequeuing cells.
    // The method is called cellForRowAt, and will be called when you need to provide a row.
    // IndexPath this is a data type that contains both a section number and a row number.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // to display information, it gives the text label of the cell the same text as a picture in our array.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        // set the label text to be the name of the correct picture from our pictures array.
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    /*
     DetailViewController: that will hold the name of the image to load.
     IndexPath: that tells us what row we’re working with.
     didSelectRowAt: method so that it loads a DetailViewController from the storyboard.
     we’ll fill in viewDidLoad() inside DetailViewController so that it loads an image into its image view based on the name we set earlier.
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         When we created the detail view controller, you gave it the storyboard ID “Detail”,
         which allows us to load it from the storyboard using a method called instantiateViewController(withIdentifier:).
         instantiateViewController() has the return type UIViewController.
         */
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController.
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property.
            vc.selectedPictureNumber = indexPath.row
            vc.totalPictures = pictures.count
            vc.selectedImage = pictures[vc.selectedPictureNumber]
            // 3: now push it onto the navigation controller.
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
