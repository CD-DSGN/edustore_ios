//    												
//    												
//    	 ______    ______    ______					
//    	/\  __ \  /\  ___\  /\  ___\
//    	\ \  __<  \ \  __\_ \ \  __\_		
//    	 \ \_____\ \ \_____\ \ \_____\
//    	  \/_____/  \/_____/  \/_____/			
//    												
//    												
//    												
// title:  Ecmobile.cn
// author: GeekZoo Studio
// date:   2014-02-18 08:04:23 +0000
//

#import "Bee.h"

#pragma mark - enums

enum ECM_ERROR_CODE
{
	ECM_ERROR_CODE_OK = 0,
	ECM_ERROR_CODE_BAD_REQUEST = 400,
	ECM_ERROR_CODE_AUTH_FAIL = 401,
	ECM_ERROR_CODE_NOT_FOUND = 404,
	ECM_ERROR_CODE_AUTH_EXPIRED = 410,
	ECM_ERROR_CODE_UNKNOWN_ERROR = 500,
};

enum ECM_PUSH_STATUS
{
	ECM_PUSH_STATUS_OFF = 0,
	ECM_PUSH_STATUS_ON = 1,
};

#pragma mark - models

@class ECM_ALIPAY_KEY;
@class ECM_BAE_PUSH_KEY;
@class ECM_CONFIG;
@class ECM_LOCATION;
@class ECM_MESSAGE;
@class ECM_TENCENT_KEY;
@class ECM_WEIBO_KEY;
@class ECM_WEIXIN_KEY;

@interface ECM_ALIPAY_KEY : BeeActiveObject
@property (nonatomic, retain) NSString *			callback;
@property (nonatomic, retain) NSString *			key;
@property (nonatomic, retain) NSString *			parterID;
@property (nonatomic, retain) NSString *			rsa_private;
@property (nonatomic, retain) NSString *			rsa_alipay_public;
@property (nonatomic, retain) NSString *			sellerID;
@end

@interface ECM_BAE_PUSH_KEY : BeeActiveObject
@property (nonatomic, retain) NSString *			api_key;
@property (nonatomic, retain) NSString *			secret_key;
@end

@interface ECM_CONFIG : BeeActiveObject
@property (nonatomic, retain) ECM_ALIPAY_KEY *			alipay_key;
@property (nonatomic, retain) ECM_BAE_PUSH_KEY *			bae_push_key;
@property (nonatomic, retain) NSString *			kuaidi100_key;
@property (nonatomic, retain) NSString *			ifly_aos_key;
@property (nonatomic, retain) NSString *			ifly_ios_key;
@property (nonatomic, retain) NSString *			site_url;
@property (nonatomic, retain) ECM_TENCENT_KEY *			tencent_key;
@property (nonatomic, retain) NSString *			umeng_aos_key;
@property (nonatomic, retain) NSString *			umeng_ios_key;
@property (nonatomic, retain) ECM_WEIBO_KEY *			weibo_key;
@property (nonatomic, retain) ECM_WEIXIN_KEY *			weixin_key;

@property (nonatomic, retain) NSString *                app_ID;
@property (nonatomic, retain) NSString *                app_Key;
@end

@interface ECM_LOCATION : BeeActiveObject
@property (nonatomic, retain) NSNumber *			lat;
@property (nonatomic, retain) NSNumber *			lon;
@end

@interface ECM_MESSAGE : BeeActiveObject
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSString *			custom_data;
@property (nonatomic, retain) NSNumber *			id;
@end

@interface ECM_TENCENT_KEY : BeeActiveObject
@property (nonatomic, retain) NSString *			app_key;
@property (nonatomic, retain) NSString *			app_secret;
@property (nonatomic, retain) NSString *			callback;
@end

@interface ECM_WEIBO_KEY : BeeActiveObject
@property (nonatomic, retain) NSString *			app_key;
@property (nonatomic, retain) NSString *			app_secret;
@property (nonatomic, retain) NSString *			callback;
@end

@interface ECM_WEIXIN_KEY : BeeActiveObject
@property (nonatomic, retain) NSString *			app_id;
@property (nonatomic, retain) NSString *			app_key;
@property (nonatomic, retain) NSString *            partner_id;
@end

#pragma mark - controllers

#pragma mark - FORM /app/config

@interface ECM_REQ_APP_CONFIG : BeeActiveObject
@property (nonatomic, retain) NSString *			APPID;
@property (nonatomic, retain) NSString *			APPKEY;
@property (nonatomic, retain) NSString *			platform;
@end

@interface ECM_RESP_APP_CONFIG : BeeActiveObject
@property (nonatomic, retain) ECM_CONFIG *			config;
@property (nonatomic, retain) NSNumber *			error_code;
@property (nonatomic, retain) NSString *			error_desc;
@property (nonatomic, retain) NSNumber *			succeed;
@end

