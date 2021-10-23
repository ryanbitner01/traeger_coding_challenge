//
//  ContentView.swift
//  traeger_coding_challenge
//
//  Created by Ryan Bitner on 10/22/21.
//

import SwiftUI

struct DetailView: View {
    
    let apod: apod
    let networkController = NetworkController()
    
    @State var image: UIImage? = nil
    let systemImage = UIImage(systemName: "photo.on.rectangle")!
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .center, spacing: 5) {
                        Image(uiImage: image ?? systemImage)
                            .resizable()
                            .cornerRadius(5)
                            .frame(width: geometry.size.width * 0.75, height: geometry.size.width * 0.75, alignment: .center)
                        Text(apod.date)
                        .padding()
                        .font(.headline)
                        Text(apod.explanation)
                        .padding()
                }
            }
        }
        .onAppear(perform: getAPOD)
    }
    
    func getAPOD() {
        networkController.getAPOD(apod: apod) { result in
            switch result {
            case .success(let image):
                self.image = image
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var apodService = APODService()
    
    var body: some View {
        NavigationView {
            List(apodService.apods, id: \.date) { apod in
                NavigationLink(destination: DetailView(apod: apod)) {
                    Text("\(apod.date)")
                }
            }
            .navigationTitle("APOD List")
        }
        .onAppear(perform: apodService.getAPODS)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
