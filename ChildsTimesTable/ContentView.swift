//
//  ContentView.swift
//  ChildsTimesTable
//
//  Created by Eugene on 16/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var chosenTimesTable = 2
    @State private var numberQuestions = 5
    @State private var questions: Array<String> = [""]
    @State private var answer = ""
    

    var body: some View {
        NavigationView {
            
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.9, green: 0.7, blue: 0.1), Color.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()

                
                VStack {
                    
                    Section {
                        Text("Choose a times table to practice").font(.headline)
                        Stepper("\(chosenTimesTable) times table", value: $chosenTimesTable, in: 2...12, step: 1 )

                        
                        Text("How many questions").font(.headline)
                        Stepper("\(numberQuestions) questions", value: $numberQuestions, in: 5...20, step:(numberQuestions == 10 ? 10 : 5) )
//                            .onChange(of: numberQuestions) {
//                            self.createTimesTableQuestions(for: chosenTimesTable, with: numberQuestions)
//                        }
                        
                        Button("Generate Questions") {
                            generateQuestions(for: chosenTimesTable, with: numberQuestions)
                        }
                        
                        Button("Start Game ") {
                            // TODO: show a random question and place to answer it

                        }
                    }
                   Spacer()
                    
               
                    // display answers
                    if questions.count > 1 {
                        ForEach(questions, id: \.self) { question in
                            HStack {
                                Text(question)
                            }
                        }
                    }
                    
                    Spacer()

                

                }.navigationTitle("TimesTableFun")
                    .padding()
            }
 
        }
    }
    
    func generateQuestions(for timeTable: Int, with noQuestions: Int) {
        for i in 1...numberQuestions {
            
            questions.append("What is \(i) x \(timeTable)?")
            // is \(i * timeTable)
         }
        questions.remove(at: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
