//
//  ContentView.swift
//  Instafilter
//
//  Created by Amber Spadafora on 12/17/20.
//  Copyright © 2020 Amber Spadafora. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

/*
 integrating coreImage with SwiftuI
 
 1. create an optional image with a @State wrapper
 2. force the image to be the same width as the screen (.resizable() & .scaledToFit())
 3. add an onAppear() modifier to load the actual image
 */

struct ContentView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        /*
         load example image into a UIImage with UIImage(named:) initializer, which will return an optional
         then convert that into a CIImage which is what Core Image works with
         */
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        // set the filters inputImage and intensity
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        // get a CIImage from our filter
        guard let outputImage: CIImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our context, using our outputImage
        if let cgimg: CGImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
        
        /*
         Easiest way to convert the filter's outputed image to a SwiftUI Image we can display is
         1. Read the output image from our filter (which will be an optional CIImage)
         2. Ask our context to create a CGImage from that output image(CIImage), this will give us an optional
         3. Convert that optional CGImage into a UIImage
         4. Finally, convert that UIImage into a SwiftUI Image
         */
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
