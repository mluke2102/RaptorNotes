//
//  RecorderView.swift
//  Raptor
//
//  Created by Matt Luke on 8/25/22.
//

import SwiftUI

struct RecorderView: View {
    
    @State var animateSearchBar = false
    @State var isRecording = false
    @FocusState var searchIsFocused: Bool
    @State var isPaused = true
    
    @StateObject public var speechRecognizer = SpeechRecognizer()

    @Binding var sentences: [Sentence]
    
    var body: some View {
        VStack {
            HStack {
                Text("Pyramids of Giza")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Button {
                    print("Fullscreen")
                } label: {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .padding(9)
                        .background(Color.accentColor.opacity(0.1))
                        .foregroundColor(.accentColor)
                        .font(.title)
                        .fontWeight(.semibold)
                        .cornerRadius(30)
                        .padding(.leading)
                }
            }.padding(.top, 35)
            
            VStack {
                
                SectionContainerView(sectionName: "Live Transcript", symbolName: "quote.bubble.fill", speechRecognizer: speechRecognizer, isPaused: $isPaused, sentences: $sentences)
                
                if !animateSearchBar {
                    Button {
                        print("Add Presentation")
                    } label: {
                        HStack {
                            Text("Add Presentation")
                                .fontWeight(.semibold)
                            Image(systemName: "rectangle.stack.fill.badge.plus")
                        }
                        .padding(10)
                        .background(Color.accentColor.opacity(0.1))
                        .cornerRadius(8)
                    }.foregroundColor(.accentColor)
                    RecordingControlView(speechRecognizer: speechRecognizer, isRecording: $isRecording, isPaused: $isPaused)
                }
                
                
            }
        }.background(Color(UIColor.secondarySystemBackground).opacity(0.5))
        
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    
//                    HStack {
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                            TextField("Search", text: $text)
//                                .focused($searchIsFocused)
//                            
//                        }.frame(width: animateSearchBar ? 400 : 200)
//                        
//                            .padding(7)
//                            .background(Color(.systemGray6))
//                            .cornerRadius(100)
//                        
//                        
//                            .onTapGesture {
//                                withAnimation(.spring(response:0.2)) {
//                                    searchIsFocused = true
//                                }
//                            }
//                            .onChange(of: searchIsFocused) { bool in
//                                withAnimation(.easeInOut(duration: 0.2)) {
//                                    animateSearchBar = bool
//                                }
//                            }
//                        
//                        
//                        
//                        
//                        if animateSearchBar {
//                            Button(action: {
//                                withAnimation(.spring(response: 0.2)) {
//                                    searchIsFocused = false
//                                }
//                                
//                                self.text = ""
//                                
//                            }) {
//                                Text("Cancel")
//                            }
//                            
//                            
//                            
//                        }
//                        Spacer()
//                    }
//                    
//                }
//                
//                ToolbarItemGroup() {
//                    
//                    Button {
//                        print("Bookmark")
//                    } label: {
//                        Image(systemName: "bookmark")
//                    }
//                    
//                    Button {
//                        print("Share")
//                    } label: {
//                        Image(systemName: "square.and.arrow.up")
//                    }
//                    
//                    Menu {
//                        
//                        Button(action: {}) {
//                            Label("Rename Recording", systemImage: "pencil")
//                        }
//                        
//                        Button(action: {}) {
//                            Label("Add Presentation", systemImage: "rectangle.stack.fill.badge.plus")
//                        }
//                        Divider()
//                        Button(role: .destructive, action: {}) {
//                            Label("Delete Recording", systemImage: "trash.fill")
//                            
//                        }
//                    } label: {
//                        VStack {
//                            Image(systemName: "ellipsis.circle")
//                            
//                            
//                        }
//                    }
//                    
//                    
//                }
//            }
    }
}

struct SectionContainerView: View {
    
    @State var sectionName: String
    @State var symbolName: String
    @StateObject var speechRecognizer: SpeechRecognizer
    @Binding var isPaused: Bool
    
    @Binding var sentences: [Sentence]
    
