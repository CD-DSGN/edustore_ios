//
// ECMobile (Geek-Zoo Studio)
//
// generated at 2013-06-17 05:47:47 +0000
//

#import "Bee.h"

#pragma mark - enums

enum ATTR_TYPE
{
	ATTR_TYPE_UNIQUE = 0,
	ATTR_TYPE_SINGLE = 1,
	ATTR_TYPE_MULTI = 2,
};

enum ERROR_CODE
{
	ERROR_CODE_OK = 0,
};

enum GOOD_TYPE
{
	GOOD_TYPE_NORMAL = 0,
	GOOD_TYPE_GROUP = 1,
	GOOD_TYPE_AUCTION = 2,
	GOOD_TYPE_RAIDERS = 3,
};

enum RANK_LEVEL
{
	RANK_LEVEL_NORMAL = 0,
	RANK_LEVEL_VIP = 1,
};

#define ORDER_LIST_FINISHED	@"finished"
#define ORDER_LIST_SHIPPED	@"shipped"
#define ORDER_LIST_AWAIT_PAY	@"await_pay"
#define ORDER_LIST_AWAIT_SHIP	@"await_ship"

#define SEARCH_ORDER_BY_CHEAPEST	@"price_asc"
#define SEARCH_ORDER_BY_HOT	@"is_hot"
#define SEARCH_ORDER_BY_EXPENSIVE	@"price_desc"

#define BANNER_ACTION_GOODS	@"goods"
#define BANNER_ACTION_CATEGORY @"category"
#define BANNER_ACTION_BRAND	@"brand"

#pragma mark - models

@class ADDRESS;
@class ARTICLE;
@class ARTICLE_GROUP;
@class BANNER;
@class BONUS;
@class BRAND;
@class CART_GOODS;
@class CATEGORY;
@class COMMENT;
@class CONFIG;
@class EXPRESS;
@class FILTER;
@class GOODS;
@class GOOD_ATTR;
@class GOOD_RANK_PRICE;
@class GOOD_SPEC;
@class GOOD_VALUE;
@class INVOICE;
@class ORDER;
@class ORDER_GOODS;
@class PAGINATED;
@class PAGINATION;
@class PAYMENT;
@class PHOTO;
@class PRICE_RANGE;
@class REGION;
@class SESSION;
@class SHIPPING;
@class SIGNUP_FIELD;
@class SIGNUP_FIELD_VALUE;
@class SIMPLE_GOODS;
@class STATUS;
@class TOTAL;
@class USER;
@class COLLECT_GOODS;
@class TIMER;

@interface ADDRESS : NSObject
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSString *		address;
@property (nonatomic, retain) NSString *		best_time;
@property (nonatomic, retain) NSNumber *		city;
@property (nonatomic, retain) NSNumber *		country;
@property (nonatomic, retain) NSNumber *		default_address;
@property (nonatomic, retain) NSNumber *		district;
@property (nonatomic, retain) NSString *		email;
@property (nonatomic, retain) NSString *		mobile;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSNumber *		province;
@property (nonatomic, retain) NSString *		sign_building;
@property (nonatomic, retain) NSString *		tel;
@property (nonatomic, retain) NSString *		zipcode;
@property (nonatomic, retain) NSString *		country_name;
@property (nonatomic, retain) NSString *		province_name;
@property (nonatomic, retain) NSString *		city_name;
@property (nonatomic, retain) NSString *		district_name;
@property (nonatomic, retain) NSString *        consignee;
@end

@interface ARTICLE : NSObject
@property (nonatomic, retain) NSString *		short_title;
@property (nonatomic, retain) NSString *		title;
@property (nonatomic, retain) NSNumber *		id;
@end

@interface ARTICLE_GROUP : NSObject
@property (nonatomic, retain) NSArray *		article;
@property (nonatomic, retain) NSString *		name;
@end

@interface BANNER : NSObject
@property (nonatomic, retain) NSString *		action;
@property (nonatomic, retain) NSNumber *		action_id;
@property (nonatomic, retain) NSString *		description;
@property (nonatomic, retain) PHOTO *		photo;
@property (nonatomic, retain) NSString *		url;
@end

@interface BONUS : NSObject
@property (nonatomic, retain) NSNumber * type_id;
@property (nonatomic, retain) NSString * type_name;
@property (nonatomic, retain) NSNumber * type_money;
@property (nonatomic, retain) NSString * bonus_id;
@property (nonatomic, retain) NSString * bonus_money_formated;
@end

