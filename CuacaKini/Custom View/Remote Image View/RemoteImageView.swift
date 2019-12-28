//
//  ImageView.swift
//  CuacaKini
//
//  Created by Arie Ridwan on 27/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import Combine
import SwiftUI

struct RemoteImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(withURL: "")
    }
}
