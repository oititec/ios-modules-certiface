//
//  FacetecCustomizationExample.swift
//  Example
//
//  Created by Vitor Souza on 17/10/25.
//

import CertifaceSDK
import UIKit

enum FacetecCustomizationExample {
    static func setDefaultAppearance(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let customization = FacetecCustomization.builder().build()
        return setCustomization(customization, in: builder)
    }

    static func setCustomAppearance(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let customization = FacetecCustomization.builder()
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
            .setLoadingCustomization { loadingBuilder in
                loadingBuilder
                    .setBackgroundColor(.brown)
                    .setSpinnerColor(.red)
                    .setSpinnerWidth(10.7)
                    .setSpinnerScaleFactor(5)
            }
            .setLivenessDefaultTheme(customizeLivenessTheme)
            .setLivenessLowLightTheme(customizeLivenessTheme)
            .setLivenessTexts([
                // Ready
                .readyHeader1: "ready_title_1",
                .readyHeader2: "ready_title_2",
                .readyMessage1: "ready_message_1",
                .readyMessage2: "ready_message_2.",
                .readyButton: "ready_button",

                // feedback
                .feedbackCenterFace: "feedback_center_face",
                .feedbackFaceNotFound: "feedback_no_face",
                .feedbackFaceNotLookingStraightAhead: "feedback_straight_ahead",
                .feedbackFaceNotUpright: "feedback_upright",
                .feedbackHoldSteady: "feedback_hold",
                .feedbackMovePhoneAway: "feedback_move_away",
                .feedbackMovePhoneCloser: "feedback_move_closer",
                .feedbackMovePhoneToEyeLevel: "feedback_move_eye_level",
                .feedbackUseEvenLighting: "feedback_even_lighting",
                .feedbackFrameYourFace: "feedback_start",
                .feedbackPositionFaceStraightInOval: "feedback_look_forward",
                .feedbackHoldSteady1: "feedback_hold_3",
                .feedbackHoldSteady2: "feedback_hold_2",
                .feedbackHoldSteady3: "feedback_hold_1",
                .feedbackNeutralExpression: "feedback_no_smile",
                .feedbackBrightenYourEnvironment: "feedback_too_dark",
                .feedbackRemoveDarkGlasses: "feedback_remove_glasses",
                .feedbackConditionsTooBright: "feedback_too_bright",

                // Upload
                .resultUploadMessage: "upload_message",
                .resultSuccessMessage: "upload_all_right_message",

                // Retry
                .retryHeader: "retry_header",
                .retrySubheader: "retry_subheader",
                .retryMessageSmile: "retry_message_smile",
                .retryMessageLightning: "retry_message_lighting",
                .retryMessageContrast: "retry_message_contrast",
                .retryYourPicture: "retry_your_image",
                .retryIdealPicture: "retry_ideal_image",
                .retryButton: "retry_again_button",
            ])
            .build()

        return setCustomization(customization, in: builder)
    }

    static func setCustomViews(in builder: LivenessManagerOptions.Builder) -> LivenessManagerOptions {
        let customization = FacetecCustomization.builder()
            .setCustomInstructionView(CustomInstructionView())
            .setCustomCameraPermissionView(CustomCameraPermissionViewImpl())
            .build()

        return setCustomization(customization, in: builder)
    }

    private static func setCustomization(
        _ customization: FacetecCustomization,
        in builder: LivenessManagerOptions.Builder
    ) -> LivenessManagerOptions {
        builder.setFacetecCustomization(customization).build()
    }

