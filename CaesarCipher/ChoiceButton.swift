import SwiftUI

struct ChoiceButton: View {
    var caption: LocalizedStringResource
    let lowAlphabet = ["a", "b", "c", "d", "e", "f",
                    "g", "h", "i", "j", "k", "l",
                    "m", "n", "o", "p", "q", "r",
                    "s", "t", "u", "v", "w", "x",
                    "y", "z"]
    let upAlphabet = ["A", "B", "C", "D", "E", "F",
                    "G", "H", "I", "J", "K", "L",
                    "M", "N", "O", "P", "Q", "R",
                    "S", "T", "U", "V", "W", "X",
                    "Y", "Z"]
    @Binding var input: String
    @Binding var output: String
    @Binding var hasSubmitted: Bool
    var algo: (Int, Int) -> Int
    
    var body: some View {
        Button(action: {
            guard input.isEmpty == false else {
                return
            }
            
            hasSubmitted = true
            output = ""
            
            for char in input {
                var index = lowAlphabet.firstIndex(of: String(char))
                var usedAlphabet = [String]()
                
                if index == nil { // If char couldn't be found in the lowercase-alphabet ...
                    index = upAlphabet.firstIndex(of: String(char)) // ... then try to find the char in the uppercase-alphabet
                    usedAlphabet = upAlphabet
                } else {
                    usedAlphabet = lowAlphabet
                }
                
                if let index = index {
                    let shiftedIndex = algo(index, usedAlphabet.count)
                    output = "\(output)\(usedAlphabet[shiftedIndex])"
                } else {
                    output = "\(output)\(char)"
                }
            }
        }, label: {
            Text(String(localized: caption.localizedStringResource))
                .frame(maxWidth: .infinity)
        })
        .buttonStyle(.bordered)
    }
}

