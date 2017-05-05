//
//                       __
//                      /\ \   _
//    ____    ____   ___\ \ \_/ \           _____    ___     ___
//   / _  \  / __ \ / __ \ \    <     __   /\__  \  / __ \  / __ \
//  /\ \_\ \/\  __//\  __/\ \ \\ \   /\_\  \/_/  / /\ \_\ \/\ \_\ \
//  \ \____ \ \____\ \____\\ \_\\_\  \/_/   /\____\\ \____/\ \____/
//   \/____\ \/____/\/____/ \/_//_/         \/____/ \/___/  \/___/
//     /\____/
//     \/___/
//
//	Powered by BeeFramework
//

#import "OrderCellBody_iPhone.h"

#pragma mark -

@implementation OrderCellBody_iPhone

DEF_OUTLET( BeeUIButton, return_button )

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
}

- (void)unload
{
}

- (void)dataDidChanged
{
    ORDER_GOODS * goods = self.data;
    _goods = goods;
    
    $(@"#order-goods-count").TEXT( [NSString stringWithFormat:@"X %@", goods.goods_number] );
    $(@"#order-goods-price").TEXT( goods.formated_shop_price );
    $(@"#order-goods-title").TEXT( goods.name );
    $(@"#order-goods-photo").IMAGE( goods.img.thumbURL );
    
    if (goods.refund_status.integerValue == 0) {
        $(@"#order_goods_return").TEXT(@"申请退款");
    } else if (goods.refund_status.integerValue == 1) {
        $(@"#order_goods_return").TEXT(@"退款处理中");
    } else if (goods.refund_status.integerValue == 2) {
        $(@"#order_goods_return").TEXT(@"退款成功");
    } else if (goods.refund_status.integerValue == 3) {
        $(@"#order_goods_return").TEXT(@"退款失败");
    }
}

@end
