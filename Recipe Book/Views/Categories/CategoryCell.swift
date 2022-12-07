//
//  Test.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//
import SwiftUI
import CachedAsyncImage
struct CategoryCell: View {
    let imageURL: String
    let name: String
    let sizing: CGFloat
    let screenSize = UIScreen.main.bounds.size

    
    var body: some View {
            VStack(alignment: .center) {
                CachedAsyncImage(url: URL(string: imageURL), transaction: .init(animation: .spring(response: 1.6))) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width: sizing, height: sizing)
                                        
                                case .failure:
                                    Text("Failed fetching image. Make sure to check your data connection and try again.")
                                        .foregroundColor(.red)
                                @unknown default:
                                    Text("Unknown error. Please try again.")
                                        .foregroundColor(.red)
                                }
                            }
                            //.resizable()
                            .frame(width: sizing, height: sizing)
                            .cornerRadius(5)
                            .padding(.top, 5)
                
                Text(name).font(.system(size: 14, weight: .bold, design: .rounded))
                                
                                .foregroundColor(.white)
                
            }
            .frame(width: 180, height: 180)
            .background(Color(hex: 0x22282C))
            .cornerRadius(10)
            
        
    }
}




