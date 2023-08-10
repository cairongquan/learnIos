//
//  LiveView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/8/10.
//

import SwiftUI

struct LiveView: View {
    @StateObject private var viewModel = RequestMapper()
    private let screenWidth = UIScreen.main.bounds.width
    @State var liveList:Array<LiveList.LiveItemList> = []
    
    var body: some View {
        ScrollView(showsIndicators: false){
            ForEach(self.liveList,id: \.self.id){ Element in
                LiveCard(liveData: (backgroundImage:Element.cover,content:Element.title))
            }
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        .frame(width:screenWidth)
        .onAppear(){
            self.viewModel.getLiveListData(page: "1"){ liveList in
                self.liveList = liveList
            }
        }
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
