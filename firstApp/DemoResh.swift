import SwiftUI

struct ContentView1: View {
    @State private var items = ["Item 1", "Item 2", "Item 3"]
    @State private var isLoadingMore = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }

                    if isLoadingMore {
                        ProgressView() // 自定义加载更多的指示器
                            .frame(width: geometry.size.width, alignment: .center)
                            .padding()
                    }
                }
                .padding()
                .onAppear {
                    onAppear()
                }
            }
        }
    }

    func onAppear() {
        // 延迟2秒模拟加载更多数据
        isLoadingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoadingMore = false
            loadMore()
        }
    }

    func loadMore() {
        // 模拟加载更多数据
        items.append(contentsOf: ["Item 4", "Item 5", "Item 6"])
    }
}

struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
