//
//  ContentView.swift
//  NanoChallenge6Clip
//
//  Created by Gabriel Rodrigues da Silva on 20/08/21.
//

import SwiftUI
import AppClip
import CoreLocation

struct ContentViewClip: View {
    
    @State var title: String = ""
    @State var category: String = ""
    @State var searchText : String = ""
    
    var body: some View {
        ZStack {
            Image("Fundo1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 102, height: 80)
                    .padding(.top, 35)
                    .padding(.bottom, -25)
                
                Text(title)
                    .font(.custom("NewYork-Black", size: 28))
                    .padding([.top], 30)
                    .padding(.bottom, -5)
                    .foregroundColor(.black)
                    
                ItensList(searchText: $searchText, selectedCategory: $category)
                    .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: respondToInvocation)
                
            }
        }
            .preferredColorScheme(.light)
    }
    
    func respondToInvocation(_ activity: NSUserActivity) {
        guard let incomingURL = activity.webpageURL else { return }
        guard let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else { return }
        guard let path = components.path else { return }
        
        if activity.activityType == NSUserActivityTypeBrowsingWeb {
            
            if path == "/candies" {
                title = "Candies"
                category = "Candies"
            }
            if path == "/plants" {
                title = "Plants"
                category = "Plants"
            }
        }
        
        // Physical Location
        guard let payload = activity.appClipActivationPayload else { return }
        guard let region = location(from: incomingURL) else { return }
        
        payload.confirmAcquired(in: region) { (inRegion, error) in
            guard let confirmationError = error as? APActivationPayloadError else {
                if inRegion && path.count < 2 {
                    title = "Jokes"
                    category = "Jokes"
                }
                
                return
            }
            
            if confirmationError.code == .doesNotMatch {
                print(confirmationError.code)
            } else {
                print("Denied")
            }
        }
    }
    
    private func location(from url: URL) -> CLRegion? {
        let coordinates = CLLocationCoordinate2D(latitude: 28.47277, longitude: -81.47262)
        return CLCircularRegion(center: coordinates, radius: 500, identifier: "Hogsmeade")
    }
}


struct ContentViewClip_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewClip()
    }
}
