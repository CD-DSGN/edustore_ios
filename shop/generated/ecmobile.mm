//
// ECMobile (Geek-Zoo Studio)
//
// generated at 2013-06-17 05:47:47 +0000
//

#import "ecmobile.h"

#pragma mark - models

@implementation ADDRESS

@synthesize id = _id;
@synthesize address = _address;
@synthesize best_time = _best_time;
@synthesize city = _city;
@synthesize country = _country;
@synthesize default_address = _default_address;
@synthesize district = _district;
@synthesize email = _email;
@synthesize mobile = _mobile;
@synthesize name = _name;
@synthesize province = _province;
@synthesize sign_building = _sign_building;
@synthesize tel = _tel;
@synthesize zipcode = _zipcode;

@end

@implementation ARTICLE

@synthesize id = _id;
@synthesize short_title = _short_title;
@synthesize title = _title;

@end

@implementation ARTICLE_GROUP

@synthesize article = _article;
@synthesize name = _name;

CONVERT_PROPERTY_CLASS( article, ARTICLE );

@end

@implementation BANNER

@synthesize action = _action;
@synthesize action_id = _action_id;
@synthesize description = _description;
@synthesize photo = _photo;
@synthesize url = _url;

@end

@implementation BONUS
@synthesize type_id = _type_id;
@synthesize type_name = _type_name;
@synthesize type_money = _type_money;
@synthesize bonus_id = _bonus_id;
@synthesize bonus_money_formated = _bonus_money_formated;
@end

@implementation BRAND
@synthesize url = _url;
@synthesize brand_id = _brand_id;
@synthesize brand_name = _brand_name;
@end

@implementation CART_GOODS

@synthesize rec_id = _rec_id;
@synthesize can_handsel = _can_handsel;
@synthesize extension_code = _extension_code;
@synthesize formated_goods_price = _formated_goods_price;
@synthesize formated_market_price = _formated_market_price;
@synthesize formated_subtotal = _formated_subtotal;
@synthesize goods_attr = _goods_attr;
@synthesize goods_attr_id = _goods_attr_id;
@synthesize goods_id = _goods_id;
@synthesize goods_name = _goods_name;
@synthesize goods_number = _goods_number;
@synthesize goods_price = _goods_price;
@synthesize goods_sn = _goods_sn;
@synthesize img = _img;
@synthesize is_gift = _is_gift;
@synthesize is_real = _is_real;
@synthesize is_shipping = _is_shipping;
@synthesize market_price = _market_price;
@synthesize parent_id = _parent_id;
@synthesize pid = _pid;
@synthesize rec_type = _rec_type;
@synthesize subtotal = _subtotal;

CONVERT_PROPERTY_CLASS( goods_attr, GOOD_ATTR );

@end

@implementation CATEGORY

@synthesize id = _id;
@synthesize goods = _goods;
@synthesize name = _name;

CONVERT_PROPERTY_CLASS( goods, SIMPLE_GOODS );

@end

@implementation TOP_CATEGORY

@synthesize children = _children;
@synthesize name = _name;
@synthesize id = _id;

CONVERT_PROPERTY_CLASS( children, CATEGORY );

@end

@implementation COMMENT

@synthesize id = _id;
@synthesize author = _author;
@synthesize content = _content;
@synthesize create = _create;
@synthesize re_content = _re_content;

@end

@implementation CONFIG

@synthesize close_comment = _close_comment;
@synthesize service_phone = _service_phone;
@synthesize shop_closed = _shop_closed;
@synthesize shop_desc = _shop_desc;
@synthesize shop_reg_closed = _shop_reg_closed;
@synthesize site_url = _site_url;
@synthesize goods_url = _goods_url;

@end

@implementation EXPRESS

@synthesize context = _context;
@synthesize time = _time;

@end

@implementation FILTER

@synthesize brand_id = _brand_id;
@synthesize category_id = _category_id;
@synthesize keywords = _keywords;
@synthesize price_range = _price_range;
@synthesize sort_by = _sort_by;

@end

@implementation GOODS

@synthesize id = _id;
@synthesize brand_id = _brand_id;
@synthesize cat_id = _cat_id;
@synthesize click_count = _click_count;
@synthesize goods_name = _goods_name;
@synthesize goods_number = _goods_number;
@synthesize goods_sn = _goods_sn;
@synthesize goods_weight = _goods_weight;
@synthesize img = _img;
@synthesize collected = _collected;
@synthesize integral = _integral;
@synthesize is_shipping = _is_shipping;
@synthesize market_price = _market_price;
@synthesize pictures = _pictures;
@synthesize promote_end_date = _promote_end_date;
@synthesize promote_price = _promote_price;
@synthesize promote_start_date = _promote_start_date;
@synthesize properties = _properties;
@synthesize rank_prices = _rank_prices;
@synthesize shop_price = _shop_price;
@synthesize specification = _specification;
@synthesize is_presell = _is_presell;
@synthesize presell_shipping_time = _presell_shipping_time;

CONVERT_PROPERTY_CLASS( pictures, PHOTO );
CONVERT_PROPERTY_CLASS( properties, GOOD_ATTR );
CONVERT_PROPERTY_CLASS( rank_prices, GOOD_RANK_PRICE );
CONVERT_PROPERTY_CLASS( specification, GOOD_SPEC );

@end

@implementation GOOD_ATTR

@synthesize name = _name;
@synthesize value = _value;

@end

@implementation GOOD_RANK_PRICE

@synthesize id = _id;
@synthesize price = _price;
@synthesize rank_name = _rank_name;

@end

@implementation GOOD_SPEC

@synthesize attr_type = _attr_type;
@synthesize name = _name;
@synthesize value = _value;

CONVERT_PROPERTY_CLASS( value, GOOD_VALUE );

@end

@implementation GOOD_VALUE

@synthesize format_price = _format_price;
@synthesize id = _id;
@synthesize label = _label;
@synthesize price = _price;

@end

@implementation GOOD_SPEC_VALUE
@synthesize spec = _spec;
@synthesize value = _value;
@end

@implementation INVOICE

@synthesize id = _id;
@synthesize value = _value;

@end

@implementation ORDER_INFO

@synthesize pay_code = _pay_code;
@synthesize order_sn = _order_sn;
@synthesize order_amount = _order_amount;
@synthesize order_id = _order_id;
@synthesize subject = _subject;
@synthesize desc = _desc;

@end

@implementation ORDER

@synthesize order_id = _order_id;
@synthesize goods_list = _goods_list;
@synthesize order_sn = _order_sn;
@synthesize order_time = _order_time;
@synthesize total_fee = _total_fee;
@synthesize order_info = _order_info;

CONVERT_PROPERTY_CLASS( goods_list, ORDER_GOODS );

@end

@implementation ORDER_GOODS

@synthesize goods_id = _goods_id;
@synthesize formated_shop_price = _formated_shop_price;
@synthesize goods_number = _goods_number;
@synthesize img = _img;
@synthesize name = _name;
@synthesize subtotal = _subtotal;

@end

@implementation PAGINATED

@synthesize count = _count;
@synthesize more = _more;
@synthesize total = _total;

@end

@implementation PAGINATION

@synthesize count = _count;
@synthesize page = _page;

@end

@implementation PAYMENT

@synthesize pay_id = _pay_id;
@synthesize format_pay_fee = _format_pay_fee;
@synthesize is_cod = _is_cod;
@synthesize pay_code = _pay_code;
@synthesize pay_desc = _pay_desc;
@synthesize pay_fee = _pay_fee;
@synthesize pay_name = _pay_name;

@end

@implementation PHOTO

@synthesize img = _img;
@synthesize thumb = _thumb;
@synthesize url = _url;
@synthesize small = _small;

@end

@implementation PRICE_RANGE

@synthesize price_min = _price_min;
@synthesize price_max = _price_max;

@end

@implementation REGION

@synthesize id = _id;
@synthesize more = _more;
@synthesize name = _name;
@synthesize parent_id = _parent_id;
@synthesize type = _type;

@end

@implementation TEACHER_INFO

