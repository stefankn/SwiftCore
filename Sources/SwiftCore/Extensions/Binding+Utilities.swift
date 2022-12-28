//
//  Binding+Utilities.swift
//  
//
//  Created by Stefan Klein Nulent on 11/12/2022.
//

import SwiftUI

public prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
