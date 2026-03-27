
opera_ads_rewarded_interstitial_load(
	function(success,err){
		if(success)
		{			
			opera_ads_rewarded_interstitial_show(
				function(event,err){
					show_message_async($"Rewarded Interstitial: {event}")
				})
		}
		else
		{
			show_message_async($"Rewarded Interstitial Failed: {err}")	
		}
	})
