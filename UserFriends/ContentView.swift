//
//  ContentView.swift
//  UserFriends
//
//  Created by Dmitry Reshetnik on 27.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
//    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink(destination: UserDetailView(selectedUser: user)) {
                    VStack(alignment: .leading) {
                        Text(user.name ?? "Unknown")
                            .font(.headline)
                        Text(user.email ?? "Unknown")
                            .font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing: Button(action: {
                self.loadData()
            }) {
                Image(systemName: "square.and.arrow.down")
            })
        }
    }
    
    func loadData() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("\(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve context")
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = self.moc
            if let _ = try? decoder.decode([User].self, from: data) {
                try? self.moc.save()
            } else {
                print("\(error?.localizedDescription ?? "Invalid response from server")")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
