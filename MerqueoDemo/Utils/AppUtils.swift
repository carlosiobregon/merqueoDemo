//
//  AppUtils.swift
//  VIPER-demo
//
//  Created by Bipin on 7/3/18.
//  Copyright © 2018 Tootle. All rights reserved.
//

import Foundation
import UIKit

class ImagesCache{

    static let shared = ImagesCache()
    let cache = NSCache<NSString, UIImage>()
    
    func set(id: NSString?, image: UIImage){
        guard let it = id else { return }
        self.cache.setObject(image, forKey: it)
    }
    
    func get(id: NSString?) -> UIImage? {
        guard let it = id else { return nil }
        return self.cache.object(forKey: it)
    }
    
}

/* Show Progress Indicator */
func showProgressIndicator(view:UIView){
    
    view.isUserInteractionEnabled = false
    
    // Create and add the view to the screen.
    let progressIndicator = ProgressIndicator(text: "Please wait..")
    progressIndicator.tag = Constants.PROGRESS_INDICATOR_VIEW_TAG
    view.addSubview(progressIndicator)
    
}

/* Hide progress Indicator */
func hideProgressIndicator(view:UIView){
    
    view.isUserInteractionEnabled = true
    
    if let viewWithTag = view.viewWithTag(Constants.PROGRESS_INDICATOR_VIEW_TAG) {
        viewWithTag.removeFromSuperview()
    }
    
}
