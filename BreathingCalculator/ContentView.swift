//
//  ContentView.swift
//  BreathingCalculator
//
//  Created by Semih Karahan on 16.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    let backgroundColors = Gradient(colors: [.red, .cyan, .green])
    @State private var scale: CGFloat = 2.2
    @State private var displayText : String = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: backgroundColors, startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    ZStack{
                        Circle().stroke(Color.white)
                            .frame(width: 100)

                        Circle().stroke(Color.white)
                            .frame(width: 60)
                        
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .scaleEffect(scale)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                                    self.scale = 1.5
                                }
                            }
                    }.padding()

                    Text("Calculator")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(Color.white)
                                .shadow(color: Color(red: 1.0, green: 0.9, blue: 0.4), radius: 10, x: 0, y: 0)
                                .padding()
                }
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: .infinity)
                        .stroke(lineWidth:5)
                        .frame(height: 80)
                        .foregroundColor(.white)
                    
                    
                    Text(displayText)
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(Color.white)
                                .shadow(color: Color(red: 1.0, green: 0.9, blue: 0.4), radius: 10, x: 0, y: 0)
                                .padding()
                }.padding(.vertical, 45).padding(.horizontal, 20)

                Group{
                    HStack{
                        Button("A") {
                            displayText = ""
                        }.buttonStyle(buttonModel())
                        Button("C") {
                            displayText = String(displayText.dropLast())
                        }.buttonStyle(buttonModel())
                        Button("") {}.buttonStyle(buttonModel())
                        Button("+") {
                            displayText.append("+")
                        }.buttonStyle(buttonModel())
                    }
                    HStack{
                        Button("7") {
                            displayText.append("7")}.buttonStyle(buttonModel())
                        Button("8") {displayText.append("8")}.buttonStyle(buttonModel())
                        Button("9") {displayText.append("9")}.buttonStyle(buttonModel())
                        Button("-") {displayText.append("-")}.buttonStyle(buttonModel())
                    }
                    HStack{
                        Button("4") {displayText.append("4")}.buttonStyle(buttonModel())
                        Button("5") {displayText.append("5")}.buttonStyle(buttonModel())
                        Button("6") {displayText.append("6")}.buttonStyle(buttonModel())
                        Button("x") {displayText.append("x")}.buttonStyle(buttonModel())
                    }
                    HStack{
                        Button("1") {displayText.append("1")}.buttonStyle(buttonModel())
                        Button("2") {displayText.append("2")}.buttonStyle(buttonModel())
                        Button("3") {displayText.append("3")}.buttonStyle(buttonModel())
                        Button("/") {displayText.append("/")}.buttonStyle(buttonModel())
                    }
                    HStack{
                        Button("0") {displayText.append("0")}.buttonStyle(buttonModel())
                        Button(".") {displayText.append(".")}.buttonStyle(buttonModel())
                        Button("") {}.buttonStyle(buttonModel())
                        Button("=") {
                            evaluate()
                        }.buttonStyle(buttonModel())
                    }
                }.padding(3)
                Spacer()
            }
        }
    }
    
    func evaluate() {
        if (displayText.contains("+") ? 1 : 0) + (displayText.contains("-") ? 1 : 0) + (displayText.contains("x") ? 1 : 0) + (displayText.contains("/") ? 1 : 0) > 1{
            displayText = "Only One Type!"
        } else {
            if displayText.contains("+"){
                let subString = displayText.split(separator: "+")
                let intArray = subString.compactMap{ Double($0) }
                var sum = 0.0
                for num in intArray{
                    sum += num
                }
                displayText = "\(sum)"
            }
            if displayText.contains("-"){
                let subString = displayText.split(separator: "-")
                let intArray = subString.compactMap{ Double($0) }
                var sum = intArray[0]
                for num in 1..<intArray.count{
                    sum -= intArray[num]
                }
                displayText = "\(sum)"
            }
            if displayText.contains("x"){
                let subString = displayText.split(separator: "x")
                let intArray = subString.compactMap{ Double($0) }
                var sum = 1.0
                for num in intArray{
                    sum *= num
                }
                displayText = "\(sum)"

            }
            if displayText.contains("/"){
                let subString = displayText.split(separator: "/")
                let intArray = subString.compactMap{ Double($0) }
                var sum = intArray[0]
                for num in 1..<intArray.count{
                    sum /= intArray[num]
                }
                displayText = "\(sum)"
            }
        }
        
    }
}

struct buttonModel: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .padding(20)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .blur(radius: 10)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.1))
                        .blur(radius: 5)
                        .offset(x: -5, y: -5)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.2))
                        .blur(radius: 5)
                        .offset(x: 5, y: 5)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(RoundedRectangle(cornerRadius: 15).fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)))
                        )
                        .shadow(color: Color.blue.opacity(0.7), radius: 10, x: 5, y: 5)
                        .shadow(color: Color.blue.opacity(0.7), radius: 10, x: -5, y: -5)
                        .animation(configuration.isPressed ? Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true) : nil)
                }
            )
            .foregroundColor(.white)
            .font(.largeTitle)
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeInOut(duration: 0.1))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

