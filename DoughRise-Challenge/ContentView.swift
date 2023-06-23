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
            .foregroundColor(.gray)
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
            .font(.system(size:24, weight: .bold, design: .monospaced))
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
//                LinearGradient(colors: [.blue, .indigo, .mint], startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
                
                VStack{
                    VStack{
                        Text(self.dateString)
                            .foregroundColor(.gray).bold()
                        
                        HStack(spacing: 50){
                            VStack(spacing: 15){
                                Text("Budget")
                                    .mainText()
                                
                                Text("$\(vm.budget)")
                                    .moneyText()
                                
                            }
                            Divider()
                                .frame(height: 40)
                            VStack(spacing: 15){
                                Text("Left")
                                    .mainText()
                                
                                Text("$\(vm.totalLeft)")
                                    .moneyText()
                                    .animation(.easeInOut(duration: 0.2), value: vm.totalLeft)
                                
                            }
                        }
                        ProgressView(value: vm.percentTracker)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                            .scaleEffect(x:1, y:3, anchor: .center)
                            .animation(.interactiveSpring(), value: vm.percentTracker)
                        Text("You spent $\(vm.amountSpend) of $\(vm.budget).")
                            .animation(.easeOut(duration: 0.2), value: vm.amountSpend)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal,20)
//                    .background(.black)
                    
                    VStack(alignment: .leading){
                        Text("Category")
                            .font(.title2).bold()
                        ScrollView{
                            ForEach(Array(vm.categoryItems.enumerated()), id: \.1.id) { index, category in
                                HStack{
                                    Image(systemName: category.icon)
                                    VStack(alignment: .leading){
                                        Text(category.name)
                                        Text("Spend $\(category.spent) of $\(category.budget)")
                                    }
                                    Spacer()
                                    VStack(alignment: .leading){
                                        HStack(spacing: 30){
                                            Text("$\(category.spent)")
                                                .font(.title2).bold()
                                            Image(systemName: "trash.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 15)
                                                .foregroundColor(.blue)
                                                .onTapGesture {
                                                    vm.categoryItems.remove(at: index)
                                                }
                                            
                                        }
                                        HStack{
                                            Text(String(format: "%.2f", category.percentSpent * 100)) + Text("% spent")
                                        }
                                        .foregroundColor(.red)
                                    }
                                    
                                }
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                )
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
                                .background(Color.indigo)
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
