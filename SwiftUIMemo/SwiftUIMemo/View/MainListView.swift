//
//  MainListView.swift
//  SwiftUIMemo
//
//  Created by 강윤서 on 3/11/25.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store: MemoStore
    
    @State private var showComposer: Bool = false
    

    var body: some View {
        NavigationView {
            List {
                ForEach(store.list) { memo in
                    NavigationLink {
                        DetailView(memo: memo)
                    } label: {
                        MemoCell(memo: memo) // 뷰 분리(코드 가독성 상승, 유지보수에 도움)
                    }
                }
                .onDelete(perform: store.delete)
            }
            .listStyle(.plain)
            .navigationTitle("내 메모")
            .toolbar {
                Button { // 플러스 버튼 클릭 시 실행
                    showComposer = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showComposer) { // 바인딩 한 속성에 True 가 저장되면 클로저 실행 -> 클로저에서 리턴한 뷰를 모달 방식으로 표시
                ComposeView()
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .environmentObject(MemoStore())
    }
}

