import Moya

enum FirstAppApi {
    case getNewsList(id:String)
}

extension FirstAppApi:TargetType {
    
    //定义请求路径
    var path: String {
        switch self {
            case .getNewsList(let lastId):
                return "/news"
        }
    }
    
    // 请求方式
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain // 如果有请求参数，可以在此处返回相应的参数
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    // baseURL 接口前缀
    var baseURL: URL {
        return URL(string:"http://192.168.50.73:3000")!
    }
}
