//
//  ContentView.swift
//  IntroSwiftUI
//
//  Created by Daniel Liao on 1/14/25.
//

import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let location: String?
    let description: String?
    let hostedOrganization: String?
    let additionalDetail: String?
}

struct ContentView: View {
    @State private var events: [Event] = []

    var body: some View {
        VStack {
            Text("Welcome to CSE 335")
                .font(.title)
                .padding()

            Spacer()

            if #available(iOS 14.0, *) {
                Link("VIEW DEMO IN ACTION!",
                     destination: URL(string: "https://youtu.be/dQw4w9WgXcQ?si=JibMEK5UUgaS0pqS")!)
            }

            Spacer().frame(height: 30)

            Button(action: {
                let projectFolder = "/Users/daniel/Desktop/CSE 335/IntroSwiftUI"
                events = processICSFiles(in: projectFolder)
            }) {
                Text("Load Events from .ics")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            List(events) { event in
                VStack(alignment: .leading) {
                    Text(event.title)
                        .font(.headline)
                    if let location = event.location {
                        Text("📍 Location: \(location)").font(.subheadline)
                    }
                    if let description = event.description {
                        Text("📝 \(description)").font(.subheadline)
                    }
                    if let host = event.hostedOrganization {
                        Text("🏢 Hosted by: \(host)").font(.subheadline)
                    }
                    if let detail = event.additionalDetail {
                        Text("🔍 Additional: \(detail)").font(.subheadline)
                    }
                }
                .padding(5)
            }
        }
        .padding()
    }
}

func fetchICSFiles(from directory: String) -> [String] {
    let fileManager = FileManager.default
    do {
        let files = try fileManager.contentsOfDirectory(atPath: directory)
        return files.filter { $0.hasSuffix(".ics") }
    } catch {
        print("Error reading directory: \(error)")
        return []
    }
}

func parseICSFile(at path: String) -> [Event] {
    do {
        let content = try String(contentsOfFile: path, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
        
        var events: [Event] = []
        var title: String?
        var location: String?
        var description: String?
        var hostedOrganization: String?
        var additionalDetail: String?
        
        for line in lines {
            if line.hasPrefix("BEGIN:VEVENT") {
                title = nil
                location = nil
                description = nil
                hostedOrganization = nil
                additionalDetail = nil
            } else if line.hasPrefix("SUMMARY:") {
                title = line.replacingOccurrences(of: "SUMMARY:", with: "").trimmingCharacters(in: .whitespaces)
            } else if line.hasPrefix("LOCATION:") {
                location = line.replacingOccurrences(of: "LOCATION:", with: "").trimmingCharacters(in: .whitespaces)
            } else if line.hasPrefix("DESCRIPTION:") {
                description = line.replacingOccurrences(of: "DESCRIPTION:", with: "").trimmingCharacters(in: .whitespaces)
            } else if line.hasPrefix("ORGANIZER;CN=") {
                hostedOrganization = line.components(separatedBy: ":").last?.trimmingCharacters(in: .whitespaces)
            } else if line.hasPrefix("X-DETAIL:") {
                additionalDetail = line.replacingOccurrences(of: "X-DETAIL:", with: "").trimmingCharacters(in: .whitespaces)
            } else if line.hasPrefix("END:VEVENT") {
                if let eventTitle = title {
                    events.append(Event(title: eventTitle, location: location, description: description, hostedOrganization: hostedOrganization, additionalDetail: additionalDetail))
                }
            }
        }
        
        return events
    } catch {
        print("Error reading .ics: \(error)")
        return []
    }
}


func processICSFiles(in directory: String) -> [Event] {
    let files = fetchICSFiles(from: directory)
    var events: [Event] = []
    
    for file in files {
        let filePath = "\(directory)/\(file)"
        events.append(contentsOf: parseICSFile(at: filePath))
    }

    print("Final loaded events:", events.map { $0.title })
    return events
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
