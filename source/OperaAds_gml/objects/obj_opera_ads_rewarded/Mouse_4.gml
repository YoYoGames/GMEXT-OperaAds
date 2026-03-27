
opera_ads_rewarded_load(
	function(success,err){
		if(success)
		{			
			opera_ads_rewarded_show(
				function(event,err){
					show_message_async($"Rewarded: {event}")
				})
		}
		else
		{
			show_message_async($"Rewarded Failed: {err}")	
		}
	})
