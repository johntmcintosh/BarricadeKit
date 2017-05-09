//: Playground - noun: a place where people can play

import UIKit
import BarricadeKit


Barricade.setupWithInMemoreResponseStore()
Barricade.responseDelay = 1.0




let login = ResponseSet(requestName: "Login", evaluation: .closure { request, components in
    return components.path.hasSuffix("/api/login")
})
Barricade.register(set: login)


let registration = ResponseSet(requestName: "Register", evaluation: .suffix("/api/register"))
