//
//  UserDetailView.swift
//  UserFriends
//
//  Created by Dmitry Reshetnik on 04.03.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI
import CoreData

struct UserDetailView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    let selectedUser: User

    var body: some View {
        Form {
            HStack {
                Text("Age:")
                    .font(.headline)
                Text("\(selectedUser.age ?? 0)")
            }
            HStack {
                Text("Company:")
                    .font(.headline)
                Text(selectedUser.company ?? "Unknown")
            }
            HStack {
                Text("Email:")
                    .font(.headline)
                Text(selectedUser.email ?? "Unknown")
            }
            HStack {
                Text("Registered:")
                    .font(.headline)
                Text(dateFormatter(selectedUser.registered) ?? "Unknown")
            }
            VStack(alignment: .leading) {
                Text("Address:")
                    .font(.headline)
                Text(selectedUser.address ?? "Unknown")
            }
            VStack(alignment: .leading) {
                Text("About:")
                    .font(.headline)
                Text(selectedUser.about ?? "Unknown")
            }
            Section(header: Text("Tags:").font(.headline)) {
                List(selectedUser.tags ?? [], id: \.self) { tag in
                    Text(tag)
                }
            }
            Section(header: Text("Friends:").font(.headline)) {
                List(selectedUser.friends ?? [], id: \.self.id) { friend in
                    NavigationLink(destination: UserDetailView(selectedUser: self.users.first(where: { $0.id == friend.id })!)) {
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationBarTitle(selectedUser.name)
    }

    func dateFormatter(_ string: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: string)!
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(selectedUser: User())
    }
}
