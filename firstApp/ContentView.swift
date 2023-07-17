//
//  ContentView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/17.
//

import SwiftUI

let request = RequestMapper()

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(){
            request.getNewListData(id: "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
