//
//  ContentView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/17.
//

import Refresh
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RequestMapper()
    @State var newsListArray: [NewsList.NewListItem] = []
    @State var headerRefreshing: Bool = false
    @State var footerRefreshing: Bool = false
    @State private var progress: CGFloat = 0.0

    var body: some View {
        VStack {
            VStack {
                TopHeader()
                if !self.newsListArray.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                        RefreshHeader(refreshing: $headerRefreshing, action: headerAction) { progress in
                            if self.headerRefreshing {
                                // 下拉释放
                                Loading(tipText: "")
                            } else {
                                // 下拉不释放
                                RefreshLoadView(progress: putProgressValue(progress: progress))
                            }
                        }
                        VStack(alignment: .center, spacing: 12) {
                            ForEach(self.newsListArray, id: \.self._id) { Element in
                                Group {
                                    if Element.title != "" {
                                        artCard(newsItem: (
                                            picPath: Element.cover,
                                            title: Element.title,
                                            vicTitle: Element.content,
                                            date: Element.relativeTime,
                                            type: ""
                                        ))
                                    } else {
                                        bannerCard(bannerData: (
                                            backgroundImage: Element.cover,
                                            date: Element.created_at,
                                            content: Element.content,
                                            from: Element.from
                                        ))
                                    }
                                }
                            }
                        }
                        RefreshFooter(refreshing: $footerRefreshing, action: footerAction) {
                            if self.footerRefreshing {
                                Loading(tipText: "加载中")
                            }
                        }
                    }
                    .enableRefresh()
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
//                    .frame(maxWidth:UIScreen.main.bounds.width + 20)
                } else {
                    VStack {
                        Loading(tipText: "加载数据中...")
                    }
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .onAppear {
            viewModel.getNewListData(id: "") { newsArray in
                self.newsListArray = newsArray
            }
        }
        .background(HexColor(rgbValue: 0xf4f4f4))
        .edgesIgnoringSafeArea(.bottom)
    }
}

// 扩展结构 将方法写次处
extension ContentView {
    // 下拉刷新
    func headerAction() {
        viewModel.getNewListData(id: "") { newsArray in
            self.headerRefreshing = false
            self.newsListArray = newsArray
        }
    }

    // 上拉刷新
    func footerAction() {
        footerRefreshing = true
        var tempNewsArray = newsListArray
        if let lastNews = viewModel.newsList?.last {
            viewModel.getNewListData(id: String(lastNews._id)) { newsArray in
                if !newsArray.isEmpty {
                    newsArray.forEach { item in
                        tempNewsArray.append(item)
                    }
                }
                self.newsListArray = tempNewsArray
                footerRefreshing = false
            }
        }
    }

    // 类型转换 赋值
    func putProgressValue(progress: CGFloat) -> Binding<CGFloat> {
        self.progress = progress
        return $progress
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
