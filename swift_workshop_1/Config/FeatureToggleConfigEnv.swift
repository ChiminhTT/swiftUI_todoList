//
//  FeatureToggleConfigEnv.swift
//  swift_workshop_1
//
//  Created by Maxence on 9/23/21.
//

import SwiftUI

struct FeatureToggleConfigEnv: EnvironmentKey {
    static var defaultValue: Binding<FeatureToggleConfig> = .constant(
        FeatureToggleConfig(
            isDeleteButtonActive: false,
            isEditModeActive: false
        )
    )
}

extension EnvironmentValues {
    var featureToggleConfig: Binding<FeatureToggleConfig> {
        get { self[FeatureToggleConfigEnv.self] }
        set { self[FeatureToggleConfigEnv.self] = newValue }
    }
}

struct FeatureToggleConfig {
    var isDeleteButtonActive: Bool
    var isEditModeActive: Bool
}
