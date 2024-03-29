import SwiftUI

struct ContentView: View {
    @State var input = ""
    @State var output = ""
    @State var shift  = 1
    @State var hasSubmitted = false
    
    let clipboard = UIPasteboard.general
    
    init() {
        UITextField.appearance().clearButtonMode = .always
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Caesar Cipher").font(.title)
                Form {
                    Section("Text to Encrypt/Decrypt") {
                        TextField(
                            "Insert text here",
                            text: $input
                        )
                        .lineLimit(2)
                        .disabled(hasSubmitted)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    }
                    
                    Section("Shift") {
                        Picker("Digits", selection: $shift) {
                            ForEach(1...25, id: \.self) { digit in
                                Text("\(digit)")
                            }
                        }
                    }
                    
                    Section("Actions") {
                        VStack(spacing: 20) {
                            if hasSubmitted {
                                Button(action: {
                                    input = ""
                                    output = ""
                                    hasSubmitted = false
                                    shift = 1
                                }, label: {
                                    Label("Reset", systemImage: "xmark.circle")
                                        .foregroundColor(.red)
                                        .frame(maxWidth: .infinity)
                                }).buttonStyle(.bordered)
                                
                                Button(action: {
                                    self.clipboard.string = output
                                }, label: {
                                    Label("Copy", systemImage: "doc.on.doc")
                                        .foregroundColor(.green)
                                        .frame(maxWidth: .infinity)
                                }).buttonStyle(.bordered)
                            } else {
                                Button(action: {
                                    if let clipboardStr = clipboard.string {
                                        input = "\(input)\(clipboardStr)"
                                    }
                                }, label: {
                                    Label("Paste", systemImage: "doc.on.clipboard.fill")
                                        .foregroundColor(.green)
                                        .frame(maxWidth: .infinity)
                                }).buttonStyle(.bordered)
                                CryptButton(
                                    imageName: "eye.slash",
                                    caption: LocalizedStringResource("Encrypt", defaultValue: "Encrypt"),
                                    input: $input,
                                    output: $output,
                                    hasSubmitted: $hasSubmitted
                                ) { index, count in
                                    (index + shift) % count
                                }
                                CryptButton(
                                    imageName: "eye",
                                    caption: LocalizedStringResource("Decrypt", defaultValue: "Decrypt"),
                                    input: $input,
                                    output: $output,
                                    hasSubmitted: $hasSubmitted
                                ) { index, count in
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if let url = URL(string: "https://en.wikipedia.org/wiki/Caesar_cipher") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