@synthesize user_id = _user_id;
@synthesize course_id = _course_id;
@synthesize real_name = _real_name;
@synthesize school = _school;
@synthesize user_name = _user_name;
@synthesize mobile_phone = _mobile_phone;
@synthesize teacher_integral = _teacher_integral;
@synthesize isFollowed = _isFollowed;

@end

@implementation IS_FOLLOWED

@synthesize is_followed = _is_followed;

@end

@implementation SESSION

@synthesize sid = _sid;
@synthesize uid = _uid;

@end

@implementation SHIPPING

@synthesize shipping_id = _shipping_id;
@synthesize format_shipping_fee = _format_shipping_fee;
@synthesize free_money = _free_money;
@synthesize insure = _insure;
@synthesize insure_formated = _insure_formated;
@synthesize shipping_code = _shipping_code;
@synthesize shipping_desc = _shipping_desc;
@synthesize shipping_fee = _shipping_fee;
@synthesize shipping_name = _shipping_name;
@synthesize support_cod = _support_cod;

@end

@implementation SIGNUP_FIELD

@synthesize id = _id;
@synthesize name = _name;
@synthesize need = _need;

@end

@implementation SIGNUP_FIELD_VALUE

@synthesize id = _id;
@synthesize value = _value;

@end

@implementation SIMPLE_GOODS

@synthesize goods_id = _goods_id;
@synthesize id = _id;
@synthesize brief = _brief;
@synthesize img = _img;
@synthesize market_price = _market_price;
@synthesize name = _name;
@synthesize promote_price = _promote_price;
@synthesize shop_price = _shop_price;

@end

@implementation STATUS

@synthesize error_code = _error_code;
@synthesize error_desc = _error_desc;
@synthesize succeed = _succeed;

@end

@implementation TOTAL

@synthesize goods_amount = _goods_amount;
@synthesize goods_price = _goods_price;
@synthesize market_price = _market_price;
@synthesize real_goods_count = _real_goods_count;
@synthesize save_rate = _save_rate;
@synthesize saving = _saving;
@synthesize virtual_goods_count = _virtual_goods_count;

@end

@implementation USER

@synthesize id = _id;
@synthesize collection_num = _collection_num;
@synthesize name = _name;
@synthesize email = _email;
@synthesize order_num = _order_num;
@synthesize rank_name = _rank_name;
@synthesize rank_level = _rank_level;
@synthesize is_teacher = _is_teacher;
@synthesize avatar = _avatar;
@synthesize nickname = _nickname;
@synthesize teacher_name = _teacher_name;
@synthesize course_name = _course_name;

@end

@implementation COLLECT_GOODS

@synthesize rec_id = _rec_id;
@synthesize isEditing = _isEditing; // TODO:

@end

@implementation identifyCode

@synthesize identifyCode = _identifyCode;

@end

@implementation Course

@synthesize course_name = _course_name;
@synthesize course_id = _course_id;
@synthesize teacher_name = _teacher_name;

@end

@implementation Course_Info

@synthesize course_id = _course_id;
@synthesize course_name = _course_name;
@synthesize teacher_name = _teacher_name;
@synthesize isLastCourse = _isLastCourse;

@end

@implementation Teacher

@synthesize teacher_name = _teacher_name;

@end

@implementation Regions

@synthesize more = _more;
@synthesize regions = _regions;

@end

@implementation MOMENTS

@synthesize publish_info = _publish_info;
@synthesize teacher_info = _teacher_info;

@end

@implementation COMMENT_INFO

@synthesize comment_id = _comment_id;
@synthesize username = _username;
@synthesize target_username = _target_username;
@synthesize comment_content = _comment_content;
@synthesize show_name = _show_name;
@synthesize show_target_name = _show_target_name;
@synthesize news_id = _news_id;

@end

@implementation MOMENTS_PUBLISH

@synthesize user_id = _user_id;
@synthesize publish_time = _publish_time;
@synthesize news_content = _news_content;
@synthesize photo_array = _photo_array;
@synthesize comment_array = _comment_array;
@synthesize news_id = _news_id;

@end

@implementation MOMENTS_TEACHER

@synthesize real_name = _real_name;
@synthesize avatar = _avatar;
@synthesize course_name = _course_name;

@end

@implementation TEACHER_INTEGRAL

@synthesize invitation_code = _invitation_code;
@synthesize pay_points = _pay_points;
@synthesize points_from_affiliate = _points_from_affiliate;
@synthesize points_from_subscription = _points_from_subscription;
@synthesize rank_points = _rank_points;
@synthesize subscription_student_num = _subscription_student_num;
@synthesize recommanded_teacher_num = _recommanded_teacher_num;
@synthesize teacher_integral = _teacher_integral;

@end

@implementation PAYMENT_INFO

@synthesize pay_id = _pay_id;
@synthesize pay_name = _pay_name;
@synthesize pay_code = _pay_code;

@end

@implementation CHECK_USER_INFO

@synthesize username = _username;
@synthesize invite_user_id = _invite_user_id;
@synthesize invite_error = _invite_error;

@end

@implementation TEACHER_REGISTER_INFO

@synthesize teacher_name = _teacher_name;
@synthesize province_id = _province_id;
@synthesize town_id = _town_id;
@synthesize district_id = _district_id;
@synthesize school_id = _school_id;
@synthesize course_id = _course_id;
@synthesize grade_array = _grade_array;
@synthesize class_array = _class_array;
@synthesize line = _line;

@end

@implementation UPDATE_VERSION_INFO

@synthesize down_link = _down_link;
@synthesize is_required = _is_required;
@synthesize is_update = _is_update;
@synthesize latest_version = _latest_version;
@synthesize update_node = _update_node;

@end

@implementation NEWS_BANNER

@synthesize banner_id = _banner_id;
@synthesize banner_url = _banner_url;

@end

@implementation NEWS_DETAIL

@synthesize created_at = _created_at;
@synthesize sketch = _sketch;
@synthesize title = _title;
@synthesize updated_at = _updated_at;
@synthesize url = _url;
@synthesize banner = _banner;
@synthesize news_id = _news_id;
@synthesize label_id = _label_id;
@synthesize label_name =_label_name;
@end

@implementation TEACHER_CLASS

@synthesize class_no = _class_no;
@synthesize grade = _grade;
@synthesize info_id = _info_id;
@synthesize school_name = _school_name;

@end

@implementation STUDENT_POINT

@synthesize student_name = _student_name;
@synthesize student_points = _student_points;
@synthesize avatar = _avatar;
@synthesize student_index = _student_index;
@end

@implementation Register_grade

@synthesize grade_id = _grade_id;
@synthesize grade_name = _grade_name;

@end

@implementation Register_school

@synthesize school_id = _school_id;
@synthesize school_name = _school_name;

@end

@implementation TIMER

- (void)validCountDownTime:(NSInteger)time
                  forTimer:(NSTimer *)timer
                 forButton:(BeeUIButton *)button
{
    if ( time >= 0 )
    {
        [button setEnabled:NO];
        [button setSelected:YES];
        [button setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)time]];
        time--;
    }
    else
    {
        [self removeTimer:timer];
        [button setEnabled:YES];
        [button setTitle:@"重新获取验证码"];
        [button setImage:nil];
    }
}

- (void)validCountDownTime:(NSInteger)time
                  forTimer:(NSTimer *)timer
{
    
}

- (void)removeTimer:(NSTimer *)timer
{
    
}

@end

#pragma mark - controllers

@implementation API

#pragma mark - POST address/add