@interface BRAND : NSObject
@property (nonatomic, retain) NSString *		url;
@property (nonatomic, retain) NSNumber *		brand_id;
@property (nonatomic, retain) NSString *		brand_name;
@end

@interface CART_GOODS : NSObject
@property (nonatomic, retain) NSNumber *		can_handsel;
@property (nonatomic, retain) NSString *		extension_code;
@property (nonatomic, retain) NSString *		formated_goods_price;
@property (nonatomic, retain) NSString *		formated_market_price;
@property (nonatomic, retain) NSString *		formated_subtotal;
@property (nonatomic, retain) NSArray *		goods_attr;
@property (nonatomic, retain) NSNumber *		goods_attr_id;
@property (nonatomic, retain) NSNumber *		goods_id;
@property (nonatomic, retain) NSString *		goods_name;
@property (nonatomic, retain) NSString *		goods_number;
@property (nonatomic, retain) NSString *		goods_price;
@property (nonatomic, retain) NSString *		goods_sn;
@property (nonatomic, retain) PHOTO *		img;
@property (nonatomic, retain) NSNumber *		is_gift;
@property (nonatomic, retain) NSNumber *		is_real;
@property (nonatomic, retain) NSNumber *		is_shipping;
@property (nonatomic, retain) NSString *		market_price;
@property (nonatomic, retain) NSNumber *		parent_id;
@property (nonatomic, retain) NSString *		pid;
@property (nonatomic, retain) NSNumber *		rec_type;
@property (nonatomic, retain) NSString *		subtotal;
@property (nonatomic, retain) NSNumber *		rec_id;
@end

@interface CATEGORY : NSObject
@property (nonatomic, retain) NSArray *		goods;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSNumber *		id;
@end

@interface TOP_CATEGORY : NSObject
@property (nonatomic, retain) NSArray *		children;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSNumber *		id;
@end

@interface COMMENT : NSObject
@property (nonatomic, retain) NSString *		author;
@property (nonatomic, retain) NSString *		content;
@property (nonatomic, retain) NSString *		create;
@property (nonatomic, retain) NSString *		re_content;
@property (nonatomic, retain) NSNumber *		id;
@end

@interface CONFIG : NSObject
@property (nonatomic, retain) NSString *		close_comment;
@property (nonatomic, retain) NSString *		service_phone;
@property (nonatomic, retain) NSNumber *		shop_closed;
@property (nonatomic, retain) NSString *		shop_desc;
@property (nonatomic, retain) NSNumber *		shop_reg_closed;
@property (nonatomic, retain) NSString *		site_url;
@property (nonatomic, retain) NSString *		goods_url;
@end

@interface EXPRESS : NSObject
@property (nonatomic, retain) NSString *		context;
@property (nonatomic, retain) NSString *		time;
@end

@interface FILTER : NSObject
@property (nonatomic, retain) NSNumber *		brand_id;
@property (nonatomic, retain) NSNumber *		category_id;
@property (nonatomic, retain) NSString *		keywords;
@property (nonatomic, retain) PRICE_RANGE *		price_range;
@property (nonatomic, retain) NSString *		sort_by;
@end

@interface GOODS : NSObject
@property (nonatomic, retain) NSNumber *		brand_id;
@property (nonatomic, retain) NSNumber *		cat_id;
@property (nonatomic, retain) NSNumber *		click_count;
@property (nonatomic, retain) NSString *		goods_name;
@property (nonatomic, retain) NSString *		goods_number;
@property (nonatomic, retain) NSString *		goods_sn;
@property (nonatomic, retain) NSString *		goods_weight;
@property (nonatomic, retain) PHOTO *           img;
@property (nonatomic, retain) NSNumber *		collected;
@property (nonatomic, retain) NSNumber *		integral;
@property (nonatomic, retain) NSNumber *		is_shipping;
@property (nonatomic, retain) NSString *		market_price;
@property (nonatomic, retain) NSArray *         pictures;
@property (nonatomic, retain) NSString *		promote_end_date;
@property (nonatomic, retain) NSString *		promote_price;
@property (nonatomic, retain) NSString *		formated_promote_price;
@property (nonatomic, retain) NSString *		promote_start_date;
@property (nonatomic, retain) NSArray *         properties;
@property (nonatomic, retain) NSArray *         rank_prices;
@property (nonatomic, retain) NSString *		shop_price;
@property (nonatomic, retain) NSArray *         specification;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSNumber *        is_presell;
@property (nonatomic, retain) NSString *        presell_shipping_time;
@end

