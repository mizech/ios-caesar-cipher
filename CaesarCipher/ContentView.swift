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
                    TextField("Insert text here", text: $input)
                        .lineLimit(2)
                        .disabled(hasSubmitted)
                        .textInputAutocapitalization(.never)
                }
                
                Section("Shift") {
                    Picker("Digits", selection: $shift) {
                        ForEach(1...25, id: \.self) { digit in
                            Text("\(digit)")
                        }
                    }
                }
                
                Section("Submit") {
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
                            ChoiceButton(caption: LocalizedStringResource("Encrypt", defaultValue: "Encrypt"),
                                         input: $input,
                                         output: $output,
                                         hasSubmitted: $hasSubmitted) { index, count in
                                (index + shift) % count
                            }
                            Spacer() 
                            ChoiceButton(caption: LocalizedStringResource("Decrypt", defaultValue: "Decrypt"),
                                         input: $input,
                                         output: $output,
                                         hasSubmitted: $hasSubmitted) { index, count in
                                ((index - shift) + count) % count
                            }
                        }
                    }
                }
                
                Section("Encrypt/Decrypt Result") {
                    Text(output).bold()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
