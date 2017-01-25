//
//  SiRNA.swift
//  RNAi
//
//  Created by Vivian Liu on 1/12/17.
//  Copyright © 2017 Vivian Liu. All rights reserved.
//

import Foundation

class Gene : NSObject {
    let geneName: String
    let accessionNumber: String
    let catalogNumber: String
    let sequences: [String]
    
    var isSaved: Bool {
        if let savedGeneNames = UserDefaults.standard.object(forKey: ConstantString.userDefaultsKey) as? [String] {
            return savedGeneNames.contains(geneName)
        }
        return false
    }
    
    init(geneName: String, accessionNumber: String, catalogNumber: String, sequences: [String]) {
        self.geneName = geneName
        self.accessionNumber = accessionNumber
        self.catalogNumber = catalogNumber
        self.sequences = sequences
    }
    
    init(dataArray: NSArray) {
        var privateSequences = [String]()
        let firstItem = dataArray[0] as! Dictionary<String, String>
        self.geneName = firstItem["siRNA Pool Name"]!
        self.accessionNumber = firstItem["NCBI Accession Number"]!
        self.catalogNumber = firstItem["Catalog number"]!
        for item in dataArray {
            let dictionary = item as! Dictionary<String, String>
            privateSequences.append(dictionary["Sense Seq"]!)
        }
        self.sequences = privateSequences
        
    }
    override var description : String {
        var siRNAInformation = "Antisense Strand" + "\n"
        var totalDescription = ""
        for i in 0...sequences.count - 1 {
            siRNAInformation +=  "\(sequences[i])" + "\n"
        }
        totalDescription = "Gene " + "\t" + geneName + "\n" + "Accession Number " + "\t" + accessionNumber + "\n" + siRNAInformation
        return totalDescription
    }
}
