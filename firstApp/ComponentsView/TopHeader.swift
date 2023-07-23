//
//  TopHeader.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/23.
//

import SwiftUI

struct TopHeader: View {
    @State var activeTabIndex:Int
    let tabListData:Array<String> = ["全部","直播","咨询","每日一言"]
    
    init(activeTabIndex: Int = 0) {
        self.activeTabIndex = activeTabIndex
    }
    
    var body: some View {
            VStack{
                Text("鲸闻")
                    .foregroundColor(HexColor(rgbValue: 0x213856))
                    .font(Font.system(size:16))
                    .fontWeight(Font.Weight.medium)
                HStack(alignment: .center,spacing: 16){
                    ForEach(self.tabListData,id: \.self){ tabItem in
                        var isActive = tabListData[activeTabIndex] == tabItem
                        Text(tabItem)
                            .foregroundColor(HexColor(rgbValue: isActive ? 0x112a4a:0xc0c8d4))
                            .fontWeight(isActive ? Font.Weight.bold : Font.Weight.medium)
                            .onTapGesture {
                                self.activeTabIndex = tabListData.firstIndex(of: tabItem) ?? 0
                            }
                    }
                    .font(Font.system(size:18))
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(EdgeInsets(top:10, leading: 12, bottom: 0, trailing:0))
            }
        }
}

struct TopHeader_Previews: PreviewProvider {
    static var previews: some View {
        TopHeader()
    }
}
