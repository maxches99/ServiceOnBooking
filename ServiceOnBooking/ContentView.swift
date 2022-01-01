//
//  ContentView.swift
//  ServiceOnBooking
//
//  Created by Максим Чесников on 19.12.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var showAlertDark = false
    @State var showAlert = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<User>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var services: FetchedResults<Service>
    
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    List {
                        Section("Клиенты") {
                            ForEach(items) { item in
                                NavigationLink {
                                    if let text = item.ofService, let array = Array(text) as? [Service], let strings = array.compactMap { return $0.name} {
                                        VStack {
                                            DetailUserView(user: item)
                                        }
                                        
                                    }
                                    
                                } label: {
                                    Text("\(item.name ?? "") \(item.family ?? "")")
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        Section("Услуги") {
                            ForEach(services) { service in
                                NavigationLink {
                                    DetailServiceView(service: service)
                                    
                                } label: {
                                    Text("\(service.name ?? "")")
                                }
                            }
                            .onDelete(perform: deleteService)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink {
                                RegistrationNewClient() {
                                    addItem(name: $0, family: $1, surname: $2, services: $3, image: $4)
                                }
                            } label: {
                                Label("Add Item", systemImage: "person")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Menu("Options") {
                                Button(action: addService) {
                                    Text("Registration new service")
                                }
                            }
                            
                        }
                    }
                    .navigationTitle("Общая база")
                    .navigationViewStyle(StackNavigationViewStyle())
                    Text("Select an item")
                }
            }
            
            
        }
    }
    
    private func addItem(name: String, family: String, surname: String, services: [Service], image: UIImage) {
        let fetchRequest: NSFetchRequest<Service> = Service.fetchRequest()
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest) as? [Service]
        withAnimation {
            let newItem = User(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = name
            newItem.family = family
            newItem.surname = surname
            newItem.ofService = NSSet(array: services)
            newItem.image = image.pngData()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteService(offsets: IndexSet) {
        withAnimation {
            offsets.map { services[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addService() {
        withAnimation {
            let newItem = Service(context: viewContext)
            newItem.name = "Косметология \(services.count)"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension String: Identifiable {
    public var id: UUID {
        UUID()
    }
}
