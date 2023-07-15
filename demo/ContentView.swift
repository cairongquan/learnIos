//
//  ContentView.swift
//  cairongquan
//
//  Created by Macintosh HD on 2023/7/15.
//

import SwiftUI

struct NewsObject:Decodable {
    let data:Array<NewItem>
    struct NewItem:Decodable {
        let title : String;
        let date : String;
        let thumbnail_pic_s : String;
    }
}

struct ContentView: View {
    @State private var newsData: Data?
    @State private var newsArray:Array<NewsObject.NewItem>?
    

    func getNewsData(){
        let requireNewsUrl:URL = URL(string: "http://192.168.31.127:3000/news")!
        let session = URLSession.shared
        let request = URLRequest(url: requireNewsUrl)
        
        let task = session.dataTask(with: request as URLRequest){(data,response,error) in
            if data != nil {
                newsData = data
            }
        }
        task.resume()
    }
    
    var body: some View {
        List(){
            if let newsArray = self.newsArray {
                ForEach(newsArray, id: \.title) { newsItem in
                    HStack {
                        AsyncImage(url: URL(string: newsItem.thumbnail_pic_s),scale: 4)
                            .frame(width: 60,height:20)
                        VStack{
                            Text(newsItem.title)
                                .font(.system(size: 14))
                                .padding(EdgeInsets(top: 0, leading:18, bottom:0, trailing:0))
                                .lineLimit(1)
                            Text(newsItem.date)
                                .foregroundColor(.gray)
                                .font(.system(size:12))
                                .padding(EdgeInsets(top: 2, leading:0, bottom:0, trailing:0))
                        }
                    }.padding(10)
                }
            }
            else{
                Text("网络请求错误")
            }
        }
        .onAppear {
            getNewsData()
        }
        .onChange(of:newsData){ newData in
            if let news = try? JSONDecoder().decode(NewsObject.self, from: newData ?? Data()) {
                DispatchQueue.main.async{
                    newsArray = news.data
                }
            }
            else {
                print("JSON Parse Error!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
