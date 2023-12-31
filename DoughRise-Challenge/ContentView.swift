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
            .foregroundColor(.black)
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
            .font(.system(size:18, weight: .bold, design: .monospaced))
            .foregroundColor(.black)
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
                Color.indigo
                    .ignoresSafeArea()
                
                VStack{
                    VStack{
                        VStack(spacing: 25){
                            
                            HStack{
                                Text(self.dateString)
                                    .foregroundStyle(Color.green)
                                    .font(.system(size: 14, weight: .bold))
                                
                                Image(systemName: "arrowtriangle.down.fill")
                                    .foregroundStyle(Color.green)
                                
                            }
                            .foregroundColor(.green).bold()
                            .padding(5)
                            .background(
                                Color.green.opacity(0.23)
                            )
                            
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            
                            HStack(spacing: 20){
                                VStack(alignment: .leading, spacing: 7){
                                    Text("Spent")
                                        .mainText()
                                    
                                    Text("$\(vm.amountSpend)")
                                        .moneyText()
                                        .animation(.interactiveSpring(), value: vm.amountSpend)
                                    
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
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.indigo))
                                .scaleEffect(x:0.9, y:10, anchor: .center)
                                .animation(.interactiveSpring(), value: vm.percentTracker)
                                .padding(.top, 15)
                                .padding(.bottom, 25)
                        }
                        
                        
                        
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
                                                .font(.system(size: 20, weight: .bold))
                                            HStack{
                                                Text("Spent")
                                                    .foregroundColor(.black.opacity(0.7))
                                                Text("$\(category.spent)")
                                                    .foregroundColor(.green).bold()
                                                Text("of")
                                                Text("$\(category.budget)")
                                                    .foregroundColor(.black.opacity(0.7))

                                            }
                                        }
                                        .foregroundStyle(Color.black)
                                        
                                        Spacer()
                                        VStack(alignment: .center){
                                            HStack(spacing: 30){
                                                Text("$\(category.amountLeft)")
                                                    .font(.title2).bold()
                                                    .foregroundStyle(Color.green)
                                                
                                                
                                            }
                                            HStack{
                                                Text("left")
                                            }
                                            .foregroundColor(.black)
                                        }
                                        
                                    }
                                    
                                    
                                    //progressView for the row
                                    ProgressView(value: category.percentSpent)
                                        .progressViewStyle(LinearProgressViewStyle(tint: category.categoryColor))
                                        .scaleEffect(x:1, y:2, anchor: .center)
                                        .padding(.top, 2)
                                    
                                }
                                .background(Color.white.opacity(0.95))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                
                            }
//                            .onDelete(perform: removeRow)
                            
                        }
                        .scrollIndicators(.hidden)
                        
                        .padding()
                    }
                    .padding(.top, 20)
                    
                   
                }
                .frame(width: geo.size.width * 0.87, height: geo.size.height * 0.80)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
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
                    .position(x: geo.size.width - 40, y: geo.size.height - 40)

                
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
