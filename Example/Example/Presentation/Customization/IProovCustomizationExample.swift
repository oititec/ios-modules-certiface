//
//  IProovCustomizationExample.swift
//  Example
//
//  Created by Vitor Souza on 17/10/25.
//

import CertifaceSDK
import UIKit

enum IProovCustomizationExample {
    static func setDefaultAppearance(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let customization = IProovCustomization.builder().build()
        return setCustomization(customization, in: builder)
    }

    static func setCustomAppearance(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let customization = IProovCustomization.builder()
            .setInstructionCustomization { instructionBuilder in
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
            .setCameraPermissionCustomization { cameraPermissionBuilder in
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
            .setLivenessCustomization { livenessBuilder in
                livenessBuilder
                    .setCloseButtonImage(UIImage(named: "pencil") ?? UIImage())
                    .setCloseButtonImageColor(.magenta)
                    .setTitle("HEADER")
                    .setTitleTextColor(.yellow)
                    .setTitleBackgroundColor(.blue)
                    .setPromptTextColor(.green)
                    .setPromptBackgroundColor(.white)
                    .setPromptRoundedCornersEnabled(false)
                    .setBackgroundColor(.red)
                    .setLogoImage(UIImage(named: "doc.text.magnifyingglass") ?? UIImage())
                    .setFilterStyle(.lineDrawing(.vibrant))
                    .setFilterLineDrawingForegroundColor(.purple)
                    .setFilterLineDrawingBackgroundColor(.orange)
                    .setLAOvalStrokeCapturingColor(.cyan)
                    .setLAOvalStrokeCompletedColor(.systemPink)
                    .setGPAOvalStrokeNotReadyColor(.yellow)
                    .setGPAOvalStrokeReadyColor(.blue)
                    .setTimeout(20)
            }
            .setLoadingCustomization { loadingBuilder in
                loadingBuilder
                    .setBackgroundColor(.brown)
                    .setSpinnerColor(.red)
                    .setSpinnerWidth(10.7)
                    .setSpinnerScaleFactor(5)
            }
            .setResultCustomization { resulBuilder in
                resulBuilder
                    .setSuccessBackgroundColor(.red)
                    .setSuccessImage(UIImage(named: "doc.text.magnifyingglass"))
                    .setSuccessMessage("SUCCESS")
                    .setSuccessMessageColor(.blue)
                    .setMessageFont(.systemFont(ofSize: 30, weight: .thin))
                    .setErrorBackgroundColor(.blue)
                    .setErrorImage(UIImage(named: "pencil"))
                    .setErrorMessage("ERROR")
                    .setErrorMessageColor(.red)
                    .setRetryBackgroundColor(.magenta)
                    .setRetryImage(UIImage(named: "phone") ?? UIImage())
                    .setRetryMessageColor(.white)
                    .setRetryButtonText("Again")
                    .setRetryButtonTextFont(.systemFont(ofSize: 35, weight: .semibold))
                    .setRetryButtonTextColor(.cyan)
                    .setRetryButtonBackgroundColor(.brown)
                    .setRetryButtonBorderColor(.white)
            }
            .build()

        return setCustomization(customization, in: builder)
    }

    static func setCustomViews(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let customization = IProovCustomization.builder()
            .setCustomInstructionView(CustomInstructionView())
            .setCustomCameraPermissionView(CustomCameraPermissionViewImpl())
            .setCustomLoadingView(CustomIProovLoadingView())
            .setCustomResultView(CustomIProovResultView())
            .build()

        return setCustomization(customization, in: builder)
    }

    private static func setCustomization(
        _ customization: IProovCustomization,
        in builder: LivenessManagerOptions.Builder
    ) -> LivenessManagerOptions {
        builder.setIProovCustomization(customization).build()
    }
}
