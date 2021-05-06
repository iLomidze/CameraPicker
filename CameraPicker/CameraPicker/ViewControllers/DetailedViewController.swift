//
//  DetailedViewController.swift
//  CameraPicker
//
//  Created by ilomidze on 03.05.21.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageData = imageData {
            let image = UIImage(data: imageData)
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "NoImageAvailable")
        }
    }


    @IBAction func sharePicButon(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: ["Check this Photo"], applicationActivities: [])
        // For iPads - to open from specific button
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

        present(vc, animated: true)
    }
}
