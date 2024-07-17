import Foundation
import Hitch
import Spanker
import Chronometer
import ArgumentParser
import Sextant

struct jsonpath: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Perform JSONPath queries")
    
    @Argument(help: "JSONPath query")
    var query: String
    
    @Argument(help: "input file")
    var input: String
    
    @Flag(name: .customShort("l"),
          help: "Output the path to the results instead of the results themselves")
    var printPaths: Bool = false
    
    @Flag(name: .customShort("p"),
          help: "Pretty print the result JSON")
    var printPretty: Bool = false
    
    mutating func run() throws {
        
        guard let jsonData = Hitch(contentsOfFile: input) else {
            throw CleanExit.message("Failed to read file \(input)")
        }
        
        let queries: [Hitch] = [
            Hitch(string: query)
        ]
        
        jsonData.parsed { root in
            guard let root = root else { fatalError("Failed to parse \(input)") }
            
            if printPaths {
                if let results = root.query(paths: queries) {
                    let combined = ^[]
                    for result in results {
                        combined.append(value: result)
                    }
                    print(combined.toHitch(pretty: printPretty))
                }
            } else {
                if let results = root.query(elements: queries) {
                    let combined = ^[]
                    for result in results {
                        combined.append(value: result)
                    }
                    print(combined.toHitch(pretty: printPretty))
                }
            }
        }
    }
}

jsonpath.main()