@interface GOOD_ATTR : NSObject
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSString *		value;
@end

@interface GOOD_RANK_PRICE : NSObject
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSString *		price;
@property (nonatomic, retain) NSString *		rank_name;
@end

@interface GOOD_SPEC : NSObject
@property (nonatomic, retain) NSNumber *		attr_type;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSArray *         value;
@end

@interface GOOD_VALUE : NSObject
@property (nonatomic, retain) NSString *		format_price;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSString *		label;
@property (nonatomic, retain) NSNumber *		price;
@end

@interface GOOD_SPEC_VALUE : NSObject
@property (nonatomic, retain) GOOD_SPEC *       spec;
@property (nonatomic, retain) GOOD_VALUE *      value;
@end

@interface INVOICE : NSObject
@property (nonatomic, retain) NSString *		value;
@property (nonatomic, retain) NSNumber *		id;
@end

@interface ORDER_INFO : NSObject
@property (nonatomic, retain) NSString *		pay_code;
@property (nonatomic, retain) NSString *		order_sn;
@property (nonatomic, retain) NSString *		order_amount;
@property (nonatomic, retain) NSString *		order_id;
@property (nonatomic, retain) NSString *		subject;
@property (nonatomic, retain) NSString *		desc;
@end

@interface ORDER : NSObject
@property (nonatomic, retain) NSArray *         goods_list;
@property (nonatomic, retain) NSString *		order_sn;
@property (nonatomic, retain) NSString *		order_time;
@property (nonatomic, retain) NSString *		total_fee;
@property (nonatomic, retain) NSString *        formated_integral_money;
@property (nonatomic, retain) NSString *        formated_shipping_fee;
@property (nonatomic, retain) NSString *    	formated_bonus;
@property (nonatomic, retain) NSNumber *		order_id;
@property (nonatomic, retain) ORDER_INFO *		order_info;
@end

@interface ORDER_GOODS : NSObject
@property (nonatomic, retain) NSString *		formated_shop_price;
@property (nonatomic, retain) NSNumber *		goods_number;
@property (nonatomic, retain) PHOTO *		img;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSString *		subtotal;
@property (nonatomic, retain) NSNumber *		goods_id;
@property (nonatomic, retain) NSNumber *        rec_id;
@property (nonatomic, retain) NSNumber *        refund_status;
@end

@interface PAGINATED : NSObject
@property (nonatomic, retain) NSNumber *		count;
@property (nonatomic, retain) NSNumber *		more;
@property (nonatomic, retain) NSNumber *		total;
@end

@interface PAGINATION : NSObject
@property (nonatomic, retain) NSNumber *		count;
@property (nonatomic, retain) NSNumber *		page;
@end

@interface PAYMENT : NSObject
@property (nonatomic, retain) NSString *		format_pay_fee;
@property (nonatomic, retain) NSNumber *		is_cod;
@property (nonatomic, retain) NSString *		pay_code;
@property (nonatomic, retain) NSString *		pay_desc;
@property (nonatomic, retain) NSString *		pay_fee;
@property (nonatomic, retain) NSString *		pay_name;
@property (nonatomic, retain) NSNumber *		pay_id;
@end

@interface PHOTO : NSObject
@property (nonatomic, retain) NSString *		img;
@property (nonatomic, retain) NSString *		thumb;
@property (nonatomic, retain) NSString *		url;
@property (nonatomic, retain) NSString *		small;
@end

@interface PRICE_RANGE : NSObject
@property (nonatomic, retain) NSNumber *		price_min;
@property (nonatomic, retain) NSNumber *		price_max;
@end

// modify by nhj
@interface REGION : NSObject
@property (nonatomic, retain) NSNumber *		more;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSNumber *		parent_id;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSString *        type;   // 区分省市县
@end

// added by nhj
@interface TEACHER_INFO : NSObject
@property (nonatomic, retain) NSNumber *        user_id;
@property (nonatomic, retain) NSNumber *        course_id;
@property (nonatomic, retain) NSString *        real_name;
@property (nonatomic, retain) NSString *        school;
@property (nonatomic, retain) NSString *        user_name;
@property (nonatomic, retain) NSNumber *        mobile_phone;
@property (nonatomic, retain) NSNumber *        teacher_integral;
@property (nonatomic, retain) NSNumber *        isFollowed;
@end

@interface IS_FOLLOWED : NSObject
@property (nonatomic, retain) NSString * is_followed;
@end

