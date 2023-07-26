//
//  RefreshLoadView.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/25.
//

import SwiftUI

struct RefreshLoadView: View {
    @Binding var progress: CGFloat // 使用 @Binding 属性接收父视图传递的 progress

    init(progress: Binding<CGFloat>) {
        self._progress = progress
    }
    
    var body: some View {
        VStack{
            Image(systemName: "arrow.up")
                .fontWeight(Font.Weight.regular)
                .font(.system(size: 32))
                .foregroundColor(HexColor(rgbValue:0x112a4a ))
                .rotationEffect(.degrees(self.progress > 0.5 ? 0 : 180)) // 旋转 180 度
                .animation(.easeInOut(duration: 0.5),value:self.progress > 0.5) // 添加动画效果
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
}
