//
//  BannerCard.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/19.
//

import SwiftUI

typealias LiveCardParams = (backgroundImage: String, content: String,endTime:Int)

struct LiveCard: View {
    var liveData: LiveCardParams
    var timeInfo: (month:String,day:String,year:String)
    
    init(liveData: LiveCardParams) {
        self.timeInfo = getTimeValue(time: Double(liveData.endTime))
        self.liveData = liveData
    }

    var body: some View {
        HStack {
            VStack {
                HStack {
                   
                }
                Text(self.liveData.content)
                    .foregroundColor(.white)
                    .font(Font.system(size: 16))
                    .fontWeight(Font.Weight.semibold)
                    .padding(EdgeInsets(top: 18, leading: 0, bottom: 20, trailing: 26))
            }
        }
        .frame(height: 220)
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