    var body: some View {
        VStack(spacing: 5) {
            SectionLabelView(sectionName: sectionName, symbolName: symbolName, isPaused: $isPaused)
            ScrollView {
                
                VStack() {
                    Spacer()
                        .frame(height: 30)
                    Text(sentences[0].text)
                    Text(speechRecognizer.transcript)
                        .padding([.horizontal, .bottom], 30)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                
            }.background(Color(UIColor.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 20, y: 10)
                
        }
        .frame(minHeight: 250)
        .padding([.leading, .trailing], 50)
        .padding(.bottom, 25)
        
        
    }
}

struct RecordingControlView: View {
    
    @State var sectionName = "Recording..."
    @State var symbolName = "mic.fill"
    
    
   
    @StateObject public var speechRecognizer: SpeechRecognizer
    
    @Binding var isRecording: Bool
    @Binding var isPaused: Bool
    
    
    
    @Namespace var namespace
    
    var body: some View {
        VStack(spacing: 5) {
            SectionLabelView(sectionName: sectionName, symbolName: symbolName, isRecorder: true, isPaused: $isPaused)
            VStack {
                
                HStack(spacing: 8) {
                    
                    if isRecording {
                        VStack {
                            Button {
                                isPaused.toggle()
                            } label: {
                                if isPaused {
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.white)
                                        .frame(minWidth: 75, maxHeight: .infinity)
                                        .background(.yellow)
                                    .cornerRadius(8)
                                } else {
                                    Image(systemName: "pause.fill")
                                        .foregroundColor(.white)
                                        .frame(minWidth: 75, maxHeight: .infinity)
                                        .background(Color(UIColor.systemGray3))
                                    .cornerRadius(8)
                                }
                            }
                            
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    
                                    speechRecognizer.stopTranscribing()
                                    
                                    //transcription = speechRecognizer.transcript
                                    isRecording = false
                                    isPaused = true
                                }
                            } label: {
                                Image(systemName: "stop.fill")
                                    .foregroundColor(.white)
                                    .frame(minWidth: 75, maxHeight: .infinity)
                                    .background(.red)
                                    .cornerRadius(8)
                            }.matchedGeometryEffect(id: "record", in: namespace)
                        }
                        
                    } else {
                        
                        Button {
                            speechRecognizer.reset()
                            speechRecognizer.transcribe()
                            
                           
                            
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                isRecording = true
                                isPaused = false
                            }
                        } label: {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color.white)
                                .frame(minWidth: 75, maxHeight: .infinity)
                                .background(Color(UIColor.systemGray3))
                                .cornerRadius(8)
                        }.matchedGeometryEffect(id: "record", in: namespace)
                        
                        
                    }
                    
                    

                    
                    VStack {
                        ZStack {
                            //Text(speechRecognizer.transcript)
                            Color(uiColor: .secondarySystemBackground)
                                .frame(maxHeight: .infinity)
                                .cornerRadius(8)
                            Color.accentColor
                                .frame(width: 3)
                                .cornerRadius(100)
                        }
                        Text("00:00:00")
                            .frame(maxHeight: .infinity)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                    }
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 130, maxHeight: 130)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 20, y: 10)
            
        }
        .padding(.bottom)
        .padding([.leading, .trailing], 50)
        
        
        
    }
}

struct SectionLabelView: View {
    
    @State var sectionName: String
    @State var symbolName: String
    @State var isRecorder = false
    @Binding var isPaused: Bool
    @Namespace var namespace
    
    var body: some View {
        HStack(spacing: 0) {
            
            
            if isRecorder {
                
                
                Image(systemName: isPaused ? "mic.slash.fill" : symbolName)
                if !isPaused {
                    Image(systemName: "wave.3.right")
                }
                
                Text(isPaused ? "Paused" : "Recording...")
                    .padding(.leading, 5)
                    .matchedGeometryEffect(id: "recordingIndicator", in: namespace)
            
                
                
            } else {
                Image(systemName: symbolName)
                Text(sectionName)
                    .padding(.leading, 5)
            }
            
            
            Spacer()
        }
        .frame(maxHeight: 20)
        .padding(.leading)
        .font(.headline)
        .foregroundColor(.gray)
        
    }
}

//struct RecorderView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecorderView()
//    }
//}
