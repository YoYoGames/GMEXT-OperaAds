

if(opera_ads_app_open_is_enabled())
{
	opera_ads_app_open_disable()
}
else
{
	opera_ads_app_open_enable(
		function(event,err){
			if(event == OperaAdsCallbackEventAppOpen.Failed)
				show_message_async($"App Open: {event}: {err}")
			else
				show_message_async($"App Open: {event}")
				
		})	
}

text = $"Open Ads: {opera_ads_app_open_is_enabled()}"
