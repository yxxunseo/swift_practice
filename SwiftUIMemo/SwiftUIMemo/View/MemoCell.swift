//
//  MemoCell.swift
//  SwiftUIMemo
//
//  Created by 강윤서 on 3/11/25.
//

import SwiftUI

struct MemoCell: View {
    @ObservedObject var memo : Memo
    var body: some View {
        VStack(alignment: .leading) { // Vertical : 수직의 ,, alignment: .leading : 왼쪽으로 정렬
            Text(memo.content)
                .font(.body)
                .lineLimit(1) // 메모 내용 한 줄만 표시, 메모 내용이 길다면 ... 으로 생략
            
            
            Text(memo.insertDate, style: .date)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}


struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(content: "Test"))
    }
}
