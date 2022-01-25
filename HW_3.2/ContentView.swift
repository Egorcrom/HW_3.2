//
//  ContentView.swift
//  HW_3.2
//
//  Created by Егор Кромин on 25.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redValue = 111.0
    @State private var greenValue = 111.0
    @State private var blueValue = 111.0
    
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 150)
                .foregroundColor(colorFromSliders())
            
            ColoredSliderView(value: $redValue, sliderColor: .red)
            ColoredSliderView(value: $greenValue, sliderColor: .green)
            ColoredSliderView(value: $blueValue, sliderColor: .blue)
            Spacer()
            
        }.padding()
    }
    
    private func colorFromSliders () -> Color {
        return Color( red: redValue/255, green: greenValue/255, blue: blueValue/255)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColoredSliderView: View {
    @Binding var value: Double
    var sliderColor: Color

    var body: some View {
        HStack{
            Text("\(lround(value))").frame(width: 35)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(sliderColor)
            TextField("0", value: $value, format: .number)
                .addToolbar()
                .textFieldStyle(.roundedBorder)
                .frame(width: 45)
                .keyboardType(.numberPad)
        }
    }
}

struct ToolbarModifier: ViewModifier {
    @FocusState  private var isFocused: Bool
    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
            }
    }
}
extension TextField {
    func addToolbar() -> some View {
        ModifiedContent(content: self, modifier: ToolbarModifier())
    }
}
