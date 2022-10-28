package com.example.tyr_ads_exam

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val STAPPERCHANNEL = "flutter.native/Stapper"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, STAPPERCHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "1" -> {
                    result.success("When creating a new campaign you must enter the name of the campaign. The name of the campaign can be anything, but it is good practise to name it using a few popular conventions. The type of service or product you are selling, (e.g. Type of service or product), the network, targeting, location, and more. The campaign name can be changed at anytime. However the campaign ID that is assigned when creating a new campaign remains the same. ")
                }
                "2" -> {
                    result.success("The primary objective of the campaign. You can set this when creating a new campaign, or edit an existing campaign. Common objectives are leads or sales. You can also choose no goal.")
                }
                "3" -> {
                    result.success("Adwords gives you the option to display your advertising to users of other search engines or to focus exclusively on Google. Many companies are under the impression that they should focus solely on Google because that’s what most people use, but that couldn’t be further from the truth.")
                }
                else -> {
                    result.error("UNAVAILABLE", "Data on this index are not available", null)
                }
            }
        }
    }

}
