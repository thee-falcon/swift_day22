//
//  DetailViewController.swift
//  project1
//
//  Created by Omar Makran on 4/3/2024.
//

import UIKit

class DetailViewController: UIViewController {
    // @IBOutlet: This attribute is used to tell Xcode that there's a connection between this line of code and Interface Builder.
    // imageView: This was the property name assigned to the UIImageView.
    // UIImageView: is responsible for viewing images – perfect!
    //  !: This means that that UIImageView may be there or it may not be there.
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
        title = "Picture \(selectedPictureNumber + 1) of \(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never
        
        // The .action system item displays an arrow coming out of a box.
        // The action parameter is saying "when you're tapped, call the shareTapped() method,"
        // and the target parameter tells the button that the method belongs to the current view controller – self.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    // both methods, This means "tell my parent data type that these methods were called."
    // it means that it passes the method on to UIViewController, which may do its own processing.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    /*
     marked with @objc because this method will get called by the underlying Objective-C operating system (the UIBarButtonItem) so we need
     to mark it as being available to Objective-C code.
     When you call a method using #selector you’ll always need to use @objc too.
     */
    @objc func  shareTapped() {
        // 1.0 (maximum quality) and 0.0 (minimum quality_.
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else
        {
            print("No Image found")
            return
        }
        // UIActivityViewController will automatically give us functionality to share by iMessage, by email and by Twitter and Facebook...
        // We're passing an empty array into the second parameter, because our app doesn't have any services to offer.
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
