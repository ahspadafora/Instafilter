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

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