@interface SESSION : NSObject
@property (nonatomic, retain) NSString *		sid;
@property (nonatomic, retain) NSNumber *		uid;
@end

@interface SHIPPING : NSObject
@property (nonatomic, retain) NSString *		format_shipping_fee;
@property (nonatomic, retain) NSString *		free_money;
@property (nonatomic, retain) NSString *		insure;
@property (nonatomic, retain) NSString *		insure_formated;
@property (nonatomic, retain) NSString *		shipping_code;
@property (nonatomic, retain) NSString *		shipping_desc;
@property (nonatomic, retain) NSString *		shipping_fee;
@property (nonatomic, retain) NSString *		shipping_name;
@property (nonatomic, retain) NSNumber *		support_cod;
@property (nonatomic, retain) NSNumber *		shipping_id;
@end

@interface SIGNUP_FIELD : NSObject
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSNumber *		need;
@property (nonatomic, retain) NSNumber *		id;
@end

@interface SIGNUP_FIELD_VALUE : NSObject
@property (nonatomic, retain) NSString *		value;
@property (nonatomic, retain) NSNumber *		id;
@end

@interface SIMPLE_GOODS : NSObject
@property (nonatomic, retain) NSString *		brief;
@property (nonatomic, retain) PHOTO *		img;
@property (nonatomic, retain) NSString *		market_price;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSString *		promote_price;
@property (nonatomic, retain) NSString *		shop_price;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSNumber *		goods_id;
@end

@interface STATUS : NSObject
@property (nonatomic, retain) NSNumber *		error_code;
@property (nonatomic, retain) NSString *		error_desc;
@property (nonatomic, retain) NSNumber *		succeed;
@end

@interface TOTAL : NSObject
@property (nonatomic, retain) NSString *		goods_amount;
@property (nonatomic, retain) NSString *		goods_price;
@property (nonatomic, retain) NSString *		market_price;
@property (nonatomic, retain) NSNumber *		real_goods_count;
@property (nonatomic, retain) NSString *		save_rate;
@property (nonatomic, retain) NSString *		saving;
@property (nonatomic, retain) NSNumber *		virtual_goods_count;
@end

@interface USER : NSObject
@property (nonatomic, retain) NSNumber *		collection_num;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSString *		email;
@property (nonatomic, retain) NSDictionary *	order_num;
@property (nonatomic, retain) NSString *		rank_name;
@property (nonatomic, retain) NSNumber *		rank_level;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSNumber *        is_teacher;
@property (nonatomic, retain) NSString *        avatar;
@property (nonatomic, retain) NSString *        nickname;
@property (nonatomic, retain) NSString *        teacher_name;
@end

@interface COLLECT_GOODS : SIMPLE_GOODS
@property (nonatomic, retain) NSNumber *		rec_id;
@property (nonatomic, retain) NSNumber *        goods_id;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSString *		market_price;
@property (nonatomic, retain) NSString *		shop_price;
@property (nonatomic, retain) NSString *		promote_price;
@property (nonatomic, retain) PHOTO *           img;
@property (nonatomic, assign) BOOL isEditing; // TODO:
@end

//接收返回的验证码,nhj
@interface identifyCode : NSObject
@property (nonatomic, retain) NSString *        identifyCode;
@end

// 接收返回的 course 信息,nhj
@interface Course : NSObject
@property (nonatomic, retain) NSArray       * course_name;
@property (nonatomic, retain) NSArray       * course_id;
@property (nonatomic, retain) NSArray       * teacher_name;
@end

// 接收返回被关在的 teacher 信息,nhj
@interface Teacher : NSObject
@property (nonatomic, retain) NSArray       * teacher_name;
@end

@interface Course_Info: NSObject
@property (nonatomic, retain) NSString * course_name;
@property (nonatomic, retain) NSNumber * course_id;
@property (nonatomic, retain) NSString * teacher_name;
@property (nonatomic, assign) BOOL isLastCourse;
@end

// 接收返回的 region 信息,nhj
@interface Regions : NSObject
@property (nonatomic, retain) NSNumber * more;
@property (nonatomic, retain) NSArray * regions;
@end

// 接收返回的 汇师圈 信息，nhj
@interface MOMENTS_PUBLISH : NSObject
@property (nonatomic, retain) NSString * news_content;
@property (nonatomic, retain) NSString * publish_time;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSArray  * photo_array;
@property (nonatomic, retain) NSArray  * comment_array;
@property (nonatomic, retain) NSNumber * news_id;
@end

