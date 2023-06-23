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
            .font(.largeTitle).bold()
    }
}

extension View{
    func moneyText() -> some View {
        self.modifier(MoneyText())
    }
}


struct ContentView: View {
    
    @State private var progress = 0.5
    @State private var budget = 5000
    @State private var isButtonTapped = false
    @State private var categories = [
        "Education", "Food", "Gift", "Groceries", "Entertainment"
    ]
    

    
    //dummy progress eg
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack{
                    VStack{
                        Text(self.dateString)
                            .foregroundColor(.gray).bold()
                        
                        HStack(spacing: 50){
                            VStack(spacing: 15){
                                Text("Budget")
                                    .mainText()
                                
                                Text("$1000")
                                    .moneyText()
                                
                            }
                            Divider()
                                .frame(height: 40)
                            VStack(spacing: 15){
                                Text("Left")
                                    .mainText()
                                
                                Text("$500")
                                    .moneyText()
                                
                            }
                        }
                        ProgressView(value: progress)
                        Text("You spent $xxx of $xxx.")
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal,20)
                    
                    VStack(alignment: .leading){
                        Text("Category")
                            .font(.title2).bold()
                        ScrollView{
                            HStack{
                                Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                                VStack(alignment: .leading){
                                    Text("Food")
                                    Text("Spend xx of xx")
                                }
                                Spacer()
                                VStack{
                                    Text("$0")
                                    Text("0% spent")
                                }
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            )
                        }
                    }
                    .padding()
                }
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button {
                            // do nothing
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .frame(width: 60, height: 60)
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(44)
                                .padding()
                                .onTapGesture {
                                    isButtonTapped = true
                                }
                        }

                    }
                }
            }
            .sheet(isPresented: $isButtonTapped) {
                NavigationView {
                    
                    VStack{
                        List{
                            ForEach(categories, id: \.self) { category in
                                NavigationLink {
                                    CategoryView(category: category)
                                } label: {
                                    Text(category)
                                }
                                
                            }
                        }
                    }
                    .navigationTitle("Select a Category")
                }
            }
        }
    
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
