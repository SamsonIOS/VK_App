// Alamofire.swift
// Copyright © RoadMap. All rights reserved.

import Dispatch
import Foundation
#if canImport(FoundationNetworking)
@_exported import FoundationNetworking
#endif

// Enforce minimum Swift version for all platforms and build systems.
#if swift(<5.3)
#error("Alamofire doesn't support Swift versions below 5.3.")
#endif

/// Reference to `Session.default` for quick bootstrapping and examples.
public let AF = Session.default

/// Current Alamofire version. Necessary since SPM doesn't use dynamic libraries. Plus this will be more accurate.
let version = "5.6.4"
