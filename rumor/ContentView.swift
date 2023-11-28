//
//  ContentView.swift
//  rumor
//
//  Created by Albert Zhou on 11/19/23.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @AppStorage("storedName")
    private var storedName:String=""{
        didSet{
            userName=storedName
        }
    }
    @AppStorage("storedEmail")
    private var storedEmail:String=""{
        didSet{
            userEmail=storedEmail
        }
    }
    
    @AppStorage("UserID")
    private var userID:String=""
    @State
    private var userName:String=""
    @State
    private var userEmail:String=""
    var body: some View {
            
    VStack{
        // Color.blue
        if userName.isEmpty{
            Image("figlog")
                .resizable()
                .aspectRatio(contentMode: .fit)
            .frame(width:70, height: 70)
            SignInWithAppleButton(.signIn, onRequest:onRequest, onCompletion:onCompletion).signInWithAppleButtonStyle(.black)
                .frame(width:300,height:50)
        } else{
            ToggleView(userName:userName)
            
            }
    }
            .onAppear(perform:onAppear)
      
    }
    
    private func onRequest(_ request: ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
    }
    
    private func onCompletion(_ result:Result<ASAuthorization,Error>){
        switch result{
        case .success(let authResults):
            guard let credential = authResults.credential
                as? ASAuthorizationAppleIDCredential
            else {return}
            storedName = credential.fullName?.givenName ?? ""
            storedEmail = credential.email ?? ""
            userID = credential.user
        case .failure(let error):
            print("Authorization failed: " ,error.localizedDescription)
        }
    }
    
    private func onAppear(){
        guard !userID.isEmpty else{
            userName=""
            userEmail=""
            return
        }
        ASAuthorizationAppleIDProvider()
            .getCredentialState(forUserID: userID) { state, _ in
                DispatchQueue.main.async{
                    if case .authorized = state{
                        userName = storedName
                        userEmail = storedEmail
                    } else{
                        userID = ""
                    }
                }
            }
    }
}

#Preview {
    ContentView()
        .environmentObject(posts())
}
