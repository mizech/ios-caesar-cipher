import SwiftUI

struct ContentView: View {
    @State var input = ""
    @State var output = ""
    @State var shift  = 1
    @State var hasSubmitted = false
    
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
                            ChoiceButton(caption: "Encrypt",
                                         shift: shift,
                                         input: $input,
                                         output: $output,
                                         hasSubmitted: $hasSubmitted) { index, shift, count in
                                (index + shift) % count
                            }
                            Spacer()
                            ChoiceButton(caption: "Decrypt",
                                         shift: shift,
                                         input: $input,
                                         output: $output,
                                         hasSubmitted: $hasSubmitted) { index, shift, count in
                                ((index - shift) + count) % count
                            }
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
