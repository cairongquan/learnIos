//
//  headerView.swift
//  demo
//
//  Created by Macintosh HD on 2023/7/16.
//

import SwiftUI

func HexColor(rgbValue: UInt) -> Color {
   return Color (
       red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
       blue: CGFloat(rgbValue & 0x0000FF) / 255.0
   )
}

struct artCard: View {
    var body: some View {
        ZStack{
            VStack{
                HStack(spacing:14) {
                    Image(uiImage: UIImage(named: "wallhaven-4gj9d7.jpg")!)
                        .resizable()
                        .frame(width: 110,height:110)
                        .scaledToFill()
                        .cornerRadius(12)
                    VStack(spacing:14) {
                        Text("2023开学季，好物实用至上：有哪些适合准大学新生的数码好物")
                            .lineLimit(2)
                            .bold()
                            .font(Font.system(size:16))
                        Text("今早，吉利银河新能源发布旗下新车银河 L6 的预告视频")
                            .font(Font.system(size:12))
                            .lineLimit(2)
                            .foregroundColor(HexColor(rgbValue: 0x666666))
                    }
                }
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
                HStack {
                    HStack(spacing:16){
                        Image(systemName: "star")
                            .foregroundColor(HexColor(rgbValue: 0x8c9cb1))
                            .font(Font.system(size:16))
                            .bold()
                        Image(systemName: "message")
                            .foregroundColor(HexColor(rgbValue: 0x8c9cb1))
                            .font(Font.system(size:16))
                            .bold()
                    }
                    Spacer()
                    Text("2天前·咨询")
                        .font(Font.system(size:14))
                        .foregroundColor(HexColor(rgbValue: 0x666666))
                        .fontWeight(.thin)
                }
                .padding(EdgeInsets(top: 14, leading: 12, bottom: 12, trailing: 12))
            }
            .background(Color.white)
            .cornerRadius(6)
            .padding(12)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(HexColor(rgbValue: 0xf2f2f2))
    }
}


struct headerView_Previews: PreviewProvider {
    static var previews: some View {
        artCard()
    }
}
