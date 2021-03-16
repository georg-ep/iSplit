//
//  ContentView.swift
//  WeSplit
//
//  Created by George Patterson on 05/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 0
    @State private var grandTotal = ""
    
    let tipPercentages = [0,10,15,20,25]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople)
        
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(totalAmount) ?? 0 //this is the easy unwrapping of an optional. Returns 0 if it cannot convert to double
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        let amountPerPerson = grandTotal / (peopleCount ?? 0)
        
        return amountPerPerson
        
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section {
                    TextField("Enter the amount", text: $totalAmount).keyboardType(.decimalPad)
                    TextField("Enter the number of people", text: $numberOfPeople).keyboardType(.numberPad)
                    
                    /*Picker("Number Of People", selection: $numberOfPeople){
                        ForEach(2..<20) {
                            Text("\($0) people")
                        }
                    }*/
                }
                
                Section(header: Text("How much tip would you like to leave?")) {
                    
                    Picker("Tip", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Grand Total (incl tip)")) {
                    let people = Double(numberOfPeople) ?? 0
                    Text("$\(totalPerPerson * people, specifier: "%.2f" )")
                }
                
                Section(header: Text("Tip amount at: \(tipPercentages[tipPercentage])%")) {
                    let decimalTip = Double(self.tipPercentages[tipPercentage]/100)
                    let total = Double(totalAmount) ?? 0
                    Text("$\(decimalTip * total, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                    //the specifier specifies our number to 2 floating points
                }
                
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
