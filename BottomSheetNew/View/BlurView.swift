//
//  BlurView.swift
//  BottomSheetNew
//
//  Created by Sopnil Sohan on 18/1/22.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        //de nothing
    }
}


