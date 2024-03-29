module NotificationsHelper

def notification_form(notification)
	  @visitor = notification.visitor_id
	  your_item = link_to 'あなたの投稿', posts_path(notification)

	  #notification.actionがフォローかいいね
	  case notification.action
	    when "follow" then
	      tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold; color:#FFFFFF;")+"さんがあなたをフォローしました。"
	    when "favorite" then
	      tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold; color:#FFFFFF;")+"さんが"+tag.a('あなたの投稿', href:post_path(notification.post_id),
	      style:"font-weight: bold; color:#FFFFFF;")+"にいいねしました。"
	  end
	end

def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
end

end
