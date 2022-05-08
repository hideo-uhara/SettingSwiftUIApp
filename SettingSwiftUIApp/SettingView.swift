//
// SettingView.swift
//

import SwiftUI

struct Accuracy: Identifiable {
	var id: Int
	var text: Text
}

struct SettingView: View {
	let lang: String = NSLocalizedString("lang", comment: "")
	let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
	let accuracyList: [Accuracy] = [
		Accuracy(id: 0, text: Text("Best For Navigation")),
		Accuracy(id: 1, text: Text("Best")),
		Accuracy(id: 2, text: Text("10m")),
		Accuracy(id: 3, text: Text("100m")),
		Accuracy(id: 4, text: Text("1km")),
		Accuracy(id: 5, text: Text("3km")),
	]
	
	@AppStorage("desiredAccuracy") var desiredAccuracy: Int = 2
	@AppStorage("sw1") var sw1: Bool = false
	@AppStorage("sw2") var sw2: Bool = false
	
	var body: some View {
		NavigationView {
			List {
				Section(header: Text("Switch")) {
					Toggle(isOn: self.$sw1) {
						Text("SW1")
					}
					.toggleStyle(SwitchToggleStyle())
					
					Toggle(isOn: self.$sw2) {
						Text("SW2")
					}
					.toggleStyle(SwitchToggleStyle())
				}
				
				Section(header: Text("Accuracy")) {
					ForEach(self.accuracyList) { item in
						HStack {
							Button(action: {
								self.desiredAccuracy = item.id
							}) {
								item.text
									.foregroundColor(.primary)
							}
							if self.desiredAccuracy == item.id {
								Spacer()
								Image(systemName: "checkmark")
									.font(Font.system(.body).bold())
									.foregroundColor(.accentColor)
							}
						}
					}
				}
				
				Section(header: Text("Others")) {
					Link(destination: URL(string:"https://hideo-uhara.github.io/homepage/GPSLoggerS/support.html")!) {
						Text("Support Page")
					}
					.foregroundColor(.primary)
					Link(destination: URL(string:"https://apps.apple.com/us/app/gpsloggers-track/id1515199137?l=\(self.lang)&ls=1")!) {
						Text("GPSLoggerS Track(Mac App Store)")
					}
					.foregroundColor(.primary)
				}
				
				Section(header: Text("Version")) {
					Text(self.version)
				}
			}
			.listStyle(InsetGroupedListStyle())
			.navigationBarTitle(Text("Setting"), displayMode: .inline)
		}
		.navigationViewStyle(.stack)
	}
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			SettingView()
			SettingView()
				.preferredColorScheme(.dark)
			SettingView()
				.previewDevice("iPhone 11")
			SettingView()
				.previewDevice("iPhone 11")
				.environment(\.locale, .init(identifier: "ja"))
		}
    }
}