DEF_MESSAGE_( address_add, msg )
{
	if ( msg.sending )
	{
		SESSION * session = msg.GET_INPUT( @"session" );
		ADDRESS * address = msg.GET_INPUT( @"address" );

		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"session", session );
		requestBody.APPEND( @"address", address );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=address/add";
		NSString * requestURI = [NSString stringWithFormat:@"%@/address/add", [ServerConfig sharedInstance].url];

		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		ADDRESS * data = [ADDRESS objectFromDictionary:[response dictAtPath:@"data"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST address/delete

DEF_MESSAGE_( address_delete, msg )
{
	if ( msg.sending )
	{
		NSNumber * address_id = msg.GET_INPUT( @"address_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == address_id || NO == [address_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"address_id", address_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=address/delete";
		NSString * requestURI = [NSString stringWithFormat:@"%@/address/delete", [ServerConfig sharedInstance].url];

		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST address/info

DEF_MESSAGE_( address_info, msg )
{
	if ( msg.sending )
	{
		NSNumber * address_id = msg.GET_INPUT( @"address_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == address_id || NO == [address_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"address_id", address_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=address/info";
		NSString * requestURI = [NSString stringWithFormat:@"%@/address/info", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		ADDRESS * data = [ADDRESS objectFromDictionary:[response dictAtPath:@"data"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST address/list

DEF_MESSAGE_( address_list, msg )
{
	if ( msg.sending )
	{
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=address/list";
		NSString * requestURI = [NSString stringWithFormat:@"%@/address/list", [ServerConfig sharedInstance].url];

		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [ADDRESS objectsFromArray:[response arrayAtPath:@"data"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST address/setDefault

DEF_MESSAGE_( address_setDefault, msg )
{
	if ( msg.sending )
	{
		NSNumber * address_id = msg.GET_INPUT( @"address_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == address_id || NO == [address_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"address_id", address_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=address/setDefault";
		NSString * requestURI = [NSString stringWithFormat:@"%@/address/setDefault", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST address/update

DEF_MESSAGE_( address_update, msg )
{
	if ( msg.sending )
	{
		ADDRESS * address = msg.GET_INPUT( @"address" );
		NSNumber * address_id = msg.GET_INPUT( @"address_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == address || NO == [address isKindOfClass:[ADDRESS class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == address_id || NO == [address_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"address", address );
		requestBody.APPEND( @"address_id", address_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=address/update";
		NSString * requestURI = [NSString stringWithFormat:@"%@/address/update", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		ADDRESS * data = [ADDRESS objectFromDictionary:[response dictAtPath:@"data"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST article

DEF_MESSAGE_( article, msg )
{
	if ( msg.sending )
	{
		NSNumber * article_id = msg.GET_INPUT( @"article_id" );

		if ( nil == article_id || NO == [article_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"article_id", article_id );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=article";
		NSString * requestURI = [NSString stringWithFormat:@"%@/article", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSString * data = [response stringAtPath:@"data"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST cart/create

DEF_MESSAGE_( cart_create, msg )
{
	if ( msg.sending )
	{
		NSNumber * goods_id = msg.GET_INPUT( @"goods_id" );
		NSString * number = msg.GET_INPUT( @"number" );
		SESSION * session = msg.GET_INPUT( @"session" );
		NSArray * spec = msg.GET_INPUT( @"spec" );

		if ( nil == goods_id || NO == [goods_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == number || NO == [number isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"goods_id", goods_id );
		requestBody.APPEND( @"number", number );
		requestBody.APPEND( @"session", session );
		requestBody.APPEND( @"spec", spec );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=cart/create";
		NSString * requestURI = [NSString stringWithFormat:@"%@/cart/create", [ServerConfig sharedInstance].url];
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST cart/delete

DEF_MESSAGE_( cart_delete, msg )
{
	if ( msg.sending )
	{
		NSNumber * rec_id = msg.GET_INPUT( @"rec_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == rec_id || NO == [rec_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"rec_id", rec_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=cart/delete";
		NSString * requestURI = [NSString stringWithFormat:@"%@/cart/delete", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		TOTAL * total = [TOTAL objectFromDictionary:[response dictAtPath:@"total"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"total", total );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST cart/list

DEF_MESSAGE_( cart_list, msg )
{
	if ( msg.sending )
	{
        SESSION * session = msg.GET_INPUT( @"session" );
        
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=cart/list";
		NSString * requestURI = [NSString stringWithFormat:@"%@/cart/list", [ServerConfig sharedInstance].url];
		
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );;
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];
		NSArray * data_goods_list = [CART_GOODS objectsFromArray:[response arrayAtPath:@"data.goods_list"]];
		TOTAL * data_total = [TOTAL objectFromDictionary:[response dictAtPath:@"data.total"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

	 	msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
        msg.OUTPUT( @"data_goods_list", data_goods_list );
        msg.OUTPUT( @"data_total", data_total );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST cart/update

DEF_MESSAGE_( cart_update, msg )
{
	if ( msg.sending )
	{
		NSNumber * new_number = msg.GET_INPUT( @"new_number" );
		NSNumber * rec_id = msg.GET_INPUT( @"rec_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == new_number || NO == [new_number isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == rec_id || NO == [rec_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"new_number", new_number );
		requestBody.APPEND( @"rec_id", rec_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=cart/update";
		NSString * requestURI = [NSString stringWithFormat:@"%@/cart/update", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		TOTAL * total = [TOTAL objectFromDictionary:[response dictAtPath:@"total"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"total", total );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST category

DEF_MESSAGE_( category, msg )
{
	if ( msg.sending )
	{
		NSString * requestURI = [NSString stringWithFormat:@"%@/category", [ServerConfig sharedInstance].url];
		msg.HTTP_POST( requestURI );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [TOP_CATEGORY objectsFromArray:[response arrayAtPath:@"data"]];
		
		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}
		
		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST comments

DEF_MESSAGE_( comments, msg )
{
	if ( msg.sending )
	{
		NSNumber * goods_id = msg.GET_INPUT( @"goods_id" );
		PAGINATION * pagination = msg.GET_INPUT( @"pagination" );

		if ( nil == goods_id || NO == [goods_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"goods_id", goods_id );
		requestBody.APPEND( @"pagination", pagination );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=comments";
		NSString * requestURI = [NSString stringWithFormat:@"%@/comments", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [COMMENT objectsFromArray:[response arrayAtPath:@"data"]];
		PAGINATED * paginated = [PAGINATED objectFromDictionary:[response dictAtPath:@"paginated"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
		msg.OUTPUT( @"paginated", paginated );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST config

DEF_MESSAGE_( config, msg )
{
	if ( msg.sending )
	{
//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=config";
		NSString * requestURI = [NSString stringWithFormat:@"%@/config", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		CONFIG * config = [CONFIG objectFromDictionary:[response dictAtPath:@"data"]];
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];

		if ( nil == config || NO == [config isKindOfClass:[CONFIG class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"config", config );
		msg.OUTPUT( @"status", status );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST flow/checkOrder

DEF_MESSAGE_( flow_checkOrder, msg )
{
	if ( msg.sending )
	{
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=flow/checkOrder";
		NSString * requestURI = [NSString stringWithFormat:@"%@/flow/checkOrder", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];
        NSArray * data_bonus = [BONUS objectsFromArray:[response arrayAtPath:@"data.bonus"]];
		NSNumber * data_allow_use_bonus = [response numberAtPath:@"data.allow_use_bonus"];
		NSNumber * data_allow_use_integral = [response numberAtPath:@"data.allow_use_integral"];
		ADDRESS * data_consignee = [ADDRESS objectFromDictionary:[response dictAtPath:@"data.consignee"]];
		NSArray * data_goods_list = [CART_GOODS objectsFromArray:[response arrayAtPath:@"data.goods_list"]];
		NSArray * data_inv_content_list = [INVOICE objectsFromArray:[response arrayAtPath:@"data.inv_content_list"]];
		NSArray * data_inv_type_list = [INVOICE objectsFromArray:[response arrayAtPath:@"data.inv_type_list"]];
		NSNumber * data_order_max_integral = [response numberAtPath:@"data.order_max_integral"];
		NSArray * data_payment_list = [PAYMENT objectsFromArray:[response arrayAtPath:@"data.payment_list"]];
		NSArray * data_shipping_list = [SHIPPING objectsFromArray:[response arrayAtPath:@"data.shipping_list"]];
		NSNumber * data_your_integral = [response numberAtPath:@"data.your_integral"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

        msg.OUTPUT( @"status", status );
        msg.OUTPUT( @"data", data );
        msg.OUTPUT( @"data_bonus", data_bonus );        
        msg.OUTPUT( @"data_allow_use_bonus", data_allow_use_bonus );
        msg.OUTPUT( @"data_allow_use_integral", data_allow_use_integral );
        msg.OUTPUT( @"data_consignee", data_consignee );
        msg.OUTPUT( @"data_goods_list", data_goods_list );
        msg.OUTPUT( @"data_inv_content_list", data_inv_content_list );
        msg.OUTPUT( @"data_inv_type_list", data_inv_type_list );
        msg.OUTPUT( @"data_order_max_integral", data_order_max_integral );
        msg.OUTPUT( @"data_payment_list", data_payment_list );
        msg.OUTPUT( @"data_shipping_list", data_shipping_list );
        msg.OUTPUT( @"data_your_integral", data_your_integral );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST flow/done

DEF_MESSAGE_( flow_done, msg )
{
	if ( msg.sending )
	{
		NSNumber * pay_id = msg.GET_INPUT( @"pay_id" );
		SESSION * session = msg.GET_INPUT( @"session" );
		NSNumber * shipping_id = msg.GET_INPUT( @"shipping_id" );
		NSNumber * bonus = msg.GET_INPUT( @"bonus" );
		NSNumber * integral = msg.GET_INPUT( @"integral" );
		NSString * inv_content = msg.GET_INPUT( @"inv_content" );
		NSString * inv_payee = msg.GET_INPUT( @"inv_payee" );
		NSNumber * inv_type = msg.GET_INPUT( @"inv_type" );

		if ( nil == pay_id || NO == [pay_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == shipping_id || NO == [shipping_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"pay_id", pay_id );
		requestBody.APPEND( @"session", session );
		requestBody.APPEND( @"shipping_id", shipping_id );
		requestBody.APPEND( @"bonus", bonus );
		requestBody.APPEND( @"integral", integral );
		requestBody.APPEND( @"inv_content", inv_content );
		requestBody.APPEND( @"inv_payee", inv_payee );
		requestBody.APPEND( @"inv_type", inv_type );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=flow/done";
		NSString * requestURI = [NSString stringWithFormat:@"%@/flow/done", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];
		NSString * data_order_sn = [response stringAtPath:@"data.order_sn"];
        NSNumber * data_order_id = [response numberAtPath:@"data.order_id"];
		ORDER_INFO * order_info = [ORDER_INFO objectFromDictionary:[response dictAtPath:@"data.order_info"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
        msg.OUTPUT( @"data_order_sn", data_order_sn);
        msg.OUTPUT( @"data_order_id", data_order_id );
		msg.OUTPUT( @"order_info", order_info );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST goods

DEF_MESSAGE_( goods, msg )
{
	if ( msg.sending )
	{
		SESSION * session = msg.GET_INPUT( @"session" );
		NSNumber * goods_id = msg.GET_INPUT( @"goods_id" );

		if ( nil == goods_id || NO == [goods_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"session", session );
		requestBody.APPEND( @"goods_id", goods_id );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=goods";
		NSString * requestURI = [NSString stringWithFormat:@"%@/goods", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		GOODS * data = [GOODS objectFromDictionary:[response dictAtPath:@"data"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST goods/desc

DEF_MESSAGE_( goods_desc, msg )
{
	if ( msg.sending )
	{
		NSNumber * goods_id = msg.GET_INPUT( @"goods_id" );

		if ( nil == goods_id || NO == [goods_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"goods_id", goods_id );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=goods/desc";
		NSString * requestURI = [NSString stringWithFormat:@"%@/goods/desc", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSString * data = [response stringAtPath:@"data"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST home/category

DEF_MESSAGE_( home_category, msg )
{
	if ( msg.sending )
	{
//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=home/category";
		NSString * requestURI = [NSString stringWithFormat:@"%@/home/category", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [CATEGORY objectsFromArray:[response arrayAtPath:@"data"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST home/data

DEF_MESSAGE_( home_data, msg )
{
	if ( msg.sending )
	{
//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=home/data";
		NSString * requestURI = [NSString stringWithFormat:@"%@/home/data", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];
		NSArray * data_player = [BANNER objectsFromArray:[response arrayAtPath:@"data.player"]];
		NSArray * data_promote_goods = [SIMPLE_GOODS objectsFromArray:[response arrayAtPath:@"data.promote_goods"]];
        
		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
	msg.OUTPUT( @"data_player", data_player );
	msg.OUTPUT( @"data_promote_goods", data_promote_goods );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST order/affirmReceived

DEF_MESSAGE_( order_affirmReceived, msg )
{
	if ( msg.sending )
	{
		NSNumber * order_id = msg.GET_INPUT( @"order_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == order_id || NO == [order_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"order_id", order_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=order/affirmReceived";
		NSString * requestURI = [NSString stringWithFormat:@"%@/order/affirmReceived", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST order/cancel

DEF_MESSAGE_( order_cancel, msg )
{
	if ( msg.sending )
	{
		NSNumber * order_id = msg.GET_INPUT( @"order_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == order_id || NO == [order_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"order_id", order_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=order/cancel";
		NSString * requestURI = [NSString stringWithFormat:@"%@order/cancel", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST order/list

DEF_MESSAGE_( order_list, msg )
{
	if ( msg.sending )
	{
		SESSION * session = msg.GET_INPUT( @"session" );
		NSString * type = msg.GET_INPUT( @"type" );
		PAGINATION * pagination = msg.GET_INPUT( @"pagination" );

		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == type || NO == [type isKindOfClass:[NSString class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"session", session );
		requestBody.APPEND( @"type", type );
		requestBody.APPEND( @"pagination", pagination );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=order/list";
		NSString * requestURI = [NSString stringWithFormat:@"%@/order/list", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		PAGINATED * paginated = [PAGINATED objectFromDictionary:[response dictAtPath:@"paginated"]];
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [ORDER objectsFromArray:[response arrayAtPath:@"data"]];

		if ( nil == paginated || NO == [paginated isKindOfClass:[PAGINATED class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"paginated", paginated );
		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST order/pay

DEF_MESSAGE_( order_pay, msg )
{
	if ( msg.sending )
	{
		NSNumber * order_id = msg.GET_INPUT( @"order_id" );
		SESSION * session 	= msg.GET_INPUT( @"session" );

		if ( nil == order_id || NO == [order_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];

		requestBody.APPEND( @"order_id", order_id );
		requestBody.APPEND( @"session", session );

		NSString * requestURI = [NSString stringWithFormat:@"%@/order/pay", [ServerConfig sharedInstance].url];

		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;

		STATUS * status 	 = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSDictionary * data  = [response dictAtPath:@"data"];
		NSString * paywap 	 = [data stringAtPath:@"pay_wap"];
		NSString * upoptn 	 = [data stringAtPath:@"upop_tn"];
		NSString * payonline = [data stringAtPath:@"pay_online"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
		msg.OUTPUT( @"pay_wap", paywap );
		msg.OUTPUT( @"upop_tn", upoptn );
		msg.OUTPUT( @"pay_online", payonline );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST order/express

DEF_MESSAGE_( order_express, msg )
{
	if ( msg.sending )
	{
		NSNumber * order_id = msg.GET_INPUT( @"order_id" );
		NSString * app_key = msg.GET_INPUT( @"app_key" );
		SESSION * session = msg.GET_INPUT( @"session" );
        
        
		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"order_id", order_id );
		requestBody.APPEND( @"session", session );
		requestBody.APPEND( @"app_key", app_key );
        
//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=order/express";
		NSString * requestURI = [NSString stringWithFormat:@"%@/order/express", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
        // TDDO remove this test data;
//		NSDictionary * response = msg.responseJSONDictionary;
        NSString * s = @"{\"data\": {\"content\": [{\"time\": \"2014-01-19 18:24:00\",\"context\": \"快件已【签收】,签收人是【草签】,签收网点【河北唐山公司】\"},{\"time\": \"2014-01-19 18:12:10\",\"context\": \"快件已到达【河北唐山公司】，上一站是： 【】 扫描员是： 【王柏灵】\"},{\"time\": \"2014-01-18 18:25:55\",\"context\": \"【河北唐山公司】 已进行疑难件扫描，,疑难件原因 送无人,电话联系不上明日送，扫描员是： 【王柏灵】\"},{\"time\": \"2014-01-17 15:08:54\",\"context\": \"【河北唐山公司】 的派件员 【发往燕新路】 正在派件，扫描员是： 【陈艳】\"},{\"time\": \"2014-01-17 15:07:34\",\"context\": \"快件已到达【河北唐山公司】，上一站是： 【】 扫描员是： 【朱东芝】\"},{\"time\": \"2014-01-16 11:52:17\",\"context\": \"快件在 【北京中转部】 由 【网二扫描74】 扫描发往 【河北唐山公司】\"},{\"time\": \"2014-01-14 23:53:18\",\"context\": \"快件在 【上海航空部】 由 【郑刚强】 扫描发往 【河北唐山航空部】\"},{\"time\": \"2014-01-14 21:01:47\",\"context\": \"【上海松江公司】 已做装袋扫描，袋号： 900168437681，单号：768089232106\"},{\"time\": \"2014-01-14 21:01:47\",\"context\": \"快件在 【上海松江公司】 由 【航空2E】 扫描发往 【上海航空部】\"},{\"time\": \"2014-01-14 20:37:15\",\"context\": \"【上海松江公司】 的收件员 【茸北A线】已收件，扫描员是： 【3松江小件】\"}],\"shipping_name\": \"申通快递\"},\"status\": {\"succeed\": 1}}" ;
        NSDictionary * response = [s jk_objectFromJSONString];//[s objectFromJSONString];
		NSDictionary * data = [response dictAtPath:@"data"];
		NSArray * data_content = [EXPRESS objectsFromArray:[response arrayAtPath:@"data.content"]];
		NSString * data_shipping_name = [response stringAtPath:@"data.shipping_name"];
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        
		msg.OUTPUT( @"data", data );
        msg.OUTPUT( @"data_content", data_content );
        msg.OUTPUT( @"data_shipping_name", data_shipping_name );
		msg.OUTPUT( @"status", status );
        
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST region

DEF_MESSAGE_( region, msg )
{
	if ( msg.sending )
	{
		NSNumber * parent_id = msg.GET_INPUT( @"parent_id" );

		if ( nil == parent_id || NO == [parent_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"parent_id", parent_id );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=region";
		NSString * requestURI = [NSString stringWithFormat:@"%@/region", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [REGION objectsFromArray:[response arrayAtPath:@"data.regions"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST search

DEF_MESSAGE_( search, msg )
{
	if ( msg.sending )
	{
		FILTER * filter = msg.GET_INPUT( @"filter" );
		PAGINATION * pagination = msg.GET_INPUT( @"pagination" );

		if ( nil == filter || NO == [filter isKindOfClass:[FILTER class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		
		requestBody.APPEND( @"filter", filter );
		requestBody.APPEND( @"pagination", pagination );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=search";
		NSString * requestURI = [NSString stringWithFormat:@"%@/search", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [SIMPLE_GOODS objectsFromArray:[response arrayAtPath:@"data"]];
		PAGINATED * paginated = [PAGINATED objectFromDictionary:[response dictAtPath:@"paginated"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
		msg.OUTPUT( @"paginated", paginated );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST searchKeywords

DEF_MESSAGE_( searchKeywords, msg )
{
	if ( msg.sending )
	{
//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=searchKeywords";
		NSString * requestURI = [NSString stringWithFormat:@"%@/searchKeywords", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [response arrayAtPath:@"data"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST shopHelp

DEF_MESSAGE_( shopHelp, msg )
{
	if ( msg.sending )
	{
//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=shopHelp";
		NSString * requestURI = [NSString stringWithFormat:@"%@/shopHelp", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [ARTICLE_GROUP objectsFromArray:[response arrayAtPath:@"data"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST user/collect/create

DEF_MESSAGE_( user_collect_create, msg )
{
	if ( msg.sending )
	{
		NSNumber * goods_id = msg.GET_INPUT( @"goods_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == goods_id || NO == [goods_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"goods_id", goods_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=user/collect/create";
		NSString * requestURI = [NSString stringWithFormat:@"%@/user/collect/create", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST user/collect/delete

DEF_MESSAGE_( user_collect_delete, msg )
{
	if ( msg.sending )
	{
		NSNumber * rec_id = msg.GET_INPUT( @"rec_id" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == rec_id || NO == [rec_id isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"rec_id", rec_id );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=user/collect/delete";
		NSString * requestURI = [NSString stringWithFormat:@"%@/user/collect/delete", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST user/collect/list

DEF_MESSAGE_( user_collect_list, msg )
{
	if ( msg.sending )
	{
		SESSION * session = msg.GET_INPUT( @"session" );
		PAGINATION * pagination = msg.GET_INPUT( @"pagination" );

		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"session", session );
		requestBody.APPEND( @"pagination", pagination );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=user/collect/list";
		NSString * requestURI = [NSString stringWithFormat:@"%@/user/collect/list", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [COLLECT_GOODS objectsFromArray:[response arrayAtPath:@"data"]];
		PAGINATED * paginated = [PAGINATED objectFromDictionary:[response dictAtPath:@"paginated"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
		msg.OUTPUT( @"paginated", paginated );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST user/info

DEF_MESSAGE_( user_info, msg )
{
	if ( msg.sending )
	{
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=user/info";
		NSString * requestURI = [NSString stringWithFormat:@"%@/user/info", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		USER * data = [USER objectFromDictionary:[response dictAtPath:@"data"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST user/signin

DEF_MESSAGE_( user_signin, msg )
{
	if ( msg.sending )
	{
		NSString * name = msg.GET_INPUT( @"name" );
		NSString * password = msg.GET_INPUT( @"password" );

		if ( nil == name || NO == [name isKindOfClass:[NSString class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == password || NO == [password isKindOfClass:[NSString class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"name", name );
		requestBody.APPEND( @"password", password );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=user/signin";
		NSString * requestURI = [NSString stringWithFormat:@"%@/user/signin", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];
		SESSION * data_session = [SESSION objectFromDictionary:[response dictAtPath:@"data.session"]];
		USER * data_user = [USER objectFromDictionary:[response dictAtPath:@"data.user"]];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
		msg.OUTPUT( @"data_session", data_session );
		msg.OUTPUT( @"data_user", data_user );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST user/signup

DEF_MESSAGE_( user_signup, msg )
{
	if ( msg.sending )
	{
		// NSString * email = msg.GET_INPUT( @"email" );
        NSString * mobilePhone = msg.GET_INPUT( @"mobilePhone" );
		NSString * name = msg.GET_INPUT( @"name" );
		NSString * password = msg.GET_INPUT( @"password" );
        NSString * nickname = msg.GET_INPUT( @"nickname" );
        NSNumber * schoolId = msg.GET_INPUT( @"schoolId" );
        NSNumber * gradeId = msg.GET_INPUT( @"gradeId" );
        NSNumber * classId = msg.GET_INPUT( @"classId" );
//		if ( nil == email || NO == [email isKindOfClass:[NSString class]] )
//		{
//			msg.failed = YES;
//			return;
//		}
		if ( nil == name || NO == [name isKindOfClass:[NSString class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == password || NO == [password isKindOfClass:[NSString class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		// requestBody.APPEND( @"email", email );
        requestBody.APPEND( @"mobilePhone", mobilePhone);
		requestBody.APPEND( @"name", name );
		requestBody.APPEND( @"password", password );
		requestBody.APPEND( @"nickname", nickname );
        requestBody.APPEND( @"studentSchool", schoolId );
        requestBody.APPEND( @"studentGrade", gradeId );
        requestBody.APPEND( @"studentClass", classId );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=user/signup";
		NSString * requestURI = [NSString stringWithFormat:@"%@/user/signup", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		SESSION * session = [SESSION objectFromDictionary:[response dictAtPath:@"data.session"]];
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		USER * user = [USER objectFromDictionary:[response dictAtPath:@"data.user"]];

		INFO( status.error_desc );
		
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == user || NO == [user isKindOfClass:[USER class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"data_session", session );
		msg.OUTPUT( @"data_status", status );
		msg.OUTPUT( @"data_user", user );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

DEF_MESSAGE_ ( teacher_signup, msg )
{
    if( msg.sending )
    {
        NSString * mobilePhone = msg.GET_INPUT( @"mobilePhone" );
        NSString * name = msg.GET_INPUT( @"name" );
        NSString * invite_user_id = msg.GET_INPUT( @"invite_user_id");
        NSString * password = msg.GET_INPUT( @"password" );
        NSArray * field = msg.GET_INPUT( @"field" );
        NSString * realname = msg.GET_INPUT( @"realname" );
        NSString * school = msg.GET_INPUT( @"school" );
        NSString * course = msg.GET_INPUT( @"course" );
        NSNumber * isTeacher = msg.GET_INPUT( @"isTeacher" );
        NSString * country = msg.GET_INPUT( @"country" );
        NSString * provinceName = msg.GET_INPUT( @"provinceId" );
        NSString * cityName = msg.GET_INPUT( @"cityId" );
        NSString * townName = msg.GET_INPUT( @"townId" );
        NSString * grade = msg.GET_INPUT( @"grade" );
        NSString * teacherClass = msg.GET_INPUT( @"class" );
        
        if ( nil == name || NO == [name isKindOfClass:[NSString class]] )
        {
            msg.failed = YES;
            return;
        }
        if ( nil == password || NO == [password isKindOfClass:[NSString class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"mobilePhone", mobilePhone);
        requestBody.APPEND( @"name", name );
        requestBody.APPEND( @"invite_user_id", invite_user_id );
        requestBody.APPEND( @"password", password );
        requestBody.APPEND( @"field", field );
        requestBody.APPEND( @"realname", realname );
        requestBody.APPEND( @"school", school );
        requestBody.APPEND( @"course", course );
        requestBody.APPEND( @"isTeacher", isTeacher );
        requestBody.APPEND( @"country", country );
        requestBody.APPEND( @"provinceName", provinceName );
        requestBody.APPEND( @"cityName", cityName );
        requestBody.APPEND( @"townName", townName );
        requestBody.APPEND( @"teacherGrade", grade );
        requestBody.APPEND( @"teacherClass", teacherClass );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/signup", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        SESSION * session = [SESSION objectFromDictionary:[response dictAtPath:@"data.session"]];
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        USER * user = [USER objectFromDictionary:[response dictAtPath:@"data.user"]];
        
        INFO( status.error_desc );
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        if ( nil == user || NO == [user isKindOfClass:[USER class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"data_session", session );
        msg.OUTPUT( @"data_status", status );
        msg.OUTPUT( @"data_user", user );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( get_course, msg )
{
    if( msg.sending )
    {
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/course", [ServerConfig sharedInstance].url];
        NSNumber * student_id = msg.GET_INPUT( @"student_id" );
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"student_id", student_id);
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );

    }
    else if( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        Course * data = [Course objectFromDictionary:[response dictAtPath:@"data"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"status", status );
        msg.OUTPUT( @"data", data );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( course, msg )
{
    if( msg.sending )
    {
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/course", [ServerConfig sharedInstance].url];
        msg.HTTP_POST( requestURI );
    }
    else if( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        Course * data = [Course objectFromDictionary:[response dictAtPath:@"data"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"status", status );
        msg.OUTPUT( @"data", data );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( get_teacher, msg )
{
    if( msg.sending )
    {
        NSNumber * student_id = msg.GET_INPUT( @"student_id" );
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/followedTeacher", [ServerConfig sharedInstance].url];
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"student_id", student_id);
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        Teacher * data = [Teacher objectFromDictionary:[response dictAtPath:@"data"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"status", status );
        msg.OUTPUT( @"data", data );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( get_region, msg )
{
    if ( msg.sending )
    {
        NSString * parent_id = msg.GET_INPUT( @"parent_id" );
        if (parent_id == nil )
        {
            parent_id = @"1";
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"parent_id", parent_id);
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/region", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSArray * data = [REGION objectsFromArray:[response arrayAtPath:@"data.regions"]];
        NSNumber * region_type;
        if (data) {
            REGION * region = [data objectAtIndex:0];
            region_type = @([region.type integerValue]);
        }
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"status", status );
        msg.OUTPUT( @"data", data );
        msg.OUTPUT( @"region_type", region_type );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

#pragma mark - POST user/signupFields

DEF_MESSAGE_( user_signupFields, msg )
{
	if ( msg.sending )
	{
//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=user/signupFields";
		NSString * requestURI = [NSString stringWithFormat:@"%@/user/signupFields", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI );
	}
	else if ( msg.succeed )
	{

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST validate/bonus

DEF_MESSAGE_( validate_bonus, msg )
{
	if ( msg.sending )
	{
		NSString * bonus_sn = msg.GET_INPUT( @"bonus_sn" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == bonus_sn || NO == [bonus_sn isKindOfClass:[NSString class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"bonus_sn", bonus_sn );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=validate/bonus";
		NSString * requestURI = [NSString stringWithFormat:@"%@/validate/bonus", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];
		NSString * data_bonus_formated = [response stringAtPath:@"data.bonus_formated"];
		NSString * data_bonus = [response stringAtPath:@"data.bonus"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
        msg.OUTPUT( @"data_bonus_formated", data_bonus_formated );
        msg.OUTPUT( @"data_bonus", data_bonus );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma nhj - POST search user
DEF_MESSAGE_( search_user, msg )
{
    if ( msg.sending )
    {
        NSString * name = msg.GET_INPUT( @"name" );
        NSNumber * course_id = msg.GET_INPUT( @"course_id" );
        NSNumber * user_id = msg.GET_INPUT( @"user_id" );
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"name", name );
        requestBody.APPEND( @"course_id", course_id );
        requestBody.APPEND( @"user_id", user_id);
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/searchTeacher", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSArray * data = [TEACHER_INFO objectsFromArray:[response arrayAtPath:@"data"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"data", data );
    }
    else if ( msg.failed )
    {
    }
    else if (msg.cancelled )
    {
    }
}

#pragma nhj - POST  执行关注
DEF_MESSAGE_( add_follow, msg )
{
    if ( msg.sending )
    {
        NSNumber * teacher_user_id = msg.GET_INPUT( @"teacher_user_id" );
        NSNumber * student_user_id = msg.GET_INPUT( @"student_user_id" );
        NSNumber * course_id = msg.GET_INPUT( @"course_id" );
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"teacher_user_id", teacher_user_id );
        requestBody.APPEND( @"student_user_id", student_user_id );
        requestBody.APPEND( @"course_id", course_id );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/addFollow", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSString * is_followed = [response stringAtPath:@"data.is_followed"];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"data", is_followed );
    }
    else if ( msg.failed )
    {
    }
    else if (msg.cancelled )
    {
    }
}

#pragma nhj - POST  取消关注
DEF_MESSAGE_( cancel_follow, msg )
{
    if ( msg.sending )
    {
        NSNumber * student_user_id = msg.GET_INPUT( @"student_user_id" );
        NSNumber * course_id = msg.GET_INPUT( @"course_id" );
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"student_user_id", student_user_id );
        requestBody.APPEND( @"course_id", course_id );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/cancelFollow", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSString * canceled = [response stringAtPath:@"data.canceled"];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"data", canceled );
    }
    else if ( msg.failed )
    {
    }
    else if (msg.cancelled )
    {
    }
}

#pragma nhj - POST  查询教师积分
DEF_MESSAGE_( get_integral, msg )
{
    if ( msg.sending )
    {
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        SESSION * session = msg.GET_INPUT( @"session" );
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        requestBody.APPEND( @"session", session );
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/getIntegral", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        TEACHER_INTEGRAL * data = [TEACHER_INTEGRAL objectFromDictionary:[response dictAtPath:@"data"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"data", data );
    }
    else if ( msg.failed )
    {
    }
    else if (msg.cancelled )
    {
    }
}

#pragma mark - POST validate/integral

DEF_MESSAGE_( validate_integral, msg )
{
	if ( msg.sending )
	{
		NSNumber * integral = msg.GET_INPUT( @"integral" );
		SESSION * session = msg.GET_INPUT( @"session" );

		if ( nil == integral || NO == [integral isKindOfClass:[NSNumber class]] )
		{
			msg.failed = YES;
			return;
		}
		if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
		{
			msg.failed = YES;
			return;
		}

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"integral", integral );
		requestBody.APPEND( @"session", session );

//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=validate/integral";
		NSString * requestURI = [NSString stringWithFormat:@"%@/validate/integral", [ServerConfig sharedInstance].url];
		
		msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSDictionary * data = [response dictAtPath:@"data"];
		NSString * data_bonus_formated = [response stringAtPath:@"data.bonus_formated"];
		NSNumber * data_bonus = [response numberAtPath:@"data.bonus"];

		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
	msg.OUTPUT( @"data_bonus_formated", data_bonus_formated );
	msg.OUTPUT( @"data_bonus", data_bonus );

	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST brand

DEF_MESSAGE_( brand, msg )
{
	if ( msg.sending )
	{
//		NSString * requestURI = @"http://shop.ecmobile.me/ecmobile/?url=brand";
		NSString * requestURI = [NSString stringWithFormat:@"%@/brand", [ServerConfig sharedInstance].url];

		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"category_id", msg.GET_INPUT( @"category_id" ) );
        
        NSNumber * category_id = msg.GET_INPUT( @"category_id" );
        
        if ( nil != category_id || NO != [category_id isKindOfClass:[NSNumber class]] )
		{
            requestBody.APPEND( @"category_id", category_id );
            msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
		}
        else
        {
            msg.HTTP_POST( requestURI );
        }
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSArray * data = [BRAND objectsFromArray:[response arrayAtPath:@"data"]];
        
		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}

		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

#pragma mark - POST price_range

DEF_MESSAGE_( price_range, msg )
{
	if ( msg.sending )
	{
		NSString * requestURI = [NSString stringWithFormat:@"%@/price_range", [ServerConfig sharedInstance].url];
		
		NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
		requestBody.APPEND( @"category_id", msg.GET_INPUT( @"category_id" ) );
        
        NSNumber * category_id = msg.GET_INPUT( @"category_id" );
        
        if ( nil != category_id || NO != [category_id isKindOfClass:[NSNumber class]] )
		{
            requestBody.APPEND( @"category_id", category_id );
            msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
		}
        else
        {
            msg.HTTP_POST( requestURI );
        }
	}
	else if ( msg.succeed )
	{
		NSDictionary * response = msg.responseJSONDictionary;
		STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
		NSArray * data = [PRICE_RANGE objectsFromArray:[response arrayAtPath:@"data"]];
        
		if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
		{
			msg.failed = YES;
			return;
		}
        
		msg.OUTPUT( @"status", status );
		msg.OUTPUT( @"data", data );
	}
	else if ( msg.failed )
	{
	}
	else if ( msg.cancelled )
	{
	}
}

DEF_MESSAGE_( getIdentifyCode, msg)
{
    if( msg.sending )
    {
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/SendTemplateSMS", [ServerConfig sharedInstance].url];
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"mobilePhone", msg.GET_INPUT( @"mobilePhone" ) );
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        identifyCode * data = [identifyCode objectFromDictionary:[response dictAtPath:@"data"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"status", status );
        msg.OUTPUT( @"data", data );
    }
    else if( msg.failed )
    {
    }
    else if( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( checkUser, msg )
{
    if( msg.sending )
    {
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/checkUser", [ServerConfig sharedInstance].url];
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"username", msg.GET_INPUT( @"name" ) );
        requestBody.APPEND( @"inviteCode", msg.GET_INPUT( @"inviteCode" ));
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        CHECK_USER_INFO * info = [CHECK_USER_INFO objectFromDictionary:[response dictAtPath:@"data"]];
        
        if ( nil == info )
        {
            msg.failed = YES;
            return;
        }
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"info", info );
        msg.OUTPUT( @"status", status );
    }
    else if( msg.failed )
    {
    }
    else if( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( getSign, msg )
{
    if( msg.sending )
    {
        NSString * requestURI = [NSString stringWithFormat:@"%@/get_sign", [ServerConfig sharedInstance].url];
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"content", msg.GET_INPUT( @"order_id" ) );
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        NSString * signedString = [response stringAtPath:@"data.sign"];
        if ( signedString == nil )
        {
            msg.failed = YES;
            return;
        }
        msg.OUTPUT(@"signedString", signedString);
    }
    else if( msg.failed )
    {
    }
    else if( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( moments_list, msg )
{
    if ( msg.sending )
    {
        SESSION * session = msg.GET_INPUT( @"session" );
        PAGINATION * pagination = msg.GET_INPUT( @"pagination" );
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        requestBody.APPEND( @"pagination", pagination );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/moments_list", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        NSString * no_follow = [response stringAtPath:@"data.no_follow"];
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        PAGINATED * paginated = [PAGINATED objectFromDictionary:[response dictAtPath:@"paginated"]];
        NSArray * data = [MOMENTS objectsFromArray:[response arrayAtPath:@"data.info"]];
        // 就这么着去用comment info吧
//        MOMENTS * a = data[1];
//        NSArray * c = a.publish_info.comment_array;
//        COMMENT_INFO * b = a.publish_info.comment_array[0];
//        NSLog(@"%@", b.show_name);
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
            
        if ( nil == paginated || NO == [paginated isKindOfClass:[PAGINATED class]] )
        {
            msg.failed = YES;
            return;
        }

        msg.OUTPUT( @"paginated", paginated );
        msg.OUTPUT( @"status", status );
        msg.OUTPUT( @"no_follow", no_follow );
        msg.OUTPUT( @"data", data );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}


DEF_MESSAGE_(moments_delete,msg )
{
    if ( msg.sending )
    {
        SESSION * session = msg.GET_INPUT( @"session" );
        NSString * publish_time = msg.GET_INPUT( @"publish_time" );
        NSString * publish_uid = msg.GET_INPUT(@"publish_uid");
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        requestBody.APPEND( @"publish_time", publish_time );
        requestBody.APPEND(@"publish_uid", publish_uid);
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/interaction/delete_one_comment", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        
        msg.OUTPUT( @"status", status );
        
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( teacher_publish, msg )
{
    if ( msg.sending )
    {
        SESSION * session = msg.GET_INPUT( @"session" );
        NSString * curTime = msg.GET_INPUT( @"time" );
        curTime = [curTime trim];
        NSString * content = msg.GET_INPUT( @"content" );
        NSArray *imageArray = msg.GET_INPUT( @"publish_images");
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        requestBody.APPEND( @"time", curTime );
        requestBody.APPEND( @"content", content );
        requestBody.APPEND( @"publish_images", imageArray);
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/teacher_publish", [ServerConfig sharedInstance].url];
        NSString *json = [self makeJsonWithSession:session andTime:curTime andContent:content andImageArray:imageArray];
        msg.HTTP_POST( requestURI ).PARAM( @"json", json );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        NSLog(@"%@", response[@"status"][@"error_desc"]);
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSString * data = [response stringAtPath:@"data"];

        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"status", status );
        msg.OUTPUT( @"data", @"1" );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_(moments_comment,msg )
{
    if ( msg.sending )
    {
        SESSION * session = msg.GET_INPUT( @"session" );
        NSNumber * target_comment_id = msg.GET_INPUT( @"target_comment_id" );
        NSNumber * news_id = msg.GET_INPUT( @"news_id" );
        NSString * comment_content = msg.GET_INPUT( @"comment_content" );
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        requestBody.APPEND( @"target_comment_id", target_comment_id );
        requestBody.APPEND( @"comment_content", comment_content );
        requestBody.APPEND( @"news_id", news_id);
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/interaction/comment_publish", [ServerConfig sharedInstance].url];
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        // 我不知道返回值是什么，成功之后的结果等接口测试看吧
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"status", status );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

-(NSString*)makeJsonWithSession:(SESSION*)session andTime:(NSString*)time andContent:(NSString*)content andImageArray:(NSArray*)imageArray
{
    NSDictionary *jsonDic = @{
                              @"session": @{@"sid":session.sid, @"uid":session.uid},
                              @"time": time,
                              @"content": content,
                              @"publish_images": imageArray
                              };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}
DEF_MESSAGE_( post_avatar, msg )
{
    if ( msg.sending )
    {
        SESSION * session = msg.GET_INPUT( @"session" );
        NSString * avatar = msg.GET_INPUT( @"avatar" );
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        requestBody.APPEND( @"avatar", avatar );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/post_avatar", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"status", status );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( search_payment, msg )
{
    if ( msg.sending )
    {
        SESSION * session = msg.GET_INPUT( @"session" );
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/flow/searchPayment", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSArray * data = [PAYMENT_INFO objectsFromArray:[response arrayAtPath:@"data"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        
        if ( data == nil )
        {
            msg.failed = YES;
            return;
        }
        
        msg.OUTPUT( @"data", data );
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( writePayId, msg )
{
    if ( msg.sending )
    {
        NSString * order_sn = msg.GET_INPUT( @"order_sn" );
        NSString * pay_code = msg.GET_INPUT( @"pay_code" );
        SESSION * session = msg.GET_INPUT( @"session" );
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        requestBody.APPEND( @"order_sn", order_sn );
        requestBody.APPEND( @"pay_code", pay_code );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/flow/writePayId", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( returnGoods, msg )
{
    if ( msg.sending )
    {
        NSString * rec_id = msg.GET_INPUT( @"rec_id" );
        NSString * refund_desc = msg.GET_INPUT( @"refund_desc" );
        NSString * refund_reason = msg.GET_INPUT( @"refund_reason" );
        SESSION * session = msg.GET_INPUT( @"session" );
        
        if ( nil == session || NO == [session isKindOfClass:[SESSION class]] )
        {
            msg.failed = YES;
            return;
        }
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        requestBody.APPEND( @"rec_id", rec_id );
        requestBody.APPEND( @"refund_reason", refund_reason );
        requestBody.APPEND( @"refund_desc", refund_desc );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/order/goods_return", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        msg.OUTPUT(@"status", status);
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( returnReason, msg )
{
    if ( msg.sending )
    {
        NSString * requestURI = [NSString stringWithFormat:@"%@/order/return_reason", [ServerConfig sharedInstance].url];
        
        msg.HTTP_POST( requestURI );
    }
    else if ( msg.succeed )
    {
        NSDictionary * response = msg.responseJSONDictionary;
        
        STATUS * status = [STATUS objectFromDictionary:[response dictAtPath:@"status"]];
        NSArray * data = [[NSArray alloc] initWithArray:[response objectAtPath:@"data"]];
        
        if ( nil == status || NO == [status isKindOfClass:[STATUS class]] )
        {
            msg.failed = YES;
            return;
        }
        msg.OUTPUT(@"status", status);
        msg.OUTPUT(@"reasonArray", data);
    }
    else if ( msg.failed )
    {
    }
    else if ( msg.cancelled )
    {
    }
}

DEF_MESSAGE_( updateVersion, msg )
{
    if (msg.sending) {
        
        NSString * version = msg.GET_INPUT(@"version");
        NSNumber * client_type = [NSNumber numberWithInteger:1];
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"version", version );
        requestBody.APPEND( @"client_type", client_type );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/version/updateversion",[ServerConfig sharedInstance].url2];
                                 
        msg.HTTP_POST( requestURI ).PARAM( requestBody );
    } else if (msg.succeed) {
        
        NSDictionary * responseDict = msg.responseJSONDictionary;
        
        NSNumber * code = responseDict[@"code"];
        UPDATE_VERSION_INFO * data = [UPDATE_VERSION_INFO objectFromDictionary:responseDict[@"data"]];
        NSString * message = responseDict[@"message"];
        
        msg.OUTPUT(@"code", code);
        msg.OUTPUT(@"data", data);
        msg.OUTPUT(@"message", message);
    } else if (msg.failed) {
        
        
    } else if (msg.cancelled) {
        
        
    }
}

DEF_MESSAGE_( getNews, msg )
{
    if (msg.sending) {
        
        NSNumber * cpage = msg.GET_INPUT(@"cpage");
        NSNumber * pagesize = msg.GET_INPUT(@"pagesize");
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"cpage", cpage );
        requestBody.APPEND( @"pagesize", pagesize );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/getnews/detail", [ServerConfig sharedInstance].url2];
        
        msg.HTTP_POST( requestURI ).PARAM( requestBody );
    } else if (msg.succeed) {
        
        NSDictionary * responseDict = msg.responseJSONDictionary;
        
        NSNumber * code = responseDict[@"code"];
        NSString * message = responseDict[@"message"];
        NSNumber * total_page = responseDict[@"data"][@"total_page"];
        NSArray * data = [NEWS_DETAIL objectsFromArray:responseDict[@"data"][@"info"]];

        msg.OUTPUT(@"code", code);
        msg.OUTPUT(@"message", message);
        msg.OUTPUT(@"total_page", total_page);
        msg.OUTPUT(@"data", data);
    } else if (msg.failed) {
        
        
    } else if (msg.cancelled) {
        
        
    }
}

DEF_MESSAGE_( getSchool, msg )
{
    if (msg.sending) {
        
        NSNumber * schoolRegion = msg.GET_INPUT(@"school_region");
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"school_region", schoolRegion );
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/school", [ServerConfig sharedInstance].url];
        msg.HTTP_POST( requestURI ).PARAM( requestBody );
    } else if (msg.succeed) {
        
        NSDictionary * responseDict = msg.responseJSONDictionary;
        NSArray * data = [Register_school objectsFromArray:responseDict[@"data"]];
        
        msg.OUTPUT(@"data", data);
    } else if (msg.cancelled) {
        
    } else if (msg.failed) {
        
    }

}

DEF_MESSAGE_( getGrade, msg )
{
    if (msg.sending) {
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/grade", [ServerConfig sharedInstance].url];
        msg.HTTP_POST( requestURI );
    } else if (msg.succeed) {
        
        NSDictionary * responseDict = msg.responseJSONDictionary;
        NSArray * data = [Register_grade objectsFromArray:responseDict[@"data"]];
        
        msg.OUTPUT(@"data", data);
    } else if (msg.cancelled) {
        
    } else if (msg.failed) {
        
    }
}


DEF_MESSAGE_( getTeacherClass, msg)
{
    if (msg.sending) {
        SESSION * session = msg.GET_INPUT( @"session" );
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/teacher_class_info", [ServerConfig sharedInstance].url];
        
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        
        
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    } else if (msg.succeed) {
        
        NSDictionary * responseDict = msg.responseJSONDictionary;
        NSArray * data = [TEACHER_CLASS objectsFromArray:responseDict[@"data"]];
        msg.OUTPUT(@"data", data);
        msg.OUTPUT(@"success", responseDict[@"succeed"]);
    } else if (msg.cancelled) {
        
    } else if (msg.failed) {
        
    }
}

DEF_MESSAGE_( getStudentPoint, msg)
{
    if (msg.sending) {
        SESSION * session = msg.GET_INPUT( @"session" );
        NSNumber * info_id = msg.GET_INPUT( @"info_id");
        NSString * requestURI = [NSString stringWithFormat:@"%@/user/student_point_info", [ServerConfig sharedInstance].url];
        NSMutableDictionary * requestBody = [NSMutableDictionary dictionary];
        requestBody.APPEND( @"session", session );
        requestBody.APPEND( @"info_id", info_id);
        msg.HTTP_POST( requestURI ).PARAM( @"json", requestBody.objectToString );
    } else if (msg.succeed) {
        
        NSDictionary * responseDict = msg.responseJSONDictionary;
        NSArray * data = [STUDENT_POINT objectsFromArray:responseDict[@"data"]];
        msg.OUTPUT(@"data", data);
        msg.OUTPUT(@"success", responseDict[@"succeed"]);
        
    } else if (msg.cancelled) {
        
    } else if (msg.failed) {
        
    }
}


@end


#pragma mark - config

@implementation ServerConfig

DEF_SINGLETON( ServerConfig )

@synthesize url = _url;

@synthesize url2 = _url2;

@synthesize pay_url = _pay_url;

@end
