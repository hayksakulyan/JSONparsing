//
//  URLImage.swift
//  JsonParsing
//
//  Created by Hayk Sakulyan on 01.10.23.
//

import SwiftUI
import Foundation

struct URLImage: View {
    
    let urlString: String
    
    @State var data : Data?
    
    var body: some View {
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        }
        else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
        
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) {data, _, _ in
            self.data = data
        }
        task.resume()
    }
    
}

//struct URLImage_Previews: PreviewProvider {
//    @StateObject var viewModel = ViewModel()
//    func test() -> [String] {
//        var url: [String]
//        ForEach(viewModel.corses, id: \.self) { course in
//            url.append(course.image)
//        }
//        return url
//    }
//
//    static var previews: some View {
//        URLImage(urlString: "")
//    }
//}
