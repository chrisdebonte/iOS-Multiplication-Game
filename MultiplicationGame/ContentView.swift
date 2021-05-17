//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Christopher DeBonte on 1/31/21.
//

import SwiftUI






struct ContentView: View {
    
    struct Question {
        var inputs: String
        var answer: String
    }
    @State private var gameStart = false
    @State private var tablesAmount = 3
    let questionAmount = ["5", "10", "20", "All"]
    @State private var qAmountSelectedIndex = 0
    @State var questions =  [Question]()
    @State var score = 0
    
    @State var qIndex = 0
    @State var answer = ""
    
    var body: some View {
        NavigationView {
            Group {
                    if !gameStart  {
                        Form {
                            
                            Text("How high do you want to go?")
                            
                            Stepper(value: $tablesAmount, in: 3 ... 12) {
                                Text("Up to \(tablesAmount)")
                            }
                            Text("How many Questions?")
                            Picker(selection: $qAmountSelectedIndex, label: Text("How many Questions?"), content: {
                                ForEach(0 ..< questionAmount.count) {
                                    Text(self.questionAmount[$0])
                                }
                            })
                            .pickerStyle(SegmentedPickerStyle())
                            HStack {
                                Spacer()
                                Button("Start!") {
                                    startTheGame(questionAmountIndex: qAmountSelectedIndex, tablesAmount: tablesAmount)
                                }
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
                            }
                        }
                        
                    } else {
                        Form {
                            Text("Score: \(score)")
                            Text("\(questions[qIndex].inputs)")
                            
                            TextField("Enter your answer: ", text: $answer)
                                .keyboardType(.numberPad)
                            HStack {
                                Spacer()
                                Button("Submit") {
                                    if(answer == questions[qIndex].answer) {
                                        score += 1
                                        answer = ""
                                        if((qIndex + 1) >= questions.count) {
                                            //call alert
                                            gameEnd()
                                        }
                                        else {
                                            qIndex += 1
                                        }
                                    } else {
                                        answer = ""
                                        if((qIndex + 1) >= questions.count) {
                                            //call alert
                                            gameEnd()
                                        }
                                        else {
                                            qIndex += 1
                                        }
                                    }
                                }
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
                            }
                        }
                    }
            }
            .navigationBarTitle("Times Table Game", displayMode: .inline)
        }
        
        
    }
    
    func startTheGame(questionAmountIndex: Int, tablesAmount: Int ) {
        //generate questions
        var num1: Int
        var num2: Int
        var qAmount: Int
        switch questionAmountIndex {
        case 0:
            qAmount = 5
        case 1:
            qAmount = 10
        case 2:
            qAmount = 20
        default:
            qAmount = 100
        }
        //generate questions
        for _ in 0..<qAmount {
            num1 = Int.random(in: 0 ..< 12)
            num2 = Int.random(in: 0 ..< tablesAmount)

            questions.append(Question(inputs: "\(num1) * \(num2)", answer: "\(num1 * num2)"))
            
        }
        
        gameStart = true
        
        
    }
    func gameEnd() {
        gameStart = false
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