@interface MOMENTS_TEACHER : NSObject
@property (nonatomic, retain) NSString * real_name;
@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSString * course_name;
@end

@interface COMMENT_INFO : NSObject
@property (nonatomic, retain) NSString * comment_id;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * target_username;
@property (nonatomic, retain) NSString * comment_content;
@property (nonatomic, retain) NSString * show_name;
@property (nonatomic, retain) NSString * show_target_name;
@end

@interface MOMENTS : NSObject
@property (nonatomic, retain) MOMENTS_PUBLISH * publish_info;
@property (nonatomic, retain) MOMENTS_TEACHER * teacher_info;
@end

@interface TEACHER_INTEGRAL : NSObject
@property (nonatomic, retain) NSString * pay_points;
@property (nonatomic, retain) NSString * points_from_affiliate;
@property (nonatomic, retain) NSString * points_from_subscription;
@property (nonatomic, retain) NSString * rank_points;
@property (nonatomic, retain) NSString * subscription_student_num;
@property (nonatomic, retain) NSString * recommanded_teacher_num;
@property (nonatomic, retain) NSString * teacher_integral;
@property (nonatomic, retain) NSString * invitation_code;
@end

@interface PAYMENT_INFO : NSObject
@property (nonatomic, retain) NSString * pay_id;
@property (nonatomic, retain) NSString * pay_name;
@property (nonatomic, retain) NSString * pay_code;
@end

@interface CHECK_USER_INFO : NSObject
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * invite_user_id;
@property (nonatomic, retain) NSString * invite_error;
@end

@interface TEACHER_REGISTER_INFO : NSObject
@property (nonatomic, retain) NSString * teacher_name;
@property (nonatomic, retain) NSString * province_id;
@property (nonatomic, retain) NSString * town_id;
@property (nonatomic, retain) NSString * district_id;
@property (nonatomic, retain) NSString * school_id;
@property (nonatomic, retain) NSString * course_id;
@property (nonatomic, retain) NSMutableArray * grade_array;
@property (nonatomic, retain) NSMutableArray * class_array;
@property (nonatomic, retain) NSNumber * line;
@end

// 程序运行，检测更新返回数据
@interface UPDATE_VERSION_INFO : NSObject
@property (nonatomic, retain) NSString * down_link;
@property (nonatomic, retain) NSNumber * is_required;
@property (nonatomic, retain) NSNumber * is_update;
@property (nonatomic, retain) NSString * latest_version;
@property (nonatomic, retain) NSString * update_node;
@end

// 咨讯图片类
@interface NEWS_BANNER : NSObject
@property (nonatomic, retain) NSNumber * banner_id;
@property (nonatomic, retain) NSString * banner_url;
@end

// 资讯列表数据类型
@interface NEWS_DETAIL : NSObject
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * sketch;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * updated_at;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NEWS_BANNER * banner;
@property (nonatomic, retain) NSString * news_id;
@property (nonatomic, retain) NSString * label_id;
@property (nonatomic, retain) NSString * label_name;
@end

//老师查询积分时的班级列表
@interface TEACHER_CLASS : NSObject
@property (nonatomic, retain) NSNumber * class_no;
@property (nonatomic, retain) NSString * grade;
@property (nonatomic, retain) NSNumber * info_id;
@property (nonatomic, retain) NSString * school_name;

@end

//老师查询学生时, 班级学生的积分
@interface STUDENT_POINT : NSObject

@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSNumber * student_points;
@property (nonatomic, retain) NSString * student_name;

@end


// 注册时候年级的信息
@interface Register_grade : NSObject
@property (nonatomic, retain) NSNumber * grade_id;
@property (nonatomic, retain) NSString * grade_name;
@end

// 注册时候学校的信息
@interface Register_school : NSObject
@property (nonatomic, retain) NSNumber * school_id;
@property (nonatomic, retain) NSString * school_name;
@end

// add by nhj,a new class for timer
@interface TIMER : NSObject

- (void)validCountDownTime:(NSInteger) time
        forTimer:(NSTimer *) timer
        forButton:(BeeUIButton *) button;
- (void)validCountDownTime:(NSInteger) time
        forTimer:(NSTimer *) timer;
- (void)removeTimer:(NSTimer *) timer;
@end

#pragma mark - controllers

@interface API : BeeController

// POST address/add
AS_MESSAGE( address_add );

// POST address/delete
AS_MESSAGE( address_delete );

