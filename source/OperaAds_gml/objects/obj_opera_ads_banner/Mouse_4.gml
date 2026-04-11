
if(opera_ads_banner_is_ad_valid())
{
	move_index ++
	if(array_length(move_array) == move_index)
		move_index = 0
		
	opera_ads_banner_move(move_array[move_index])
}
else
opera_ads_banner_load(OperaAdsBannerSize.BannerSmart,
	function(event,err){
		switch(event)
		{
			case OperaAdsCallbackEventBanner.Loaded:
				show_message_async($"Banner: {event}")
				
				opera_ads_banner_show(OperaAdsBannerPosition.MiddleLeft)
				
				text = "Move"
				
			break
			
			case OperaAdsCallbackEventBanner.LoadFailed:
				show_message_async($"Banner Failed: {err}")	
			break
			
			default:
				show_message_async($"Banner: {event}")
			break
			
		}
	})
