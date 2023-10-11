//
//  SignInView.swift
//  Acheron2023
//
//  Created by Albert Zhou on 10/9/23.
//

import SwiftUI
import LocalAuthentication

struct SignInView: View {
    @State private var isUnlocked=false
    @State private var failed = ""
    
    
    var body: some View {
        if isUnlocked{
            IconView()
            
        }
        else{
            VStack{
                Text("Welcome").font(.largeTitle)
                Button(action:authenticate){
                    Label("Login with FaceID", systemImage: "faceID")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.white))
                }
                
                Text(failed)
                    .padding()
                //     .opacity(op)
            }
        }
    }
    
    private func authenticate(){
        var error: NSError?
        let laContext=LAContext()
        laContext.localizedFallbackTitle="Please use Passcode"
        let reason = "Need access to authenticate"
        if laContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &error){
            // bioType=LABiometryType.faceID?"Face ID":"TouchID"
            let biometricType = laContext.biometryType==LABiometryType.faceID//?"Face ID":"Touch ID"
            
            
            laContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication,localizedReason:reason) {
                (success,evaluationError) in
                DispatchQueue.main.async{
                    if success{
                        isUnlocked=true
                        failed=""
                    } else{
                        if let errorObj=evaluationError{
                            failed=getErrorDescription(errorCode:errorObj._code)
                        }
                    }
                }
            }
        }else{
            print("no biometrucs")
        }
    }
    
    
    func getErrorDescription(errorCode:Int)->String{
        switch errorCode{
        case LAError.authenticationFailed.rawValue:
            return "Authentication was not successful, because user failed to provide valid credentials"
        case LAError.authenticationFailed.rawValue:
            return "Authentication was canceled by application"
        case LAError.authenticationFailed.rawValue:
            return "LAContext passed to this call has been previously invalidated"
        case LAError.authenticationFailed.rawValue:
            return "Authentication failed, because it would require showing UI which has been forbidden by using interationNotAllowed property"
        case LAError.authenticationFailed.rawValue:
            return "Authentication could not start, because passcode is not set on device"
        case LAError.authenticationFailed.rawValue:
            return "Authentication was canceled by system"
        case LAError.authenticationFailed.rawValue:
            return "Authentication was canceled by user"
        case LAError.authenticationFailed.rawValue:
            return "Authentication was canceled, because the user tapped the fallback button(Enter Password)"
        default:
            return "Error code \(errorCode) not found"
        }
    }
}
#Preview {
    SignInView()
}
