//
//  Onboard.swift
//  LeftIt
//
//  Created by Emanuele Di Pietro on 20/03/24.
//

import SwiftUI

struct Onboarding: View {
    
    @AppStorage ("isOnboarding") var isOnboarding: Bool?
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            Image("leftit")
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(15.0)
            Spacer()
            Spacer()
            Spacer()
            Text("Welcome to LeftIt").font(.title).fontWeight(.bold).foregroundStyle(.white)
            Text("Don't say you Left It somewhere anymore").foregroundStyle(.white).opacity(0.8)
            Spacer()
            Spacer()
            Spacer()
            
            Button{
                   
                    isOnboarding = false
                    dismiss()
                
            } label: {
                Text("Continue").fontDesign(.rounded)
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.primaryViolet, .secondaryViolet]), startPoint: .top, endPoint: .bottom))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            Spacer()
        }.fontDesign(.rounded).background(LinearGradient(gradient: Gradient(colors: [.primaryViolet, .secondaryViolet]), startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    Onboarding()
}
