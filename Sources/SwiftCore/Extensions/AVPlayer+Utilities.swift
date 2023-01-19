//
//  AVPlayer+Utilities.swift
//  SwiftCore
//
//  Created by Stefan Klein Nulent on 10/12/2022.
//

import Foundation
import AVFoundation

extension AVPlayer {
    
    // MARK: - Properties
    
    public var currentTimeDuration: Duration {
        Duration.seconds(currentTime().seconds)
    }
    
    
    
    // MARK: - Functions
    
    public func seek(to duration: Duration) {
        seek(to: CMTime(seconds: Double(duration.components.seconds), preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
    }
}
