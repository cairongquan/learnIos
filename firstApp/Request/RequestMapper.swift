import Moya

public struct RequestMapper{
    let requestIns = MoyaProvider<FirstAppApi>()
    
    // 请求新闻列表
    func getNewListData(id:String){
        requestIns.request(.getNewsList(id: "")){ result in
            switch result {
              case .success(let response):
                  let data = response.data
                print(data)
              case .failure(let error):
                  // 处理请求失败的错误
                  print("请求失败: \(error)")
              }
        }
    }
}
