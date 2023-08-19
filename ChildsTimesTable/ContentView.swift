//
//  ContentView.swift
//  ChildsTimesTable
//
//  Created by Eugene on 16/08/2023.
//

import SwiftUI

struct ButtonPadStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .controlSize(.large)
    }
}

extension View {
    func buttonPadStyle() -> some View {
        modifier(ButtonPadStyle())
    }
}


struct Questions {
    var questions: Array<String> = [""]
    var answers: Array<Int> = [0]
    
    mutating func generateQuestions() {
        for i in 2...12 {
            for j in 1...12 {
                
                questions.append("What is \(i) x \(j)?")
                answers.append((i * j))
            }
        }
        
        questions.remove(at: 0)
        answers.remove(at: 0)
    }
    
}


struct ContentView: View {
    
    @State private var gameStarted = false
    @State private var chosenTimesTable = 2
    @State private var totalQuestions = 5
    @State private var questions: Array<String> = [""]
    @State private var answers: Array<Int> = [0]
    @State private var answer = 0
    @State private var questionNumber = 0
    @FocusState private var inputValueIsFocused: Bool
    @State private var showingScore = false
    @State private var score = 0
    
    @State private var buttonPadAnswers = [""]
    

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
                        
                    }
                    Spacer()
                    if gameStarted {
                        
                        VStack {
                            Spacer()
                            Text(questions[questionNumber]).font(.title).animation(.default)
                            Spacer()
                            Text("\(answer)").font(.title)
                            .focused($inputValueIsFocused)
                            Spacer()


                        }.multilineTextAlignment(.center)
                            .frame(width: 250, height: 100)
                            .background(.ultraThickMaterial)
                            .overlay(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25))
                                .stroke(Color.black, lineWidth: 1.0))
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25)))
                        
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
                        
                        Spacer()
                        
                        
                        VStack (spacing: 20) {
                            HStack (spacing: 20) {
                                Button("1") {
                                    
                                    buttonPadAnswers.append("1")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 1

                                }
                                    .buttonPadStyle()
                                Button("2") {
                                    
                                    buttonPadAnswers.append("2")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 2
                                }
                                    .buttonPadStyle()
                                Button("3") {
                                    buttonPadAnswers.append("3")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 3
                                }
                                    .buttonPadStyle()
                            }
                            HStack (spacing: 20 ){
                                Button("4") {
                                    buttonPadAnswers.append("4")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 4

                                }
                                    .buttonPadStyle()
                                Button("5") {
                                    buttonPadAnswers.append("5")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 5

                                }
                                    .buttonPadStyle()
                                Button("6") {
                                    buttonPadAnswers.append("6")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 6

                                }
                                    .buttonPadStyle()
                            }
                            HStack (spacing: 20) {
                                Button("7") {
                                    buttonPadAnswers.append("7")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 7

                                }
                                    .buttonPadStyle()
                                Button("8") {
                                    buttonPadAnswers.append("8")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 8

                                }
                                    .buttonPadStyle()
                                Button("9") {
                                    buttonPadAnswers.append("9")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 9

                                }
                                .buttonPadStyle()
                            }
                            HStack (alignment: .center, spacing: 20) {
                             
                                Button("0") {
                                    buttonPadAnswers.append("0")
                                    let answerStr = buttonPadAnswers.joined(separator: "")
                                    answer = Int(answerStr) ?? 0

                                    print(answer)
                                }
                                .buttonPadStyle()
                                Button("Enter") {
                                    checkAnswer()
                                    buttonPadAnswers = [""]
                                }
                                .buttonPadStyle()
                               
                            }
                        
                    }
                  
                    }

                    
                    
                    

                    
                    
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
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button("New Game") {
                                startNewGame()
                            }
                        }
                        
                    }
            }.onAppear {
                score = 0
                generateQuestions(for: chosenTimesTable, with: totalQuestions)
                questionNumber = Int.random(in: 0..<totalQuestions)
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
    
    func startNewGame() {
        gameStarted = true
        score = 0
        generateQuestions(for: chosenTimesTable, with: totalQuestions)
//        var qs = Questions()
//        qs.generateQuestions()
//        print(qs.questions)
//        print(qs.answers)
//        questions = qs.questions
//        answers = qs.answers
        
        
        
        
        questionNumber = Int.random(in: 0..<totalQuestions)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

