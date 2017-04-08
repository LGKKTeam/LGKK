#!/bin/sh
set -e

echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

SWIFT_STDLIB_PATH="${DT_TOOLCHAIN_DIR}/usr/lib/swift/${PLATFORM_NAME}"

install_framework()
{
  if [ -r "${BUILT_PRODUCTS_DIR}/$1" ]; then
    local source="${BUILT_PRODUCTS_DIR}/$1"
  elif [ -r "${BUILT_PRODUCTS_DIR}/$(basename "$1")" ]; then
    local source="${BUILT_PRODUCTS_DIR}/$(basename "$1")"
  elif [ -r "$1" ]; then
    local source="$1"
  fi

  local destination="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

  if [ -L "${source}" ]; then
      echo "Symlinked..."
      source="$(readlink "${source}")"
  fi

  # use filter instead of exclude so missing patterns dont' throw errors
  echo "rsync -av --filter \"- CVS/\" --filter \"- .svn/\" --filter \"- .git/\" --filter \"- .hg/\" --filter \"- Headers\" --filter \"- PrivateHeaders\" --filter \"- Modules\" \"${source}\" \"${destination}\""
  rsync -av --filter "- CVS/" --filter "- .svn/" --filter "- .git/" --filter "- .hg/" --filter "- Headers" --filter "- PrivateHeaders" --filter "- Modules" "${source}" "${destination}"

  local basename
  basename="$(basename -s .framework "$1")"
  binary="${destination}/${basename}.framework/${basename}"
  if ! [ -r "$binary" ]; then
    binary="${destination}/${basename}"
  fi

  # Strip invalid architectures so "fat" simulator / device frameworks work on device
  if [[ "$(file "$binary")" == *"dynamically linked shared library"* ]]; then
    strip_invalid_archs "$binary"
  fi

  # Resign the code if required by the build settings to avoid unstable apps
  code_sign_if_enabled "${destination}/$(basename "$1")"

  # Embed linked Swift runtime libraries. No longer necessary as of Xcode 7.
  if [ "${XCODE_VERSION_MAJOR}" -lt 7 ]; then
    local swift_runtime_libs
    swift_runtime_libs=$(xcrun otool -LX "$binary" | grep --color=never @rpath/libswift | sed -E s/@rpath\\/\(.+dylib\).*/\\1/g | uniq -u  && exit ${PIPESTATUS[0]})
    for lib in $swift_runtime_libs; do
      echo "rsync -auv \"${SWIFT_STDLIB_PATH}/${lib}\" \"${destination}\""
      rsync -auv "${SWIFT_STDLIB_PATH}/${lib}" "${destination}"
      code_sign_if_enabled "${destination}/${lib}"
    done
  fi
}

# Signs a framework with the provided identity
code_sign_if_enabled() {
  if [ -n "${EXPANDED_CODE_SIGN_IDENTITY}" -a "${CODE_SIGNING_REQUIRED}" != "NO" -a "${CODE_SIGNING_ALLOWED}" != "NO" ]; then
    # Use the current code_sign_identitiy
    echo "Code Signing $1 with Identity ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
    local code_sign_cmd="/usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} ${OTHER_CODE_SIGN_FLAGS} --preserve-metadata=identifier,entitlements '$1'"

    if [ "${COCOAPODS_PARALLEL_CODE_SIGN}" == "true" ]; then
      code_sign_cmd="$code_sign_cmd &"
    fi
    echo "$code_sign_cmd"
    eval "$code_sign_cmd"
  fi
}

# Strip invalid architectures
strip_invalid_archs() {
  binary="$1"
  # Get architectures for current file
  archs="$(lipo -info "$binary" | rev | cut -d ':' -f1 | rev)"
  stripped=""
  for arch in $archs; do
    if ! [[ "${VALID_ARCHS}" == *"$arch"* ]]; then
      # Strip non-valid architectures in-place
      lipo -remove "$arch" -output "$binary" "$binary" || exit 1
      stripped="$stripped $arch"
    fi
  done
  if [[ "$stripped" ]]; then
    echo "Stripped $binary of architectures:$stripped"
  fi
}


