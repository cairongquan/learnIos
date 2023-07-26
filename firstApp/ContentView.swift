//
//  ContentView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/17.
//

import SwiftUI
import Refresh

struct ContentView: View {
    @StateObject private var viewModel = RequestMapper()
    @State var headerRefreshing: Bool = false
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack{
            VStack{
                TopHeader()
                if let newsArray = viewModel.newsList {
                        ScrollView {
                            RefreshHeader(refreshing: $headerRefreshing, action:headerAction ) { progress in
                                   if self.headerRefreshing {
                                       // 下拉释放
                                       Loading(tipText: "")
                                   } else {
                                    // 下拉不释放
                                    RefreshLoadView(progress: putProgressValue(progress:progress))
                                }
                            }
                            VStack(spacing:12) {
                                    ForEach(newsArray,id: \.self.id) { Element in
                                        Group{
                                            if Element.title != "" {
                                                artCard(newsItem: (
                                                    picPath:Element.cover,
                                                    title:Element.title,
                                                    vicTitle:Element.content,
                                                    date:Element.relativeTime,
                                                    type:""
                                                ))
                                            }
                                            else{
                                                bannerCard(bannerData:(
                                                    backgroundImage:Element.cover,
                                                    date:Element.created_at,
                                                    content:Element.content,
                                                    from:Element.from
                                                ))
                                            }
                                        }
                                    }
                            }
                        }
                        .enableRefresh()
                        .padding(12)
                }else{
                    VStack{
                        Loading(tipText:"加载数据中...")
                    }
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .onAppear{
            viewModel.getNewListData(id: "")
        }
        .frame(width: .infinity,height: .infinity)
        .background(HexColor(rgbValue: 0xf4f4f4))
        .edgesIgnoringSafeArea(.bottom)
    }
}

// 扩展结构 将方法写入次处
extension ContentView {
    // 下拉刷新
    func headerAction(){
        viewModel.getNewListData(id: ""){
            self.headerRefreshing = false
        }
    }
    
    // 类型转换 赋值
    func putProgressValue(progress:CGFloat) -> Binding<CGFloat>{
        self.progress = progress
        return self.$progress
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
                ContentView()
    }
}
