import SwiftUI

struct ChoiceButton: View {
    var caption: LocalizedStringResource
    let alphabet = ["a", "b", "c", "d", "e", "f",
                    "g", "h", "i", "j", "k", "l",
                    "m", "n", "o", "p", "q", "r",
                    "s", "t", "u", "v", "w", "x",
                    "y", "z"]
    @Binding var input: String
    @Binding var output: String
    @Binding var hasSubmitted: Bool
    var algo: (Int, Int) -> Int
    
    var body: some View {
        Button(String(localized: caption.localizedStringResource)) {
            guard input.isEmpty == false else {
                return
            }
            
            let lInput = input.lowercased()
            hasSubmitted = true
            output = ""
            
            for char in lInput {
                let index = alphabet.firstIndex(of: String(char))
                
                if let index = index {
                    let shiftedIndex = algo(index, alphabet.count)
                    output = "\(output)\(alphabet[shiftedIndex])"
                } else {
                    output = "\(output)\(char)"
                }
            }
        }.buttonStyle(.bordered)
    }
}

