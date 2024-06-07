//
//  FrameModifier.swift
//  CatApp
//
//  Created by Fatima Kahbi on 6/7/24.
//

import Foundation
import SwiftUI


struct FrameModifier: ViewModifier {
    let width: CGFloat?
    let height: CGFloat?
    
    func body(content: Content) -> some View {
        if let width, let height {
            if width == .infinity || height == .infinity {
                content.frame(maxWidth: width, maxHeight: height)
            } else {
                content.frame(width: width, height: height)
            }
        } else if let width {
            if width == .infinity{
                content.frame(maxWidth: width)
            } else {
                content.frame(width: width)
            }
        } else if let height {
            if height == .infinity {
                content.frame(maxHeight: height)
            } else {
                content.frame(height: height)
            }
        } else {
            content
        }
    }
}
