//
//  Intro.swift
//  WalkthroughPageAnimations
//
//  Created by M H on 16/10/2022.
//

import Foundation

struct Intro: Identifiable {
	var id: String = UUID().uuidString
	var imageName: String
	var title: String
}

var intros: [Intro] = [
	.init(imageName: "Image 1", title: "Relax"),
	.init(imageName: "Image 2", title: "Care"),
	.init(imageName: "Image 3", title: "Mood Diary")
]


var dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."
