//
//  ChoiceButton.swift
//  CaesarCipher
//
//  Created by Michael on 07.01.24.
//

import SwiftUI

struct ChoiceButton: View {
    var caption = ""
    var style: BorderedProminentButtonStyle = .borderedProminent
    var algo: () -> Void
    
    var body: some View {
        Button(caption) {
            algo()
        }.buttonStyle(style)
    }
}

#Preview {
    ChoiceButton() {
        
    }
}
