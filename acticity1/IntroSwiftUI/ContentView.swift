//
//  ContentView.swift
//  IntroSwiftUI
//
//  Created by Daniel Liao on 1/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        show()
    }
    
    
    
    
    struct show : View
    {
        @State var fname: String = ""
        @State var lname: String = ""
        @State var greeting: String = "Welcome"
        @State var imageName:String = ""
        
        
        @State var val: Double = 0
        
        var body: some View {
            
            //show()
            
            
            VStack {
                Text("Welcome to CSE 335")
                
                Spacer()
                
                if #available(iOS 14.0, *) {
                    Link("VIEW DEMO IN ACTION!",
                         destination: URL(string: "https://youtu.be/dQw4w9WgXcQ?si=JibMEK5UUgaS0pqS")!)
                } else {
                    
                }
                
                Spacer()
                    .frame(height: 30)
                
                HStack{
                    Text("First Name: " )
                    Spacer()
                    Spacer()
                    TextField("First Name here", text: $fname, onEditingChanged: { (changed) in
                        print("UserFirstName onEditingChanged - \(changed)")
                        
                    })
                }
                HStack{
                    Text("Last Name: " )
                    Spacer()
                    Spacer()
                    TextField("Last Name here", text: $lname, onEditingChanged: { (changed) in
                        print("UserLastName onEditingChanged - \(changed)")
                    })
                }
                Spacer()
                Button(action: {
                    self.greeting = "\(self.fname) \(self.lname) Welcome to CSE 335 "
                    self.imageName = "smily"
                    
                }) {
                    Text("Greeting !")
                }
                Spacer()
                Text(greeting)
                
                
                Spacer()
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40.0, height: 40, alignment: .center)
                
            }.padding()
        }
    }
    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
