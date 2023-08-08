import Moya

enum FirstAppApi {
    case getNewsList(id: String)
}

extension FirstAppApi: TargetType {
    // 定义请求路径
    var path: String {
        switch self {
        case .getNewsList:
            return "/news"
        }
    }
    
    // 请求方式
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getNewsList(let lastId):
            let params: [String: Any] = ["last_oid": lastId]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    // baseURL 接口前缀
    var baseURL: URL {
        return URL(string: "http://localhost:3000")!
    }
}
