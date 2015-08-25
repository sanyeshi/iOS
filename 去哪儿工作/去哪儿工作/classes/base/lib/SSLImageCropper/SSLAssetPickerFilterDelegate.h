//
// ELCAssetPickerFilterDelegate.h

@class SSLAsset;
@class SSLAssetTablePicker;

@protocol SSLAssetPickerFilterDelegate<NSObject>

// respond YES/NO to filter out (not show the asset)
-(BOOL)assetTablePicker:(SSLAssetTablePicker *)picker isAssetFilteredOut:(SSLAsset *)sslAsset;

@end