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
    let sequences: [String]
    let efficiency: [Double]
    var isSaved = false
    
    init(geneName: String, accessionNumber: String, sequences: [String], efficiency: [Double]) {
        self.geneName = geneName
        self.accessionNumber = accessionNumber
        self.sequences = sequences
        self.efficiency = efficiency
    }
    
    override var description : String {
        var siRNAInformation = "Antisense" + "\t\t\t" + "Efficiency" + "\n"
        var totalDescription = ""
        for i in 0...sequences.count - 1 {
            siRNAInformation +=  "\(sequences[i])" + "\t" + "\(efficiency[i])" + "\n"
        }
        totalDescription = "Gene " + "\t" + geneName + "\n" + "Accession Number " + "\t" + accessionNumber + "\n" + siRNAInformation
        return totalDescription
    }
}
