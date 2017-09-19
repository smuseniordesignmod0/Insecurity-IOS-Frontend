//
//  TextLabelColor.swift
//  Insecurity
//
//  Created by Gabriel I Leyva Merino on 9/19/17.
//  Copyright © 2017 Insecurity. All rights reserved.
//

import Foundation
import UIKit

func addMultipleColorsTo(text: String?, location: Int, length:Int) -> NSMutableAttributedString {
  
    var myMutableString:NSMutableAttributedString!
    
    if text != nil {
         myMutableString = NSMutableAttributedString(string: text!, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 17.0)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange(location: location, length: length))
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica", size: 17.0)!, range: NSRange(location: location, length: length))
    } else {
         myMutableString = NSMutableAttributedString(string: "", attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 17.0)!])
    }
    
    print(myMutableString)

    return myMutableString
}
