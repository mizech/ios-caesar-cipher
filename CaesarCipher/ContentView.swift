import SwiftUI

struct ContentView: View {
    @State var input = ""
    @State var output = ""
    @State var shift  = 1
    @State var hasSubmitted = false
    let alphabet = ["a", "b", "c", "d", "e", "f",
                    "g", "h", "i", "j", "k", "l",
                    "m", "n", "o", "p", "q", "r",
                    "s", "t", "u", "v", "w", "x",
                    "y", "z"]
    
    var body: some View {
        VStack {
            Text("Caesar Cipher").font(.title)
            Form {
                Section("Text to Encrypt/Decrypt") {
                    TextField("Text to Encrypt/Decrypt", text: $input)
                        .lineLimit(2)
                        .disabled(hasSubmitted)
                    HStack {
                        if hasSubmitted {
                            Spacer()
                            Button("Reset") {
                                input = ""
                                output = ""
                                hasSubmitted = false
                                shift = 1
                            }.buttonStyle(.borderedProminent)
                            Spacer()
                        } else {
                            Spacer()
                            Button("Encrypt") {
                                let lInput = input.lowercased()
                                hasSubmitted = true
                                output = ""
                                
                                for char in lInput {
                                    let index = alphabet.firstIndex(of: String(char))
                                    
                                    if let index = index {
                                        let shiftedIndex = (index + shift) % alphabet.count
                                        output = "\(output)\(alphabet[shiftedIndex])"
                                    } else {
                                        output = "\(output)\(char)"
                                    }
                                }
                            }.buttonStyle(.borderedProminent)
                            Spacer()
                            Button("Decrypt") {
                                let lInput = input.lowercased()
                                hasSubmitted = true
                                output = ""
                                
                                for char in lInput {
                                    let index = alphabet.firstIndex(of: String(char))
                                    
                                    if let index = index {
                                        let shiftedIndex = ((index - shift) + alphabet.count) % alphabet.count
                                        output = "\(output)\(alphabet[shiftedIndex])"
                                    } else {
                                        output = "\(output)\(char)"
                                    }
                                }
                            }.buttonStyle(.bordered)
                            Spacer()
                        }
                    }.padding(.top, 20)
                }
                
                Section("Encrypt/Decrypt Result") {
                    Text(output).bold()
                }
            }
        }
        .padding()
    }
    
    func handleButtonClick() -> Void {
        
    }
}

#Preview {
    ContentView()
}
