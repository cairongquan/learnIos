import Moya

struct NewsList: Decodable {
    var items: [NewListItem]

    struct NewListItem: Decodable {
        var id: Int
        var content: String
        var cover: String
        var from: String
        var relativeTime: String

        private enum CodingKeys: String, CodingKey {
            case id
            case content
            case cover
            case from
            case relativeTime
        }
    }
}

public struct RequestMapper{
    let requestIns = MoyaProvider<FirstAppApi>()
    
    // 请求新闻列表
    func getNewListData(id:String){
        requestIns.request(.getNewsList(id:id)){ result in
            switch result {
              case .success(let response):
                do {
                    if let utf8Data = String(data: response.data, encoding: .utf8)?.data(using: .utf8){
                        let resolveData = try JSONDecoder().decode(NewsList.self, from: utf8Data)
                            // 处理解析后的 JSON 数据
                            print(resolveData)
                        }
                    }
                catch {
                        // 处理解析错误
                        print("JSON 解析错误: \(error)")
                    }
              case .failure(let error):
                  // 处理请求失败的错误
                  print("请求失败: \(error)")
              }
        }
    }
}
