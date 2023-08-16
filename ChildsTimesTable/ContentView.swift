//
//  ContentView.swift
//  ChildsTimesTable
//
//  Created by Eugene on 16/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var chosenTimesTable = 2
    @State private var totalQuestions = 5
    @State private var questions: Array<String> = [""]
    @State private var answers: Array<Int> = [0]
//    @State private var questionsAnswered: Array<String> = [""]
    @State private var answer = 0
    @State private var questionNumber = 0
    @FocusState private var inputValueIsFocused: Bool
    @State private var showingScore = false
    @State private var score = 0
    

    var body: some View {
        NavigationView {
            
                
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.9, green: 0.7, blue: 0.1), Color.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()

                
                VStack {
                    
                    Section {
                        Text("Choose a times table to practice").font(.headline)
                        Stepper("\(chosenTimesTable) times table", value: $chosenTimesTable, in: 2...12, step: 1 )

                        
                        Text("How many questions").font(.headline)
                        Stepper("\(totalQuestions) questions", value: $totalQuestions, in: 5...20, step:(totalQuestions == 10 ? 10 : 5) )
//                            .onChange(of: numberQuestions) {
//                            self.createTimesTableQuestions(for: chosenTimesTable, with: numberQuestions)
//                        }
                        
                        
                        Button("Start Game ") {
                            // TODO: show a random question and place to answer it
                            score = 0
                            generateQuestions(for: chosenTimesTable, with: totalQuestions)
                            questionNumber = Int.random(in: 0..<totalQuestions)

                            
                        }
                        
                    }
                    Spacer()
                    
                    VStack {
                        Text(questions[questionNumber]).font(.headline).animation(.default)
                        TextField("Enter your answer", value: $answer, format:
                                .number)
                        .keyboardType(.decimalPad)
                        .focused($inputValueIsFocused)

                    }.multilineTextAlignment(.center)
                    .onSubmit {
                        checkAnswer()
                    }
                    .alert(isPresented: $showingScore) {
                        Alert(
                            title: Text(answer == answers[questionNumber] ? "Correct" : "Wrong"),
                            message: Text("You have \(score) points in total"),
                            dismissButton: .default(Text("Continue")) {
                                nextQuestion()
                            })
                    }

                    
                    
                    
                    // display answers
//                    if questionsAnswered.count > 1 {
//                    ForEach(questionsAnswered, id: \.self) { question in
//                            HStack {
//                                Text(question)
//                            }
//                        }
//                    }

                    
                    
                    Spacer()

                

                }.navigationTitle("TimesTableFun")
                    .padding()
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                inputValueIsFocused = false
                            }
                        }
                    }
            }
 
        }
    }
    
    func generateQuestions(for timeTable: Int, with noQuestions: Int) {
        questions = [""]
        answers = []
        for i in 1...totalQuestions {
            
            questions.append("What is \(i) x \(timeTable)?")
            answers.append((i * timeTable))
         }
        questions.remove(at: 0)
    }
    
    func checkAnswer() {
        print("Questions is \(questions)")
        print("Answer is \(answer)")
        print("answers is \(answers)")
        
        
        print("answers for question is \(answers[questionNumber])")
        
        showingScore = true
        
        if answer == answers[questionNumber] {
            // correct answer!
            score += 1

        } else {
            score -= 1
        }
        

    }
    
    func nextQuestion() {
        questionNumber = Int.random(in: 0..<totalQuestions)
        answer = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
