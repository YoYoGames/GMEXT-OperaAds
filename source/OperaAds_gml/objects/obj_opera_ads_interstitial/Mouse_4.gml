
opera_ads_interstitial_load(
	function(success,err){
		if(success)
		{			
			opera_ads_interstitial_show(
				function(event,err){
					show_message_async($"Interstital: {event}")
				})
		}
		else
		{
			show_message_async($"OperaAds Interstitial Failed: {err}")	
		}
	})
