import SwiftUI

let MonthDirectory:[Int:String] = [
    1:"JAN",
    2:"FEB",
    3:"MAR",
    4:"APR",
    5:"MAY",
    6:"JUN",
    7:"JUL",
    8:"AUG",
    9:"SEP",
    10:"OCT",
    11:"NOV",
    12:"DEC"
]

// 16进制转换rgb
func HexColor(rgbValue: UInt) -> Color {
   return Color (
       red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
       blue: CGFloat(rgbValue & 0x0000FF) / 255.0
   )
}

// 返回背景图卡片时间格式
func getTimeValue(time:Double) -> (month:String,day:String,year:String){
    let date = Date(timeIntervalSince1970: time)
    let timer = Calendar.current
    return (
        year:String(timer.component(.year, from: date)),
        day:String(timer.component(.day, from: date)),
        month:MonthDirectory[timer.component(.month, from: date)]!
    )
}
