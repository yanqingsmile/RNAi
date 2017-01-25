//
//  Constants.swift
//  RNAi
//
//  Created by Vivian Liu on 1/19/17.
//  Copyright © 2017 Vivian Liu. All rights reserved.
//

import Foundation

struct CellIdentifier {
    static let masterGeneCellIdentifier = "GeneCellIdentifier"
    static let masterHeaderCellIdentifier = "MasterHeaderCellIdentifier"
    static let detailCellIdentifier = "siRNADetailIdentifier"
    static let detailHeaderCellIdentifier = "DetailHeaderCellIdentifier"
    static let savedCellIdentifier = "SavedCellIdentifier"
    static let savedHeaderIdentifier = "SavedHeaderCellIdentifier"
}

struct TextLabel {
    static let headerCellTextLabel = "Gene Name"
    static let headerCellDetailTextLabel = "Accession Number"
}

struct SegueIdentifier {
    static let showDetailFromMasterToDetail = "ShowDetailFromMaster"
    static let showDetailFromSavedToDetail = "showDetailFromSaved"
}

struct ConstantString {
    static let userDefaultsKey = "savedGeneNames"
    static let geneNCBIUrlPrefix = "https://www.ncbi.nlm.nih.gov/gene/?term="
    static let genomeRNAiURLPrefix = "http://genomernai.dkfz.de/v16/reagentdetails/"
    static let unSavedImageName = "emptyHeart"
    static let savedImageName = "filledHeart"
}

