//
//  ComposeView.swift
//  SwiftUIMemo
//
//  Created by 강윤서 on 3/11/25.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    
    var memo: Memo? = nil // 메모 전달 시 편집 모드, 전달되지 않을 시 쓰기 모드
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                // 투웨이 바인딩 : 입력한 내용이 컨텐트 속성에 자동으로 저장, 컨텐트 속성에 문자열을 저장하면 텍스트 에디터에 동일한 문자열 표시
                    .padding()
                    .onAppear {
                        if let memo = memo {
                            content = memo.content
                        }
                    }
            }
            .navigationTitle(memo != nil ? "메모 편집" : "새 메모")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading)
                {
                Button {
                    dismiss()
                } label: {
                    Text("취소")
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing)
                {
                Button {
                    // 저장기능 구현
                    
                    if let memo = memo {
                        store.update(memo: memo, content: content)
                    } else {
                        store.insert(memo: content)

                    }
                    dismiss()
                } label: {
                    Text("저장")
                    }
                }
            }
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
            .environmentObject(MemoStore())
    }
}
