//
//  ContentView.swift
//  DoughRise-Challenge
//
//  Created by bo zhong on 6/22/23.
//

import SwiftUI

struct MainText: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(Font.title2)
            .foregroundColor(.white)
    }
}

extension View {
    func mainText() -> some View{
        self.modifier(MainText())
    }
}

struct MoneyText: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.system(size:19, weight: .bold, design: .monospaced))
            .foregroundColor(.white)
    }
}

extension View{
    func moneyText() -> some View {
        self.modifier(MoneyText())
    }
}


struct ContentView: View {
    @StateObject var vm = CategoryItemViewModel()
    
    @State private var progress = 0.5
    @State private var categories = [
        CategoryItem(icon: "takeoutbag.and.cup.and.straw.fill", name: "Food", budget: Int.random(in: 200...500), spent: Int.random(in: 100...200)),
        CategoryItem(icon: "graduationcap", name: "Education", budget: Int.random(in: 200...500), spent: Int.random(in: 100...200)),
        CategoryItem(icon: "cross.case", name: "Medical", budget: Int.random(in: 200...500), spent: Int.random(in: 100...200))
    ]
    

    
    //dummy progress eg
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                LinearGradient(colors: [.blue, .indigo, .mint], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack{
                    VStack{
                                                
                        HStack{
                            Text(self.dateString)
                                .foregroundStyle(Color.white)
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundStyle(Color.white)
                        }
                        .foregroundColor(.green).bold()
                        .padding(5)
                        .background(
                            LinearGradient(colors: [.orange, .yellow, .red], startPoint: .top, endPoint: .bottom)
                                .opacity(0.95)
                        )
                        
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                        
                        HStack(spacing: 20){
                            VStack(alignment: .leading, spacing: 7){
                                Text("Spent")
                                    .mainText()
                                
                                Text("$\(vm.amountSpend)")
                                    .moneyText()
                                    .animation(.interpolatingSpring(), value: vm.amountSpend)
                                
                            }
                            
                            Divider()
                                .frame(height: 40)
                            
                            
                            VStack(alignment: .leading, spacing: 7){
                                Text("Available")
                                    .mainText()
                                Text("$\(vm.totalLeft)")
                                    .foregroundColor(.green)
                                    .moneyText()


                                
                            }
                            
                            
                            Divider()
                                .frame(height: 40)
                            
                            
                            VStack(alignment: .leading, spacing: 7){
                                Text("Budget")
                                    .mainText()

                                Text("$\(vm.budget)")
                                    .moneyText()
                                
                                
                            }
                        }
                        ProgressView(value: vm.percentTracker)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                            .scaleEffect(x:1, y:10, anchor: .center)
                            .animation(.interactiveSpring(), value: vm.percentTracker)
                            .padding(.top, 15)
                        Text("You spent $\(vm.amountSpend) of $\(vm.budget).")
                            .foregroundStyle(Color.white)
                            .animation(.easeOut(duration: 0.2), value: vm.amountSpend)
                            .padding(.top, 30)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1.5)
                    )
                    .padding(.horizontal,20)
//                    .background(.black)
                    
                    VStack(alignment: .leading){
                        Text("Category")
                            .font(.title2).bold()
                            .foregroundStyle(Color.white)
                        
                        ScrollView{
                            ForEach(Array(vm.categoryItems.enumerated()), id: \.1.id) { index, category in
                                VStack{
                                    HStack{
                                        Image(systemName: category.icon)
                                            .padding(10)
                                            .background(category.categoryColor)
                                            .clipShape(Circle())
                                            .foregroundStyle(Color.white)
                                        
                                        
                                        VStack(alignment: .leading){
                                            Text(category.name)
                                            Text("Spend $\(category.spent) of $\(category.budget)")
                                        }
                                        .foregroundStyle(Color.black)
                                        
                                        Spacer()
                                        VStack(alignment: .leading){
                                            HStack(spacing: 30){
                                                Text("$\(category.spent)")
                                                    .font(.title2).bold()
                                                    .foregroundStyle(Color.green)
                                                
                                                Image(systemName: "trash.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20, height: 15)
                                                    .foregroundColor(.red)
                                                    .onTapGesture {
                                                        vm.categoryItems.remove(at: index)
                                                    }
                                                
                                            }
                                            HStack{
                                                Text(String(format: "%.2f", category.percentSpent * 100)) + Text("% spent")
                                            }
                                            .foregroundColor(.gray)
                                        }
                                        
                                    }
//                                    .padding()
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.gray, lineWidth: 1)
//                                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
//                                    )
//                                    .background(Color.white.opacity(0.95))
//                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    
                                    //progressView for the row
                                    ProgressView(value: category.percentSpent)
                                        .progressViewStyle(LinearProgressViewStyle(tint: category.categoryColor))
                                        .scaleEffect(x:1, y:2, anchor: .center)
                                        .padding(.top, 2)
                                    
                                }
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                )
                                .background(Color.white.opacity(0.95))
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                                
                            }
                            .onDelete(perform: removeRow)
                            
                        }
                    }
                    .padding()
                }
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button {
                            let randomItem = categories.randomElement()!
                            vm.categoryItems.insert(randomItem, at: 0)
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(44)
                                .padding()
                        }
                        
                    }
                }
            }
        }
        
    }
    
    func removeRow(at offsets: IndexSet) {
        vm.categoryItems.remove(atOffsets: offsets)
    }
    
    var dateString: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
