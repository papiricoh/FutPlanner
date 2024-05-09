//
//  LogInView.swift
//  FutPlanner
//
//  Created by Pablo Rico alvarez on 15/1/24.
//

import SwiftUI

struct LogInView: View {
    var onLoginSuccess: () -> Void
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var loading: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Image("FutAppIcon").resizable().frame(width: 100, height: 100).clipShape(Rectangle()).cornerRadius(20)
                Text("Bienvenido a FutPlanner")
                VStack {
                    ZStack (alignment: .leading) {
                        TextField("", text: $username).autocapitalization(.none).padding().clipShape(Rectangle()).background(Color("FutGreen")).foregroundColor(.white).cornerRadius(8).padding(.horizontal)
                        
                        if username.isEmpty {
                            Text("Usuario").foregroundStyle(Color.gray).padding(.leading, 34).allowsHitTesting(false)
                        }
                        
                    }
                    ZStack (alignment: .leading) {
                        SecureField("", text: $password).padding().clipShape(Rectangle()).background(Color("FutGreen")).foregroundColor(.white).cornerRadius(8).padding(.horizontal)
                        
                        if password.isEmpty {
                            Text("Contraseña").foregroundStyle(Color.gray).padding(.leading, 34).allowsHitTesting(false)
                        }
                    }
                    
                    Button(action: login) {
                        Text("Iniciar Sesión")
                    }.padding().background(Color("FutGreenLight")).foregroundColor(.white).bold().clipShape(Rectangle()).cornerRadius(8)
                }
            }.padding(32).foregroundColor(.white).background(Color.futGreenDark).cornerRadius(20).padding()
        }.containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.green, .gray, .green]).opacity(0.6))
    }
    func login() {
        print("Intento de inicio de sesión con Usuario: \(username)")
        
        loading = true
        Task {
            do {
                try await fetchUser(username: username, password: password)
                if fTeam != nil {
                    let defaults = UserDefaults.standard
                    defaults.set(user?.username, forKey: "username")
                    defaults.set(user?.lastTokenKey, forKey: "token")
                    print(fTeam!)
                    onLoginSuccess()
                }
            } catch {
                print("Error en la solicitud: \(error.localizedDescription)")
            }
            loading = false
        }
    }
    
}

extension UITextField {
    func setPlaceholderColor(to color: UIColor) {
        let placeholderText = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.foregroundColor: color])
    }
}

#Preview {
    LogInView(onLoginSuccess: {
        //
    }, loading: .constant(false))
}
