//
//  DataModle.swift
//  MincraftDicFazitFinal
//
//  Created by Dan Li on 28.08.18.
//  Copyright © 2018 DanStenLee. All rights reserved.
//

import Foundation

struct DataModle{
    
    var name:String
    var info:String
    
    static func readFromBundle()->[DataModle]{
        
        var data=[DataModle]()
        
        if let path = Bundle.main.path(forResource: "minecraft", ofType: "txt")
        {
            do{
                
                let txt = try String(contentsOfFile: path, encoding: .utf8)
                let lines = txt.characters.split(){$0 == "\n"}.map{String($0)}
            for line in lines {
                let colums = line.characters.split() {$0=="\t"}.map{String($0)}
                
                if colums.count==2{
                    let name = colums[0]
                    let info = colums[1]
                    data.append(DataModle(name: name, info: info))
                    }
                }
                }catch _ {}
        }
        
    return data
    }
    
}
