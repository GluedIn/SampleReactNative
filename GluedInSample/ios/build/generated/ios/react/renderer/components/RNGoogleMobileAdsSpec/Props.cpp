
/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GeneratePropsCpp.js
 */

#include <react/renderer/components/RNGoogleMobileAdsSpec/Props.h>
#include <react/renderer/core/PropsParserContext.h>
#include <react/renderer/core/propsConversions.h>

namespace facebook::react {

RNGoogleMobileAdsBannerViewProps::RNGoogleMobileAdsBannerViewProps(
    const PropsParserContext &context,
    const RNGoogleMobileAdsBannerViewProps &sourceProps,
    const RawProps &rawProps): ViewProps(context, sourceProps, rawProps),

    sizes(convertRawProp(context, rawProps, "sizes", sourceProps.sizes, {})),
    unitId(convertRawProp(context, rawProps, "unitId", sourceProps.unitId, {})),
    request(convertRawProp(context, rawProps, "request", sourceProps.request, {})),
    manualImpressionsEnabled(convertRawProp(context, rawProps, "manualImpressionsEnabled", sourceProps.manualImpressionsEnabled, {false}))
      {}

} // namespace facebook::react