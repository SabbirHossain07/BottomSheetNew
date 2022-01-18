//
//  Home.swift
//  BottomSheetNew
//
//  Created by Sopnil Sohan on 18/1/22.
//

import SwiftUI

struct Home: View {
    
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                
                let frame = proxy.frame(in: .global)
                
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
            }
            .blur(radius: getBlurRadius())
            .ignoresSafeArea()
            
            //Bottom Sheet...
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                
                return AnyView(
                    
                    ZStack {
                        BlurView(style: .systemThinMaterialDark)
                            .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 30))
                        
                        VStack {
                            Capsule()
                                .fill(Color.white)
                                .frame(width: 60, height: 4)
                                .padding(.top)
                            
                            //ScrollView Content Here....
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                        .offset(y: height - 140)
                        .offset(y: -offset > 0 ? -offset <= (height - 140) ? offset : -(height - 140) : 0)
                        .gesture(DragGesture().updating($gestureOffset, body: {value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            
                            let maxHeight = height - 140
                            
                            withAnimation {
                                //Logic Condition For Moving States...
                                //Up down or mid...
                                if -offset > 140 && -offset < maxHeight / 2 {
                                    //Mid..
                                    offset = -(maxHeight / 3)
                                }
                                else if -offset > maxHeight / 2 {
                                    offset = -maxHeight
                                }
                                else {
                                    offset = 0
                                }
                            }
                            // Storing Last Offset...
                            // So that the gesture can continue from the last position...
                            lastOffset = offset
                            
                        }))
                )
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    func getBlurRadius()->CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 140)
        
        return progress * 30
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
