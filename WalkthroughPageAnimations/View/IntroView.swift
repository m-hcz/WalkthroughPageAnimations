//
//  IntroView.swift
//  WalkthroughPageAnimations
//
//  Created by M H on 16/10/2022.
//

import SwiftUI

struct IntroView: View {
	
	@State var showScreens:Bool = false
	@State var currentIndex: Int = 0
	
    var body: some View {
		ZStack {
			Color("BG").ignoresSafeArea()
			
			IntroScreen()
				
			WalkThroughScreens()
			
			NavBar()
		}
		.animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showScreens)
    }
	@ViewBuilder func WalkThroughScreens() -> some View {
		GeometryReader {
			let isLast:Bool = currentIndex == intros.count
			let size = $0.size
			
			ZStack {
				ForEach(intros.indices, id: \.self) { index in
					ScreenView(size: size, index: index)
				}
				WelcomeScreen(size: size, index: intros.count)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.overlay(alignment: .bottom) {
				ZStack {
					Image(systemName: "chevron.right")
						.font(.title3)
						.fontWeight(.semibold)
						.scaleEffect(!isLast ? 1 : 0.001)
						.opacity(!isLast ? 1 : 0)
					
					HStack {
						Text("Sign up")
							.font(.title3)
							.foregroundColor(.white)
							.frame(maxWidth: .infinity, alignment: .leading)
						
						Image(systemName: "arrow.right")
							.font(.title3)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
					.padding(.horizontal, 15)
					.scaleEffect(isLast ? 1 : 0.001)
					.frame(height: isLast ? nil : 0)
					.opacity(isLast ? 1 : 0)
				}
				
				.frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
					.foregroundColor(.white)
					.background {
						RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
							.fill(.black)
					}
					.onTapGesture {
						currentIndex += 1
					}
					.offset(y: isLast ? -40 : -65)
					.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
			}
			.overlay(alignment: .bottom ,content: {
				let isLast = currentIndex == intros.count
				
				HStack(spacing: 5) {
					Text("Already have an accout?")
						.font(.callout)
						.foregroundColor(.gray)
					
					Button("Login") {
						
					}
					.font(.callout)
					.fontWeight(.black)
					.foregroundColor(.black)
				}
				.offset(y: isLast ? -12 : 100)
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
			})
			.offset(y: showScreens ? 0 : size.height)
		}
	}
	@ViewBuilder func ScreenView(size: CGSize, index: Int) -> some View  {
		let intro = intros[index]
		
		
		VStack(spacing: 10) {
			Text(intro.title)
				.font(.title)
				.fontWeight(.black)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
			Text(dummyText)
				.font(.headline)
				.fontWeight(.medium)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 30)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1), value: currentIndex)
			Image(intro.imageName)
				.resizable()
				.scaledToFit()
				.frame(height: 250, alignment: .top)
				.padding(.horizontal, 30)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
			
		}
	}
	@ViewBuilder func WelcomeScreen(size: CGSize, index: Int) -> some View  {

		VStack(spacing: 10) {
			
			Image("Welcome")
				.resizable()
				.scaledToFit()
				.frame(height: 250, alignment: .top)
				.padding(.horizontal, 30)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
			Text("Welcome")
				.font(.title)
				.fontWeight(.black)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
			Text("Lorem Ipsum is simply dummy text")
				.font(.headline)
				.fontWeight(.medium)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 30)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1), value: currentIndex)
		
			
		}
	}
	
	@ViewBuilder func NavBar() -> some View {
		let isLast:Bool = currentIndex == intros.count
		
		HStack {
			Button {
				if currentIndex > 0 {
					currentIndex -= 1
				} else {
					showScreens.toggle()
				}
			} label: {
				Image(systemName: "chevron.left")
					.font(.title3)
					.fontWeight(.semibold)
					.foregroundColor(.black)
			}
			
			Spacer()
			
			Button("Skip") {
				currentIndex = intros.count
			}
			.font(.headline)
			.fontWeight(.medium)
			.foregroundColor(Color.black)
			.opacity(isLast ? 0 : 1)
			.animation(.easeInOut, value: isLast)

		}
		.padding(.horizontal, 15)
		.padding(.top, 10)
		.frame(maxHeight: .infinity, alignment: .top)
		.offset(y: showScreens ? 0 : -120)
	}
	
	@ViewBuilder func IntroScreen() -> some View {
		GeometryReader {
			let size = $0.size
			
			VStack(spacing: 10) {
				Image("Intro")
					.resizable()
					.scaledToFit()
					.frame(width: size.width, height: size.height / 2)
				
				Text("Clearhead")
					.font(.title)
					.fontWeight(.black)
				Text(dummyText)
					.font(.headline)
					.fontWeight(.medium)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 30)
					.padding(.vertical, 14)
				Text("Let's Begin")
					.font(.headline)
					.fontWeight(.medium)
					.padding(.horizontal, 40)
					.padding(.vertical, 14)
					.foregroundColor(.white)
					.background(
						Capsule()
							.fill(.black)
					)
					.onTapGesture {
						showScreens.toggle()
					}
					.padding(.top, 30)
					
				
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
			.offset(y: showScreens ? -size.height : 0)
			
		}
		.ignoresSafeArea()
	}
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
