//
//  UserStatView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/23/23.
//

import SwiftUI

struct UserStatView: View {
    
    let value: Int
    let title: String
    
    var body: some View {
        HStack {
            Text("\(value)")
                .font(.footnote)
                .fontWeight(.semibold)
            Text(title).font(.footnote)
        }
        .opacity(value == 0 ? 0.5 : 1.0)
        .frame(width: 100)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 3, title: "Pictures Shared")
    }
}
