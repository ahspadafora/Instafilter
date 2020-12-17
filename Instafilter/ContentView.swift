//
//  ContentView.swift
//  Instafilter
//
//  Created by Amber Spadafora on 12/17/20.
//  Copyright © 2020 Amber Spadafora. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle().fill(Color.secondary)
                    // display the image
                    
                    if image != nil {
                        image?
                        .resizable()
                        .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    }
                }.onTapGesture {
                    // select an image
                }
                HStack {
                    Text("Intensity")
                    Slider(value: self.$filterIntensity)
                }.padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        // change filter
                    }
                    Spacer()
                    Button("Save") {
                        // save the picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
