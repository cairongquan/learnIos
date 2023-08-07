//
//  headerView.swift
//  demo
//
//  Created by Macintosh HD on 2023/7/16.
//

import SwiftUI

struct artCard: View {
    typealias newsItem = (picPath: String, title: String, vicTitle: String, date: String, type: String)

    var newsItem: newsItem

    init(newsItem: newsItem) {
        self.newsItem = newsItem
    }

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: self.newsItem.picPath.replacingOccurrences(of: "http://", with: "https://"))) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 102, height: 102)
                            .cornerRadius(6)
                            .clipped()
                    }
                }
                VStack(alignment: .leading, spacing: 14) {
                    Text(self.newsItem.title)
                        .lineLimit(2)
                        .bold()
                        .font(Font.system(size: 16))
                    Text(self.newsItem.vicTitle)
                        .font(Font.system(size: 12))
                        .lineLimit(2)
                        .foregroundColor(HexColor(rgbValue: 0x666666))
                }.frame(width: UIScreen.main.bounds.width - 154)
            }
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
            HStack(spacing: 2.0) {
                HStack(spacing: 16) {
                    Image(systemName: "star")
                        .foregroundColor(HexColor(rgbValue: 0x8c9cb1))
                        .font(Font.system(size: 16))
                        .bold()
                    Image(systemName: "message")
                        .foregroundColor(HexColor(rgbValue: 0x8c9cb1))
                        .font(Font.system(size: 16))
                        .bold()
                }
                Spacer()
                Text("\(self.newsItem.date)·咨询")
                    .font(Font.system(size: 14))
                    .foregroundColor(HexColor(rgbValue: 0x666666))
                    .fontWeight(.thin)
            }
            .padding(EdgeInsets(top: 16, leading: 12, bottom: 12, trailing: 12))
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(.white)
        .cornerRadius(10)
    }
}
