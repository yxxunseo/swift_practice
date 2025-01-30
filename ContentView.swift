import SwiftUI

enum ButtonType: String {
    case first, second, third, forth, fifth, sixth, seventh, eighth, nineth, zero
    case dot, equal, plus, minus, multiple, divide
    case percent, opposite, clear

    var buttonDisplayname: String {
        switch self {
            case .first
                return "1"
            case .second
                return "2"
            case .third
                return "3"
            case .forth
                return "4"
            case .fifth
                return "5"
            case .sixth
                return "6"
            case .seventh
                return "7"
            case .eighth
                return "8"
            case .nineth
                return "9"
            case .zero
                return "0" 
            case .dot
                return "."
            case .equal
                return "="
            case .plus
                return "+"
            case .minus
                return "-"
            case .multiple
                return "X"
            case .divide
                return "/"
            case .percent
                return "%"
            case .opposite
                return "+/-"
            case .clear
                return "C"   
        }
    }
    var backgroundColor: Color {
        switch self {
            case .first. .second, .third, .forth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, .dot:
                return Color("NumberButton")

            case .equal, .plus, .minus, .multiple, .divide
            return Color.orange
            
            case .percent, .opposite, .clear:
            return Color.gray
        }
    }
    var foregroundColor:Color {
        case .first. .second, .third, .forth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, 
            .dot, .equal, .plus, .minus, .multiple, .divide:
            return Color.white

        case .percent, .opposite, .clear:
            return Color.black
    }
}

struct ContentView: View {

    @State private: View totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var operatorType: ButtonType = .clear
    @State var isNotEditing: Bool = true

    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite, .percent, .divide],
        [.seventh, .eighth, .nineth, .multiple],
        [.forth, .fifth, .sixth, .minus],
        [.fifth, .second, .third, .plus],
        [.zero, .dot, .equal]
    ]
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
         VStack {
            Spacer()
            HStack {
                Spacer()
                Text(totalNumber)
                    .padding()
                    .font(.system(size: 73))
                    .foregroundColor(.white)
            }
            ForEach(buttonData, id: \.self) { line in
                HStack {
                    ForEach(line, id: \.self) { item in 
                            Button {

                            if isNotEditing {
                                if item == .clear {
                                    totalNumber = "0"
                                    isNotEditing = true
                                } else if item == .plus || 
                                          item == .minus ||
                                          item == .multiple || 
                                          item == .divide {
                                        totalNumber = "Error"
                                }
                                else  {
                                    totalNumber = item.buttonDisplayname
                                    isNotEditing = false     // 나 이미 입력 받고 있어 
                                }


                            } else { 
                                if item == .clear {
                                    totalNumber = "0"
                                    isNotEditing = true
                                } else if item == .plus {
                                    tempNumber = Int(totalNumber) ?? 0 // 숫자를 저장
                                    operatorType = .plus               // 더하기를 한다
                                    isNotEditing = true               
                                    // 남은 숫자를 초기화한다. 
                                } else if item == .multiple {
                                    tempNumber = Int(totalNumber) ?? 0 
                                    operatorType = .multiple
                                    isNotEditing = true         // 나 새로 입력 받을래래        
                                } else if item == .minus {
                                    tempNumber = Int(totalNumber) ?? 0 
                                    operatorType = .minus
                                    isNotEditing = true          
                                }
                            }
                                else if item == .equal {
                                    
                                    if operatorType == .plus {
                                        totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)
                                    } else if operatorType == .multiple {
                                        totalNumber = String((Int(totalNumber) ?? 0) * tempNumber)
                                    } else if operatorType == .minus {
                                        totalNumber = String(tempNumber - (Int(totalNumber) ?? 0))
                                } 
                                else {
                                    totalNumber = item.buttonDisplayname
                            }
                                }
                        } label: {
                            Text(item.buttonDisplayname)
                            .bold()
                            .frame(width: calculateButtonWidth(button: item), height: calculateButtonHeight(button: item) )
                            .background(item.backgroundColor)
                            .cornerRadius(40)
                            .foregroundColor(item.foregroundColor)
                            .font(.system(size: 33))
                        }
                        
                    }
                }
            }
            }    
        }
    }
    private func calculateButtonWidth(button ButtonType: ButtonType) -> CGFloat {
        switch ButtonType{
            case .zero:
                return ((UIScreen.main.bounds.width - 5*10) / 4) * 2
            default:
                return (UIScreen.main.bounds.width - 5*10) / 4
        }
    }
    // (전체너비 - 5*10(5개의 여백(아이콘))) / 4 
    private func calculateButtonHeight(button: ButtonType) -> CGFloat {
        switch {
            return ((UIScreen.main.bounds.width - 5*10) / 4) 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}