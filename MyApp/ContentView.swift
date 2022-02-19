//
//  ContentView.swift
//  MyApp
//
//  Created by SUshil on 19/02/22.
//

import SwiftUI
import FirebaseAuth
import Firebase

class AppViewModel:ObservableObject{
    let auth = Auth.auth()
    @Published var signIn = false
    
    var isSignedIn : Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email:String,password:String){
        auth.signIn(withEmail:email,password:password){[weak self]
            result,error in
            guard result != nil , error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signIn = true
            }
            
        }
    }
    func signUp(email:String,password:String){
        auth.createUser(withEmail: email, password: password){[weak self] result ,error in
            guard result != nil , error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signIn = true
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        self.signIn = false
    }
    
}

struct ContentView: View {
    
    @EnvironmentObject var viewModel:AppViewModel
    var body: some View {
        NavigationView{
            if viewModel.signIn{
                VStack{
                    Text("you are signed in")
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("SignOut")
                            .foregroundColor(.blue)
                    })
                }
                
                
                
            }else{
                SignInView()
            }
        }
        .onAppear{
            viewModel.signIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel:AppViewModel
    var body: some View {
        
        VStack{
            TextField("email address",text:$email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            SecureField("password",text:$password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            Button(action: {
                guard !email.isEmpty,!password.isEmpty else{
                    return
                }
                viewModel.signIn(email: email, password: password)
                
                
            }, label: {
                Text("sign in")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color.blue)
            })
            NavigationLink("create account",destination: SignUpView())
                .padding()
        }.padding()
        Spacer()
            
    }
    // .navigationTitle("Sign In")
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel:AppViewModel
    var body: some View {
        
        VStack{
            TextField("email address",text:$email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            SecureField("password",text:$password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            Button(action: {
                guard !email.isEmpty,!password.isEmpty else{
                    return
                }
                viewModel.signUp(email: email, password: password)
                
                
            }, label: {
                Text("Create Account")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50, alignment: .center)
                    .background(Color.blue)
            })
        }.padding()
        Spacer()
            //.navigationTitle("Create Account")
    }
    //.navigationTitle("Create Account")
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
