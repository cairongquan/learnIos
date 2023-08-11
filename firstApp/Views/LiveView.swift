//
//  LiveView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/8/10.
//

import SwiftUI
import Refresh

struct LiveView: View {
    @StateObject private var viewModel = RequestMapper()
    @State var liveList:Array<LiveList.LiveItemList> = []
    @State var headerRefreshing = false
    @State private var progress: CGFloat = 0.0
    
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView(showsIndicators: false){
            RefreshHeader(refreshing: $headerRefreshing, action: headerAction) { progress in
                if self.headerRefreshing {
                    // 下拉释放
                    Loading(tipText: "")
                } else {
                    // 下拉不释放
                    RefreshLoadView(progress: putProgressValue(progress: progress))
                }
            }
            ForEach(self.liveList,id: \.self.id){ Element in
                LiveCard(liveData: (backgroundImage:Element.cover,content:Element.title,endTime:Element.end_time))
            }
        }
        .enableRefresh()
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        .onAppear(){
            self.viewModel.getLiveListData(page: "1"){ liveList in
                self.liveList = liveList
            }
        }
    }
}

extension LiveView{
    // 下拉刷新
    func headerAction(){
        self.liveList = []
        viewModel.getLiveListData(page: ""){ liveData in
            self.liveList = liveData
            self.headerRefreshing = false
        }
    }
    // 类型转换 赋值
    func putProgressValue(progress: CGFloat) -> Binding<CGFloat> {
        self.progress = progress
        return $progress
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
