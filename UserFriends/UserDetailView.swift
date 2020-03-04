//
//  UserDetailView.swift
//  UserFriends
//
//  Created by Dmitry Reshetnik on 04.03.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        NavigationView {
            Form {
                Text("\(user.age)")
                Text(user.company)
                Text(user.email)
                Text(user.address)
                Text(user.about)
            }
            .navigationBarTitle(Text(user.name), displayMode: .inline)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User())
    }
}