if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_framework "$BUILT_PRODUCTS_DIR/AFNetworking/AFNetworking.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Alamofire/Alamofire.framework"
  install_framework "$BUILT_PRODUCTS_DIR/CNPPopupController/CNPPopupController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Cartography/Cartography.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ChameleonFramework/ChameleonFramework.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Charts/Charts.framework"
  install_framework "$BUILT_PRODUCTS_DIR/CocoaLumberjack/CocoaLumberjack.framework"
  install_framework "$BUILT_PRODUCTS_DIR/CryptoSwift/CryptoSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DYSlideView/DYSlideView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DZNEmptyDataSet/DZNEmptyDataSet.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ESPullToRefresh/ESPullToRefresh.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FXBlurView/FXBlurView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Fakery/Fakery.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Fashion/Fashion.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FontAwesomeKit/FontAwesomeKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FontBlaster/FontBlaster.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FontasticIcons/FontasticIcons.framework"
  install_framework "$BUILT_PRODUCTS_DIR/GPUImage/GPUImage.framework"
  install_framework "$BUILT_PRODUCTS_DIR/HTMLAttributedString/HTMLAttributedString.framework"
  install_framework "$BUILT_PRODUCTS_DIR/IAPHelper/IAPHelper.framework"
  install_framework "$BUILT_PRODUCTS_DIR/IQKeyboardManagerSwift/IQKeyboardManagerSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ImageSlideshow/ImageSlideshow.framework"
  install_framework "$BUILT_PRODUCTS_DIR/KeychainAccess/KeychainAccess.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Kingfisher/Kingfisher.framework"
  install_framework "$BUILT_PRODUCTS_DIR/LGSideMenuController/LGSideMenuController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MBProgressHUD/MBProgressHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MGSwipeTableCell/MGSwipeTableCell.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MagicalRecord/MagicalRecord.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Moya/Moya.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ObjectMapper/ObjectMapper.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PDTSimpleCalendar/PDTSimpleCalendar.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PKRevealController/PKRevealController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PermissionScope/PermissionScope.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PopupDialog/PopupDialog.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PromiseKit/PromiseKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PusherSwift/PusherSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RNCryptor/RNCryptor.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ReSwift/ReSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Realm/Realm.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RealmSwift/RealmSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Result/Result.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Reusable/Reusable.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RxCocoa/RxCocoa.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RxSwift/RxSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SCLAlertView/SCLAlertView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SCSkypeActivityIndicatorView/SCSkypeActivityIndicatorView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SVProgressHUD/SVProgressHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SVPullToRefresh/SVPullToRefresh.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Segmentio/Segmentio.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SignalR-ObjC/SignalR_ObjC.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SlackTextViewController/SlackTextViewController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SnapKit/SnapKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SocketRocket/SocketRocket.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Spring/Spring.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Stripe/Stripe.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftDate/SwiftDate.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftLocation/SwiftLocation.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftMessages/SwiftMessages.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwifterSwift/SwifterSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftyJSON/SwiftyJSON.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TAPromotee/TAPromotee.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TYAlertController/TYAlertController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TextFieldEffects/TextFieldEffects.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Toast/Toast.framework"
  install_framework "$BUILT_PRODUCTS_DIR/iRate/iRate.framework"
  install_framework "$BUILT_PRODUCTS_DIR/libPhoneNumber-iOS/libPhoneNumber_iOS.framework"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_framework "$BUILT_PRODUCTS_DIR/AFNetworking/AFNetworking.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Alamofire/Alamofire.framework"
  install_framework "$BUILT_PRODUCTS_DIR/CNPPopupController/CNPPopupController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Cartography/Cartography.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ChameleonFramework/ChameleonFramework.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Charts/Charts.framework"
  install_framework "$BUILT_PRODUCTS_DIR/CocoaLumberjack/CocoaLumberjack.framework"
  install_framework "$BUILT_PRODUCTS_DIR/CryptoSwift/CryptoSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DYSlideView/DYSlideView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/DZNEmptyDataSet/DZNEmptyDataSet.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ESPullToRefresh/ESPullToRefresh.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FXBlurView/FXBlurView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Fakery/Fakery.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Fashion/Fashion.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FontAwesomeKit/FontAwesomeKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FontBlaster/FontBlaster.framework"
  install_framework "$BUILT_PRODUCTS_DIR/FontasticIcons/FontasticIcons.framework"
  install_framework "$BUILT_PRODUCTS_DIR/GPUImage/GPUImage.framework"
  install_framework "$BUILT_PRODUCTS_DIR/HTMLAttributedString/HTMLAttributedString.framework"
  install_framework "$BUILT_PRODUCTS_DIR/IAPHelper/IAPHelper.framework"
  install_framework "$BUILT_PRODUCTS_DIR/IQKeyboardManagerSwift/IQKeyboardManagerSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ImageSlideshow/ImageSlideshow.framework"
  install_framework "$BUILT_PRODUCTS_DIR/KeychainAccess/KeychainAccess.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Kingfisher/Kingfisher.framework"
  install_framework "$BUILT_PRODUCTS_DIR/LGSideMenuController/LGSideMenuController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MBProgressHUD/MBProgressHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MGSwipeTableCell/MGSwipeTableCell.framework"
  install_framework "$BUILT_PRODUCTS_DIR/MagicalRecord/MagicalRecord.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Moya/Moya.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ObjectMapper/ObjectMapper.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PDTSimpleCalendar/PDTSimpleCalendar.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PKRevealController/PKRevealController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PermissionScope/PermissionScope.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PopupDialog/PopupDialog.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PromiseKit/PromiseKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/PusherSwift/PusherSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RNCryptor/RNCryptor.framework"
  install_framework "$BUILT_PRODUCTS_DIR/ReSwift/ReSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Realm/Realm.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RealmSwift/RealmSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Result/Result.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Reusable/Reusable.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RxCocoa/RxCocoa.framework"
  install_framework "$BUILT_PRODUCTS_DIR/RxSwift/RxSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SCLAlertView/SCLAlertView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SCSkypeActivityIndicatorView/SCSkypeActivityIndicatorView.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SVProgressHUD/SVProgressHUD.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SVPullToRefresh/SVPullToRefresh.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Segmentio/Segmentio.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SignalR-ObjC/SignalR_ObjC.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SlackTextViewController/SlackTextViewController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SnapKit/SnapKit.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SocketRocket/SocketRocket.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Spring/Spring.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Stripe/Stripe.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftDate/SwiftDate.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftLocation/SwiftLocation.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftMessages/SwiftMessages.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwifterSwift/SwifterSwift.framework"
  install_framework "$BUILT_PRODUCTS_DIR/SwiftyJSON/SwiftyJSON.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TAPromotee/TAPromotee.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TYAlertController/TYAlertController.framework"
  install_framework "$BUILT_PRODUCTS_DIR/TextFieldEffects/TextFieldEffects.framework"
  install_framework "$BUILT_PRODUCTS_DIR/Toast/Toast.framework"
  install_framework "$BUILT_PRODUCTS_DIR/iRate/iRate.framework"
  install_framework "$BUILT_PRODUCTS_DIR/libPhoneNumber-iOS/libPhoneNumber_iOS.framework"
fi
if [ "${COCOAPODS_PARALLEL_CODE_SIGN}" == "true" ]; then
  wait
fi
