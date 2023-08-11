//
//  LiveView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/8/10.
//

import SwiftUI
import Refresh

struct OneDayTalkView: View {
    @StateObject private var viewModel = RequestMapper()
    @State var talkList:Array<NewsList.NewListItem> = []
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
            ForEach(self.talkList,id: \.self.id){ Element in
                bannerCard(bannerData: (
                    backgroundImage: Element.cover,
                    date: Element.created_at,
                    content: Element.content,
                    from: Element.from
                ))
            }
        }
        .enableRefresh()
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        .onAppear(){
            self.viewModel.getOneDayTalkListData(id: ""){ talkList in
                self.talkList = talkList
            }
        }
    }
}

extension OneDayTalkView{
    // 下拉刷新
    func headerAction(){
        self.talkList = []
        viewModel.getOneDayTalkListData(id: ""){ talkList in
            self.talkList = talkList
            self.headerRefreshing = false
        }
    }
    // 类型转换 赋值
    func putProgressValue(progress: CGFloat) -> Binding<CGFloat> {
        self.progress = progress
        return $progress
    }
}

struct OneDayTalkView_Priview: PreviewProvider {
    static var previews: some View {
        OneDayTalkView()
    }
}
