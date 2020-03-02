//
//  ContentView.swift
//  UserFriends
//
//  Created by Dmitry Reshetnik on 27.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.self.id) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                    Text(user.email)
                }
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing: Button(action: {
                self.loadData()
            }) {
                Image(systemName: "plus")
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
            
            if let decoded = try? JSONDecoder().decode([User].self, from: data) {
                self.users = decoded
                print("\(decoded.count) \(decoded[0].friends[0].name)")
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
