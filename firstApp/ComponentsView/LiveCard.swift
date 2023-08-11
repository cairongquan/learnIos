//
//  BannerCard.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/19.
//

import SwiftUI

typealias LiveCardParams = (backgroundImage: String, content: String, endTime: Int)

struct LiveCard: View {
    var liveData: LiveCardParams
    var timeInfo: (month: String, day: String, year: String)

    var isLive: Bool = false

    init(liveData: LiveCardParams) {
        self.isLive = liveData.endTime > Int(Date().timeIntervalSince1970)
        self.timeInfo = getTimeValue(time: Double(liveData.endTime), notMMM: true)
        self.liveData = liveData
    }

    var body: some View {
        HStack {
            VStack {
                HStack {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.red)
                        .shadow(color:HexColor(rgbValue: 0xeb4e3d), radius: 10 )
                    Text(self.isLive ? "直播中" : "直播结束")
                        .foregroundColor(.white)
                    Spacer()
                }
                VStack {
                    Text(self.liveData.content)
                        .foregroundColor(.white)
                        .font(Font.system(size: 18))
                        .fontWeight(Font.Weight.semibold)
                        .padding(EdgeInsets(top: 38, leading: 0, bottom: 2, trailing: 26))
                    Text("于\(self.timeInfo.month)月\(self.timeInfo.day)日结束")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                }
                Spacer()
            }
        }
        .frame(height: 180)
        .padding(EdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 0))
        .background(Group {
            AsyncImage(url: URL(string: self.liveData.backgroundImage.replacingOccurrences(of: "http://", with: "https://"))) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: .infinity, height: .infinity)
                        .clipped()
                }
                Color.black.opacity(0.5)
            }
        })
        .cornerRadius(10)
    }
}
