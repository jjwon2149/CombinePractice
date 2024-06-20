//
//  ContentView.swift
//  CombinePractice
//
//  Created by 정종원 on 6/21/24.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var isButtonEnabled: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $inputText
            .map { $0.count > 5 }
            .assign(to: \.isButtonEnabled, on: self)
            .store(in: &cancellables)
    }
}

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField("input Text", text: $viewModel.inputText)
                .border(.black)
                .padding()
            
            Button {
               print("Button Clicked")
            } label: {
                Text("Submit")
            }
            .disabled(!viewModel.isButtonEnabled)
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
