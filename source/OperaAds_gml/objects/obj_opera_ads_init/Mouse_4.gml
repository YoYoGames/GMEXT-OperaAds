
//opera_ads_set_gdpr(consent_string, true);
//opera_ads_set_us_privacy("1YNN");
//opera_ads_set_coppa(false);


//If you want runtime configuration
//opera_ads_interstitial_set_placement_id("")
//opera_ads_rewarded_set_placement_id("")
//opera_ads_rewarded_interstitial_set_placement_id("")
//opera_ads_app_open_set_placement_id("")
//opera_ads_banner_set_placement_id("")

opera_ads_init(
	function(success,err){
		if(success)
			show_message_async($"OperaAds Init Success")	
		else
		{
			show_message_async($"OperaAds Init Failed: {err}")	
		}
	})
