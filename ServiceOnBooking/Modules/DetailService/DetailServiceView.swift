//
//  DetailServiceView.swift
//  ServiceOnBooking
//
//  Created by Максим Чесников on 25.12.2021.
//

import SwiftUI
import CoreData

struct DetailServiceView: View {
    var service: Service
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 16)
                VStack(alignment: .leading) {
                    Text(service.name ?? "Cosmetology")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .padding(.bottom)
            Form {
                Section("Клиенты") {
                    if let users = service.ofUser, let array = Array(users) as? [User] {
                        ForEach(array) { user in
                            NavigationLink {
                                DetailUserView(user: user)
                                
                            } label: {
                                Text("\(user.name ?? "") \(user.surname ?? "")")
                            }
                        }
                        
                    }
                }
                
            }
        }
        .navigationTitle("Информация о профиле")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailServiceView_Previews: PreviewProvider {
    static var previews: some View {
        DetailServiceView(service: Service(context: PersistenceController.previewServices.container.viewContext))
    }
}
