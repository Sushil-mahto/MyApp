//
//  HomeUIView.swift
//  MyApp
//
//  Created by SUshil on 28/03/22.
//

import SwiftUI


let w11 = UIScreen.main.bounds.width
struct HomeUIView: View {
    
    
    
    @State var menu = false
    
    @State var num = 0
    var body: some View {
        
            ZStack(alignment: .top){
                
                
                if(num == 0){
                    MainPage()
                } else if(num == 1)
                {
                    MySettings()
                }
                
                SidePage(menu: $menu, num: $num)
                    .offset(x: menu ? 0:-w11)
                    .animation(.easeIn)
                
                HStack{
                    Image(systemName: "text.justify")
                        .font(.largeTitle)
                        .foregroundColor(Color.black)
                        .onTapGesture {
                            menu.toggle()
                        }
                    
                    
                    Spacer()
                }.offset(y:menu ? -100:0)
                    .padding(.top,40)
                    .padding(.leading,10)
                
            }
        }
    }

struct MainPage:View {
    
   
    var body: some View{
        
        ZStack{
            Color.yellow.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 14.0) {
                Text("Main Page")
                
            }
            
           
        }
    }
}

struct MySettings:View {
    
   
    var body: some View{
        
        ZStack{
            Color.red.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 14.0) {
                Text("Settings")
                    .font(.title)
                    .foregroundColor(Color.white)
              
                    
            }
            
           
        }
    }
}

struct SidePage:View {
    @EnvironmentObject var viewModel:AppViewModel
    @Binding var menu:Bool
    
    @Binding var num:Int
    var body: some View{
        
        ZStack(alignment: .leading){
            Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 0.03561775258)).edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.trailing,20)
                        .onTapGesture {
                            menu.toggle()
                        }
                }
                .padding(.top,40)
                
                HStack{
                    Image(systemName:"house.fill")
                        .foregroundColor(Color.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text("Home")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                    Spacer()
                }.padding(.leading,10)
                .onTapGesture {
                    num = 0
                    menu.toggle()
                }
                
                HStack{
                    Image(systemName:"gearshape.fill")
                        .foregroundColor(Color.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text("Settings")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                    Spacer()
                }.padding(.leading,10)
                .padding(.top,4)
                .onTapGesture {
                    num = 1
                    menu.toggle()
                }
                
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Text("SignOut")
                        .foregroundColor(.blue)
                })
                
               
                Spacer()
                
            }.frame(width: w11/1.4,height: UIScreen.main.bounds.height, alignment: .center)
            .background(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
           
        }
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUIView()
    }
}