    private static func customizeLivenessTheme(in themeBuilder: Liveness3DThemeBuilder) -> Liveness3DThemeBuilder {
        // Ready
        themeBuilder
            .setReadyScreenHeaderColor(.green)
            .setReadyScreenHeaderFont(.systemFont(ofSize: 20, weight: .regular))
            .setReadyScreenMessageColor(.brown)
            .setReadyScreenMessageFont(.systemFont(ofSize: 20, weight: .semibold))
            .setReadyScreenTextBackgroundColor(.systemPink)
            .setReadyScreenTextBackgroundCornerRadius(10)

        // Result
        themeBuilder
            .setResultScreenMessageColor(.blue)
            .setResultScreenMessageFont(.systemFont(ofSize: 20, weight: .medium))
            .setResultScreenAnimationStyle(
                .blob(appearance: BlobAnimationAppearance(
                    blobColor: .blue,
                    checkmarkForegroundColor: .purple,
                    checkmarkBackgroundColor: .yellow
                ))
            )
            .setResultScreenAnimationScale(1.5)
            .setResultScreenUploadProgressBarEnabled(true)
            .setResultScreenUploadProgressBarFillColor(.red)
            .setResultScreenUploadProgressBarTrackColor(.green)

        // Retry
        themeBuilder
            .setRetryScreenHeaderColor(.systemPink)
            .setRetryScreenHeaderFont(.systemFont(ofSize: 20, weight: .heavy))
            .setRetryScreenCaptionColor(.red)
            .setRetryScreenCaptionFont(.systemFont(ofSize: 20, weight: .ultraLight))
            .setRetryScreenImageBorderColor(.systemBlue)
            .setRetryScreenImageBorderWidth(10)
            .setRetryScreenImageBorderCornerRadius(10)

        // Feedback
        themeBuilder
            .setFeedbackMessageColor(.systemPink)
            .setFeedbackMessageFont(.systemFont(ofSize: 20, weight: .black))
            .setFeedbackBarBackgroundColor(.yellow)
            .setFeedbackBarCornerRadius(10)
            .setFeedbackBarShadow(.init(
                color: .purple,
                opacity: 0.5,
                radius: 3,
                offset: CGSize(width: 2, height: 5),
                insets: UIEdgeInsets(top: 3, left: 1.5, bottom: 3.7, right: 7.5)
            ))

        // Guidance
        themeBuilder
            .setGuidanceHeaderFont(.systemFont(ofSize: 20, weight: .light))
            .setGuidanceSubtextFont(.systemFont(ofSize: 20, weight: .thin))
            .setGuidanceButtonFont(.systemFont(ofSize: 20, weight: .semibold))
            .setGuidanceButtonTextNormalColor(.white)
            .setGuidanceButtonTextHighlightColor(.red)
            .setGuidanceButtonTextDisabledColor(.black)
            .setGuidanceButtonBackgroundNormalColor(.purple)
            .setGuidanceButtonBackgroundHighlightColor(.gray)
            .setGuidanceButtonBackgroundDisabledColor(.blue)
            .setGuidanceButtonBorderColor(.white)
            .setGuidanceButtonBorderWidth(10)
            .setGuidanceButtonBorderCornerRadius(10)

        // Frame
        themeBuilder
            .setFrameBackgroundColor(.lightGray)
            .setFrameBorderColor(.cyan)
            .setFrameBorderWidth(14)
            .setFrameBorderCornerRadius(10)
            .setFrameShadow(.init(
                color: .red,
                opacity: 0.8,
                radius: 10,
                offset: CGSize(width: 10, height: 20),
                insets: UIEdgeInsets(top: 3, left: 1.5, bottom: 3.7, right: 7.5)
            ))

        // Oval
        themeBuilder
            .setOvalStrokeColor(.black)
            .setOvalStrokeWidth(10)
            .setOvalProgressFirstColor(.purple)
            .setOvalProgressSecondColor(.green)
            .setOvalProgressWidth(10)
            .setOvalProgressOffset(2)

        // Overlay
        themeBuilder
            .setOverlayBrandImage(UIImage(systemName: "house"))
            .setOverlayBackgroundColor(.green)

        // Cancel button
        themeBuilder
            .setCancelButtonIcon(UIImage(systemName: "pencil"))
            .setCancelButtonLocation(.topRight)

        // Vocal guidance
        themeBuilder
            .setVocalGuidanceMode(.noVocalGuidance)

        return themeBuilder
    }
}
