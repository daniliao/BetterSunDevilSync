//
//  anotherView.swift
//  IntroSwiftUI
//
//  Created by Janaka Balasooriya on 1/14/25.
//

import SwiftUI

struct anotherView: View {
    @State var name: String = ""
    @State var age: String = ""
    @State var greeting: String = "Welcome"
    @State var imageName:String = ""
    
    @State var val: Double = 0
    
    var body: some View {
       
        //show()
        
        
       VStack {
            Text("Welcome to CSE 335")
             
            Spacer()
            
            HStack{
            Text("Name: " )
             Spacer()
             Spacer()
            TextField("name here", text: $name, onEditingChanged: { (changed) in
                print("Username onEditingChanged - \(changed)")
            }).autocorrectionDisabled()
            }
            
             HStack{
             Text("Age: " )
             Spacer()
             Spacer()
                 TextField("age here", text: $age, onEditingChanged: { (changed) in
                print("Username onEditingChanged - \(changed)")
            })
            }
            
             Spacer()
            Button(action: {
                self.greeting = "Welcome \(self.name)"
                self.imageName = "smily"
                
            }) {
                Text("Click Me !")
            }
             Spacer()
        
            Text(greeting)
           
            Spacer()
        
            Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 40.0, height: 40, alignment: .center)
        
          //Spacer()
         
        }.padding()
            
            
       
     
        
    }
}

#Preview {
    anotherView()
}
