//
//  ContentView.swift
//  Unit-Converter
//
//  Created by Micah Jesse Njeru on 24/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    // UI state properties
    @State private var userInput = 0.0
    @State private var userOutput = 0.0
    @State private var inputUnit = "Km"
    @State private var outputUnit = "Km"
    @FocusState private var userInputIsFocused: Bool
    
    // Declare list of conversions
    let units = ["Km", "M", "Cm", "mm"]
    
    // Conversion logic
    var computedValue: Double {
        let originalValue = Double(userInput)
        var computedValue = Double()
        var finalValue = Double()
        
        // Convert input to mm as a common denominator
        if inputUnit == units[0]{
            computedValue = Double(originalValue * 1000000)
        } else if inputUnit == units[1] {
            computedValue = Double(originalValue * 1000)
        } else if inputUnit == units[2] {
            computedValue = Double(originalValue * 10)
        } else if inputUnit == units[3] {
            computedValue = Double(originalValue * 1)
        }
        
        // Convert base value from mm to desired value
        if outputUnit == units[0] {
            finalValue = Double(computedValue / 1000000)
        } else if outputUnit == units[1] {
            finalValue = Double(computedValue / 1000)
        } else if outputUnit == units[2] {
            finalValue = Double(computedValue / 10)
        } else if outputUnit == units[3] {
            finalValue = Double(computedValue / 1)
        }
        
        return finalValue
    }
    
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    Text("Welcome to Unit-Converter")
                }
                
                Section{
                    Picker("Unit Value", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Select input unit")
                }
                .pickerStyle(.segmented)
                
                Section {
                    TextField("Enter value to convert", value: $userInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($userInputIsFocused)
                } header: {
                    Text("Enter value to convert here")
                }
                
                Section{
                    Picker("Select unit to convert to", selection: $outputUnit) {
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }
                
                Section {
                    // format:"%.2f" rounds off computedValue to 2 decimal places
                    Text(String(format: "%.2f", computedValue) + " " + outputUnit)
                } header: {
                    Text("Final value is:")
                }
            }
            .navigationTitle("Unit-Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
