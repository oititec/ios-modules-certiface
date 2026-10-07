//
//  SaasCustomizationExample.swift
//  Example
//

import CertifaceSDK
import UIKit

enum SaasCustomizationExample {
    static func setDefaultAppearance(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let facetecCustomization = FacetecCustomization.builder().build()
        let fortfaceCustomization = FortfaceCustomization.builder().build()
        return setCustomization(facetecCustomization, fortfaceCustomization, in: builder)
    }

    static func setCustomAppearance(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let facetecCustomization = FacetecCustomization.builder()
            .setInstructionCustomization(customizeInstruction)
            .setCameraPermissionCustomization(customizeCameraPermission)
            .build()

        let fortfaceCustomization = FortfaceCustomization.builder()
            .setInstructionCustomization(customizeInstruction)
            .setCameraPermissionCustomization(customizeCameraPermission)
            .build()

        builder.setLoadingCustomization { loadingBuilder in
            loadingBuilder
                .setBackgroundColor(.brown)
                .setSpinnerColor(.red)
                .setSpinnerWidth(10.7)
                .setSpinnerScaleFactor(5)
        }

        return setCustomization(facetecCustomization, fortfaceCustomization, in: builder)
    }

    static func setCustomViews(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let facetecCustomization = FacetecCustomization.builder()
            .setCustomInstructionView(CustomInstructionViewImpl())
            .setCustomCameraPermissionView(CustomCameraPermissionViewImpl())
            .build()

        let fortfaceCustomization = FortfaceCustomization.builder()
            .setCustomInstructionView(CustomInstructionViewImpl())
            .setCustomCameraPermissionView(CustomCameraPermissionViewImpl())
            .build()

        builder.setCustomLoadingView(CustomLoadingViewImpl())

        return setCustomization(facetecCustomization, fortfaceCustomization, in: builder)
    }

    private static func setCustomization(
        _ facetecCustomization: FacetecCustomization,
        _ fortfaceCustomization: FortfaceCustomization,
        in builder: LivenessManagerOptions.Builder
    ) -> LivenessManagerOptions {
        builder
            .setFacetecCustomization(facetecCustomization)
            .setFortfaceCustomization(fortfaceCustomization)
            .build()
    }

    private static func customizeInstruction(
        in instructionBuilder: InstructionCustomizationBuilder
    ) -> InstructionCustomizationBuilder {
        instructionBuilder
            .setBackgroundColor(.purple)
            .setBackButtonIcon(UIImage(systemName: "trash") ?? UIImage())
            .setBackButtonIconColor(.red)
            .setBackButtonBackgroundColor(.green)
            .setBackButtonBorderColor(.white)
            .setContextImage(UIImage(systemName: "person") ?? UIImage())
            .setBottomSheetColor(.cyan)
            .setBottomSheetCornerRadius(10)
            .setTitle("Titulo aqui")
            .setTitleFont(.systemFont(ofSize: 30, weight: .bold))
            .setTitleColor(.brown)
            .setCaption("Subtitulo aqui")
            .setCaptionFont(.systemFont(ofSize: 20, weight: .regular))
            .setCaptionColor(.systemPink)
            .setFirstInstructionIcon(UIImage(systemName: "star") ?? UIImage())
            .setFirstInstructionTitle("Descrição do ambiente")
            .setFirstInstructionTitleFont(.systemFont(ofSize: 25, weight: .medium))
            .setFirstInstructionTitleColor(.darkGray)
            .setSecondInstructionIcon(UIImage(systemName: "house") ?? UIImage())
            .setSecondInstructionTitle("Descrição para uso de accessórios")
            .setSecondInstructionTitleFont(.systemFont(ofSize: 18, weight: .semibold))
            .setSecondInstructionTitleColor(.magenta)
            .setContinueButtonText("Iniciar")
            .setContinueButtonFont(.systemFont(ofSize: 24, weight: .thin))
            .setContinueButtonTextColor(.lightGray)
            .setContinueButtonBackgroundColor(.systemPink)
            .setContinueButtonBorderColor(.white)
    }

    private static func customizeCameraPermission(
        in cameraPermissionBuilder: CameraPermissionCustomizationBuilder
    ) -> CameraPermissionCustomizationBuilder {
        cameraPermissionBuilder
            .setBackgroundColor(.systemPink)
            .setBackButtonIcon(UIImage(named: "pencil"))
            .setBackButtonIconColor(.white)
            .setBackButtonBackgroundColor(.white)
            .setBackButtonBorderColor(.white)
            .setCameraImage(UIImage(named: "trash"))
            .setCameraImageColor(.cyan)
            .setTitle("Permissão de câmera customizada")
            .setTitleColor(.white)
            .setTitleFont(.systemFont(ofSize: 40, weight: .heavy))
            .setCaption("Descrição da permissão de câmera")
            .setCaptionColor(.purple)
            .setCaptionFont(.systemFont(ofSize: 30, weight: .ultraLight))
            .setCheckPermissionButtonText("Averiguar")
            .setCheckPermissionButtonTextFont(.systemFont(ofSize: 24, weight: .black))
            .setCheckPermissionButtonTextColor(.red)
            .setCheckPermissionButtonBackgroundColor(.blue)
            .setCheckPermissionButtonBorderColor(.white)
            .setBottomSheetColor(.green)
            .setBottomSheetCornerRadius(0)
            .setBottomSheetTitle("Hora de ir para os ajustes")
            .setBottomSheetTitleColor(.blue)
            .setBottomSheetTitleFont(.systemFont(ofSize: 30, weight: .light))
            .setBottomSheetCaption("Ou será que não?")
            .setBottomSheetCaptionColor(.orange)
            .setBottomSheetCaptionFont(.systemFont(ofSize: 25, weight: .bold))
            .setOpenSettingsButtonText("Pular para ajustes")
            .setOpenSettingsButtonTextFont(.systemFont(ofSize: 20, weight: .medium))
            .setOpenSettingsButtonTextColor(.red)
            .setOpenSettingsButtonBackgroundColor(.blue)
            .setOpenSettingsButtonBorderColor(.white)
            .setCloseButtonText("Fechar tudo")
            .setCloseButtonTextFont(.systemFont(ofSize: 22, weight: .regular))
            .setCloseButtonTextColor(.magenta)
            .setCloseButtonBackgroundColor(.cyan)
            .setCloseButtonBorderColor(.red)
    }
}
