//
//  etmPhotoView.m
//  凤凰新闻客户端
//
//  Created by ma c on 15/11/18.
//  Copyright (c) 2015年 xiayuanquan. All rights reserved.
//

#import "etmPhotoView.h"
#import "UIImageView+WebCache.h"
#import "const.h"
#import "UIImageView+WebCache.h"
#import "etmEntity.h"

@interface etmPhotoView()
@property (strong,nonatomic)UIImageView *imageView;
@property (assign,nonatomic)CGRect rect;  //记录图片视图的frame
@end

@implementation etmPhotoView

//初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _rect = frame;
    }
    return self;
}

//重写set方法,接收实体对象
-(void)setEtmEntity:(etmEntity *)etmEntity
{
    _etmEntity = etmEntity;
    
    //单张图片
    if (_etmEntity.style == nil)
    {
        //取出图片
        NSURL *URL = [NSURL URLWithString:_etmEntity.thumbnail];
        
        self.imageView = [[UIImageView alloc]init];
        self.imageView.frame = CGRectMake(0,0,_rect.size.width,_rect.size.height);
        
        [self.imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"channel_list_new_default_normal"]];
        
        [self addSubview:self.imageView];
    }
    //多张图片
    else
    {
        //取出图片
        NSArray *pics = [_etmEntity.style objectForKey:@"images"];
        
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat photoWidth = (_rect.size.width-(pics.count+1)*PHOTO_GAP)/pics.count;
        CGFloat photoHeight = PHOTOVIEW_HEIGHT;
        
        for (int i =0; i < pics.count; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]init];
            NSURL *URL  = [NSURL URLWithString:pics[i]];
            imageView.frame = CGRectMake(x, y, photoWidth, photoHeight);
            x += photoWidth + PHOTO_GAP;
            [imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"channel_list_new_default_normal"]];
            [self addSubview:imageView];
        }
    }
}

@end
