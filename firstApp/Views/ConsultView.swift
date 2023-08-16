//
//  ConsultView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/8/16.
//


import SwiftUI
import Refresh

struct ConsultView: View {
    @StateObject private var viewModel = RequestMapper()
    @State var newsListArray: [NewsList.NewListItem] = []
    @State var headerRefreshing: Bool = false
    @State var footerRefreshing: Bool = false
    @State private var progress: CGFloat = 0.0
    @State var offsetX: Double = 0.0
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
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
                ForEach(self.newsListArray, id: \.self.id) { Element in
                    artCard(newsItem: (
                        picPath: Element.cover,
                        title: Element.title,
                        vicTitle: Element.content,
                        date: Element.relativeTime,
                        type: ""
                    ))
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
        .frame(width: screenWidth)
        .onAppear {
            viewModel.getConsultList(id: "") { newsArray in
                self.newsListArray = newsArray
            }
        }
    }
}

// 扩展结构 将方法写次处
extension ConsultView {
    // 下拉刷新
    func headerAction() {
        viewModel.getConsultList(id: "") { newsArray in
            self.headerRefreshing = false
            self.newsListArray = newsArray
        }
    }

    // 上拉刷新
    func footerAction() {
        footerRefreshing = true
        var tempNewsArray = newsListArray
        if let lastNews = viewModel.consultList?.last {
            viewModel.getConsultList(id: String(lastNews.id)) { newsArray in
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

struct ConsultView_Previews: PreviewProvider {
    static var previews: some View {
        ConsultView()
    }
}