// POST address/info
AS_MESSAGE( address_info );

// POST address/list
AS_MESSAGE( address_list );

// POST address/setDefault
AS_MESSAGE( address_setDefault );

// POST address/update
AS_MESSAGE( address_update );

// POST article
AS_MESSAGE( article );

// POST cart/create
AS_MESSAGE( cart_create );

// POST cart/delete
AS_MESSAGE( cart_delete );

// POST cart/list
AS_MESSAGE( cart_list );

// POST cart/update
AS_MESSAGE( cart_update );

// POST category
AS_MESSAGE( category );

// POST comments
AS_MESSAGE( comments );

// POST config
AS_MESSAGE( config );

// POST flow/checkOrder
AS_MESSAGE( flow_checkOrder );

// POST flow/done
AS_MESSAGE( flow_done );

// POST goods
AS_MESSAGE( goods );

// POST goods/desc
AS_MESSAGE( goods_desc );

// POST home/category
AS_MESSAGE( home_category );

// POST oeder/express
AS_MESSAGE( order_express );

// POST home/data
AS_MESSAGE( home_data );

// POST order/affirmReceived
AS_MESSAGE( order_affirmReceived );

// POST order/cancel
AS_MESSAGE( order_cancel );

// POST order/list
AS_MESSAGE( order_list );

// POST order/pay
AS_MESSAGE( order_pay );

// POST region
AS_MESSAGE( region );

// POST search
AS_MESSAGE( search );

// POST searchKeywords
AS_MESSAGE( searchKeywords );

// POST shopHelp
AS_MESSAGE( shopHelp );

// POST user/collect/create
AS_MESSAGE( user_collect_create );

// POST user/collect/delete
AS_MESSAGE( user_collect_delete );

// POST user/collect/list
AS_MESSAGE( user_collect_list );

// POST user/info
AS_MESSAGE( user_info );

// POST user/signin
AS_MESSAGE( user_signin );

// POST user/signup
AS_MESSAGE( user_signup );

// post user/teacher
AS_MESSAGE( get_teacher );

// POST user/teacherSignup
AS_MESSAGE( teacher_signup );

// POST user/getCourse
AS_MESSAGE( get_course );

// POST user/getCourse
AS_MESSAGE( course );

// POST getRegion
AS_MESSAGE( get_region );

// POST searchUser
AS_MESSAGE( search_user );

// POST user/addFollow
AS_MESSAGE( add_follow );

// POST user/cancelFollow
AS_MESSAGE( cancel_follow );

// POST user/getIntegral
AS_MESSAGE( get_integral );

// POST user/signupFields
AS_MESSAGE( user_signupFields );

// POST validate/bonus
AS_MESSAGE( validate_bonus );

// POST validate/integral
AS_MESSAGE( validate_integral );

// POST brand
AS_MESSAGE( brand );

// POST price_range
AS_MESSAGE( price_range );

// POST mobile_phone
AS_MESSAGE( getIdentifyCode );

// POST check_username
AS_MESSAGE( checkUser );

// POST get_sign     获取支付宝支付时的签名
AS_MESSAGE( getSign );

// POST moments_list  获取汇师圈的教师动态
AS_MESSAGE( moments_list );

//POST moments_delete 删除自己发的汇师圈动态
AS_MESSAGE (moments_delete);

// POST teacher_publish  教师发送汇师圈动态
AS_MESSAGE( teacher_publish );

// POST 将用户头像上传至服务器
AS_MESSAGE( post_avatar );

// POST 查询后台支持的支付方式
AS_MESSAGE( search_payment );

// POST 支付成功后改写更新支付方式
AS_MESSAGE( writePayId );

// POST 退货请求
AS_MESSAGE( returnGoods );

// POST 退货原因列表
AS_MESSAGE( returnReason );

// POST 更新版本
AS_MESSAGE ( updateVersion );

// POST 获取新闻资讯
AS_MESSAGE ( getNews );

// POST 获取学校信息
AS_MESSAGE ( getSchool );

// POST 获取年级信息
AS_MESSAGE ( getGrade );

//POST获取老师自己的班级列表
AS_MESSAGE ( getTeacherClass );

// POST 获取该班级所有学生积分信息
AS_MESSAGE ( getStudentPoint );

@end

#pragma mark - config

@interface ServerConfig : NSObject

AS_SINGLETON( ServerConfig )

@property (nonatomic, retain) NSString *	url;
// 新服务器的地址
@property (nonatomic, retain) NSString *    url2;

@end
