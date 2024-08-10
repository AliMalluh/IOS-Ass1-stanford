//
//  ContentView.swift
//  Ass1-Stanford
//
//  Created by Ali-Malluh on 25/12/2023.
//

import SwiftUI

struct ContentView: View {
    var animals = ["🐆","🐙","🦆","🦓","🪼","🪲","🐠","🐍","🕷️","🦂","🦇"]
    var cars = ["🏎️","🚓","🚑","🛻","🚒","🚐","🚕","🚛","🚜","🚚","🚙","🚌","🚗","🚎"]
    var tech = ["📱","⌚️","💻","📲","📷","💿","📹","🎥","🖱️","🖥️","🖨️","⌨️"]
    
    @State var selectedList: Array<String>?
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            cardThemesAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            if let selectedList {
                ForEach(
                    Array(selectedList.shuffled()
                        .prefix(selectedList.count)), id: \.self
                ) { item in
                    CardView(content: item)
                        .aspectRatio(3, contentMode: .fit)
                }
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardThemesAdjusters: some View {
        HStack {
            cardAnimals.padding()
            cardTech.padding()
            cardCars.padding()
        }
        .imageScale(.large)
        .font(.largeTitle)
        .padding()
    }
    
    func cardThemesAdjusters(by offset: Array<String>, symbol: String, hint: String) -> some View {
        Button(action: {
            selectedList = offset
        }, label : {
            VStack {
                Image(systemName: symbol).font(.title)
                Text(hint)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
        })
        .disabled(false)
    }
    
    var cardAnimals: some View {
        cardThemesAdjusters(by: animals, symbol: "pawprint.circle", hint: "Animals")
    }

    var cardTech: some View {
        cardThemesAdjusters(by: tech, symbol: "laptopcomputer", hint: "Tech")
    }
    
    var cardCars: some View {
        cardThemesAdjusters(by: cars, symbol: "car", hint: "Cars")
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            shape.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
