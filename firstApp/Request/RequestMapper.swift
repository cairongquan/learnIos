import Moya

struct NewsList: Decodable {
    var items: [NewListItem]

    struct NewListItem: Decodable {
        var id: Int
        var _id: String
        var content: String
        var cover: String
        var from: String
        var relativeTime: String
        var title: String
        var created_at: Int

        private enum CodingKeys: String, CodingKey {
            case _id
            case id
            case content
            case cover
            case from
            case relativeTime
            case title
            case created_at
        }
    }
}

public class RequestMapper: ObservableObject {
    @Published var newsList: [NewsList.NewListItem]?
    let requestIns = MoyaProvider<FirstAppApi>()

    // 请求新闻列表
    func getNewListData(id: String, _action: (([NewsList.NewListItem]) -> Void)? = nil) {
        self.requestIns.request(.getNewsList(id: id)) { result in
            switch result {
                case .success(let response):
                    do {
                        if let utf8Data = String(data: response.data, encoding: .utf8)?.data(using: .utf8) {
                            let resolveData = try JSONDecoder().decode(NewsList.self, from: utf8Data)
                            self.newsList = resolveData.items
                            _action?(self.newsList ?? [])
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
