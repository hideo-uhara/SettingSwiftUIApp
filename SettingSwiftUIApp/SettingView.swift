//
// SettingView.swift
//

import SwiftUI

struct Accuracy: Identifiable {
	var id: Int
	var text: Text
}

struct SettingView: View {
	
	var body: some View {
		if #available(iOS 16.0, *) {
			NavigationStack {
				SettingContentView()
				.listStyle(InsetGroupedListStyle())
				.navigationTitle(Text("Settings"))
				.navigationBarTitleDisplayMode(.inline)
			}
		} else {
			NavigationView {
				SettingContentView()
				.listStyle(InsetGroupedListStyle())
				.navigationBarTitle(Text("Settings"), displayMode: .inline)
			}
			.navigationViewStyle(.stack) // iPadで必要
		}
	}
}

struct SettingContentView: View {
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
		List {
			Section {
				Toggle(isOn: self.$sw1) {
					Text("SW1")
				}
				.toggleStyle(SwitchToggleStyle())
				
				Toggle(isOn: self.$sw2) {
					Text("SW2")
				}
				.toggleStyle(SwitchToggleStyle())
			} header: {
				Text("Switch")
			}
			
			Section {
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
			} header: {
				Text("Accuracy")
			}
			
			Section {
				Link(destination: URL(string:"https://hideo-uhara.github.io/homepage/GPSLoggerS/support.html")!) {
					Text("Support Page")
				}
				.foregroundColor(.primary)
				Link(destination: URL(string:"https://apps.apple.com/us/app/gpsloggers-track/id1515199137?l=\(self.lang)&ls=1")!) {
					Text("GPSLoggerS Track(Mac App Store)")
				}
				.foregroundColor(.primary)
			} header: {
				Text("Others")
			}
			
			Section {
				Text(self.version)
			} header: {
				Text("Version")
			}


		}
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
