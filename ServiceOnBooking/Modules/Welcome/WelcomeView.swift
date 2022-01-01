//
//  WelcomeView.swift
//  ServiceOnBooking
//
//  Created by Максим Чесников on 25.12.2021.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var unitPoint = UnitPoint.center
    @State var angle = Angle.zero
    @State var scale: CGFloat = 1
    
    var body: some View {
        ZStack {
                 Text("Booking of service")
                .scaleEffect(scale)
        }
        .onAppear(perform: {
            withAnimation(Animation.spring(response: 2.6, dampingFraction: 0.8).repeatForever(autoreverses: true)) {
                scale = 2
            }
        })
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
