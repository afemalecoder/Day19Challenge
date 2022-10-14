//
//  ContentView.swift
//  Day19Challenge
//
//  Created by Matilda Cederberg on 13/10/2022.
//


import SwiftUI

struct ContentView: View {
    
    enum TempType: String, CaseIterable{
        case celsius = "Celsius"
        case fahrenheit = "Faharenheit"
        case kelvin = "Kelvin"
    }
    
    @State private var inputUnit: TempType = .celsius
    @State private var outputUnit: TempType = .celsius
    @State private var firstAmount = ""
    
    var conversion: Double {
        guard let inputAmount = Double(firstAmount) else { return 0 }
        var conversionInput = 0.0
        var conversionResult = 0.0
        
        switch inputUnit{
        case .celsius:
            conversionInput = inputAmount + 273.15
        case .fahrenheit:
            conversionInput = (inputAmount - 32) * 5 / 9 + 273.15
        case .kelvin:
            conversionInput = inputAmount
        }
        switch outputUnit{
        case .celsius:
            conversionResult = conversionInput - 273.15
        case .fahrenheit:
            conversionResult = ((conversionInput - 273.15) * 9 / 5) + 32
        case .kelvin:
            conversionResult = conversionInput
        }
        return conversionResult
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Amount", text: $firstAmount)
                }header: {
                    Text("Convert")
                }
                
                Section{
                    Picker("Select Unit", selection: $inputUnit){
                        ForEach(TempType.allCases, id: \.self){
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Select input unit")
                }
                
                Section{
                    Picker("Select Unit", selection: $outputUnit){
                        ForEach(TempType.allCases, id: \.self){
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Select output unit")
                }
                
                Section{
                    Text("\(conversion, specifier: "%.2F")")
                }header: {
                    Text("Converted")
                }
            }
            .navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
