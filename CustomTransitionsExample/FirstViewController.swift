//
//  FristViewController.swift
//  CustomTransitionsExample
//
//  Created by Yee Peng Chia on 12/28/14.
//  Copyright (c) 2014 Keen Code Interactive. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var button: UIButton!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
//    @IBOutlet weak var titleSubtitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func titleViewAsImage() -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.titleView.bounds.size, view.opaque, 0.0)
//        self.titleView.layer.renderInContext(UIGraphicsGetCurrentContext())
//        let img = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return img;
//    }
}

