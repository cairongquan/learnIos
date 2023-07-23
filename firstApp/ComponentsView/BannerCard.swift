//
//  BannerCard.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/19.
//

import SwiftUI

typealias BannerCardParams = (backgroundImage:String,date:Int,content:String,from:String)

struct bannerCard: View {
    var bannerData:BannerCardParams
    var timerInfo:(month:String,day:String,year:String)
    
    init(bannerData:BannerCardParams){
        self.timerInfo = getTimeValue(time: Double(bannerData.date))
        self.bannerData = bannerData
    }
    
    var body: some View {
            HStack{
                VStack{
                    HStack{
                        Text(self.timerInfo.day)
                            .fontWeight(Font.Weight.medium)
                            .font(Font.system(size:32))
                            .foregroundColor(.white)
                        VStack(alignment: .leading){
                            Text(self.timerInfo.month)
                            Text(self.timerInfo.year)
                        }
                        .foregroundColor(.white.opacity(0.8))
                        .font(Font.system(size:14))
                        .fontWeight(Font.Weight.light)
                        Spacer()
                    }
                    Text(self.bannerData.content)
                        .foregroundColor(.white)
                        .font(Font.system(size:16))
                        .fontWeight(Font.Weight.semibold)
                        .padding(EdgeInsets(top: 18, leading: 0, bottom:20, trailing:26))
                    Text("—— \(self.bannerData.from)")
                        .foregroundColor(HexColor(rgbValue: 0xafb1b7))
                        .font(Font.system(size:14))
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom:0, trailing:14))
                }
            }
            .padding(EdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 0))
            .background(Group{
                AsyncImage(url: URL(string: self.bannerData.backgroundImage.replacingOccurrences(of: "http://", with:"https://"))){ phase in
                    if let image = phase.image{
                        image
                            .resizable()
                            .frame(width:.infinity,height:.infinity)
                            .clipped()
                    }
                    Color.black.opacity(0.5)
                }
            })
            .cornerRadius(10)
    }
}
