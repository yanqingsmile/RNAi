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
    var isSaved: Bool {
        if let savedGeneNames = UserDefaults.standard.object(forKey: ConstantString.userDefaultsKey) as? [String] {
            return savedGeneNames.contains(geneName)
        }
        return false
    }
    
    init(geneName: String, accessionNumber: String, sequences: [String], efficiency: [Double]) {
        self.geneName = geneName
        self.accessionNumber = accessionNumber
        self.sequences = sequences
        self.efficiency = efficiency
    }
    
    init(dataArray: NSArray) {
        var privateSequences = [String]()
        var privateEfficiency = [Double]()
        let firstItem = dataArray[0] as! Dictionary<String, String>
        self.geneName = firstItem["siRNA Pool Name"]!
        self.accessionNumber = firstItem["NCBI Accession Number"]!
        for item in dataArray {
            let dictionary = item as! Dictionary<String, String>
            privateSequences.append(dictionary["Sense Seq"]!)
            privateEfficiency.append(Double(dictionary["Efficiency"] ?? "0")!)
        }
        self.sequences = privateSequences
        self.efficiency = privateEfficiency
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
