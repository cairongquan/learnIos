//
//  Loading.swift
//  firstApp
//
//  Created by Macintosh HD on 2023/7/23.
//

import SwiftUI

struct Loading: View {
    var body: some View {
        ProgressView("加载中...")
            .progressViewStyle(CircularProgressViewStyle(tint: HexColor(rgbValue:0x213856)))
            .padding()
            .foregroundColor(HexColor(rgbValue: 0x213856))
            .font(Font.system(size:14))
    }
}