@interface ECM_API_APP_CONFIG : BeeAPI
@property (nonatomic, retain) ECM_REQ_APP_CONFIG *	req;
@property (nonatomic, retain) ECM_RESP_APP_CONFIG *	resp;
@end

#pragma mark - FORM /push/config

@interface ECM_REQ_PUSH_CONFIG : BeeActiveObject
@property (nonatomic, retain) NSString *			APPID;
@property (nonatomic, retain) NSString *			APPKEY;
@property (nonatomic, retain) NSString *			UUID;
@property (nonatomic, retain) NSNumber *			push_switch;
@end

@interface ECM_RESP_PUSH_CONFIG : BeeActiveObject
@property (nonatomic, retain) NSNumber *			error_code;
@property (nonatomic, retain) NSString *			error_desc;
@property (nonatomic, retain) NSNumber *			push;
@property (nonatomic, retain) NSNumber *			succeed;
@end

@interface ECM_API_PUSH_CONFIG : BeeAPI
@property (nonatomic, retain) ECM_REQ_PUSH_CONFIG *	req;
@property (nonatomic, retain) ECM_RESP_PUSH_CONFIG *	resp;
@end

#pragma mark - FORM /push/messages

@interface ECM_REQ_PUSH_MESSAGES : BeeActiveObject
@property (nonatomic, retain) NSString *			APPID;
@property (nonatomic, retain) NSString *			APPKEY;
@property (nonatomic, retain) NSString *			UUID;
@property (nonatomic, retain) NSNumber *			count;
@property (nonatomic, retain) NSString *			last_id;
@end

@interface ECM_RESP_PUSH_MESSAGES : BeeActiveObject
@property (nonatomic, retain) NSNumber *			error_code;
@property (nonatomic, retain) NSString *			error_desc;
@property (nonatomic, retain) NSArray *				messages;
@property (nonatomic, retain) NSNumber *			succeed;
@property (nonatomic, retain) NSNumber *			total;
@end

@interface ECM_API_PUSH_MESSAGES : BeeAPI
@property (nonatomic, retain) ECM_REQ_PUSH_MESSAGES *	req;
@property (nonatomic, retain) ECM_RESP_PUSH_MESSAGES *	resp;
@end

#pragma mark - FORM /push/register

@interface ECM_REQ_PUSH_REGISTER : BeeActiveObject
@property (nonatomic, retain) NSString *			APPID;
@property (nonatomic, retain) NSString *			APPKEY;
@property (nonatomic, retain) NSString *			UUID;
@property (nonatomic, retain) ECM_LOCATION *			location;
@property (nonatomic, retain) NSString *			os;
@property (nonatomic, retain) NSString *			platform;
@property (nonatomic, retain) NSString *			push_token;
@end

@interface ECM_RESP_PUSH_REGISTER : BeeActiveObject
@property (nonatomic, retain) NSNumber *			error_code;
@property (nonatomic, retain) NSString *			error_desc;
@property (nonatomic, retain) NSNumber *			push;
@property (nonatomic, retain) NSNumber *			succeed;
@end

@interface ECM_API_PUSH_REGISTER : BeeAPI
@property (nonatomic, retain) ECM_REQ_PUSH_REGISTER *	req;
@property (nonatomic, retain) ECM_RESP_PUSH_REGISTER *	resp;
@end

#pragma mark - FORM /push/unread-count

@interface ECM_REQ_PUSH_UNREAD_COUNT : BeeActiveObject
@property (nonatomic, retain) NSString *			APPID;
@property (nonatomic, retain) NSString *			APPKEY;
@property (nonatomic, retain) NSString *			UUID;
@property (nonatomic, retain) NSString *			last_id;
@end

@interface ECM_RESP_PUSH_UNREAD_COUNT : BeeActiveObject
@property (nonatomic, retain) NSNumber *			error_code;
@property (nonatomic, retain) NSString *			error_desc;
@property (nonatomic, retain) NSNumber *			succeed;
@property (nonatomic, retain) NSString *			unread;
@end

@interface ECM_API_PUSH_UNREAD_COUNT : BeeAPI
@property (nonatomic, retain) ECM_REQ_PUSH_UNREAD_COUNT *	req;
@property (nonatomic, retain) ECM_RESP_PUSH_UNREAD_COUNT *	resp;
@end

#pragma mark - config

@interface ECM_ServerConfig : NSObject

AS_SINGLETON( ECM_ServerConfig )

AS_INT( CONFIG_DEVELOPMENT )
AS_INT( CONFIG_TEST )
AS_INT( CONFIG_PRODUCTION )

@property (nonatomic, assign) NSUInteger			config;

@property (nonatomic, readonly) NSString *			url;
@property (nonatomic, readonly) NSString *			testUrl;
@property (nonatomic, readonly) NSString *			productionUrl;
@property (nonatomic, readonly) NSString *			developmentUrl;

@end

