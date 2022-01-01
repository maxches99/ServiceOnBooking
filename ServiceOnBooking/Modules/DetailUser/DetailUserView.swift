//
//  DetailUserView.swift
//  ServiceOnBooking
//
//  Created by Максим Чесников on 20.12.2021.
//

import SwiftUI
import CoreData

struct DetailUserView: View {
    
    var user: User
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 16)
                VStack(alignment: .leading) {
                    Text(user.name ?? "Max")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(user.family ?? "Chesnikov")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                Spacer()
                if let imageData = user.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                Spacer()
                    .frame(width: 16)
            }
            .padding(.bottom)
            Form {
                Section("Услуги") {
                    if let services = user.ofService, let array = Array(services) as? [Service] {
                        ForEach(array) { service in
                            NavigationLink {
                                DetailServiceView(service: service)
                                
                            } label: {
                                Text("\(service.name ?? "")")
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

struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailUserView(user: User(context: PersistenceController.preview.container.viewContext))
    }
}
