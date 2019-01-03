//
//  CRBoxInputCell.m
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import "CRBoxInputCell.h"
#import "Masonry.h"

@interface CRBoxInputCell ()
{
    
}
@end

@implementation CRBoxInputCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    self.ifNeedCursor = YES;
    self.userInteractionEnabled = NO;
    
    _valueLabel = [UILabel new];
    _valueLabel.font = [UIFont systemFontOfSize:38];
    [self.contentView addSubview:_valueLabel];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    _cursorView = [UIView new];
    [self.contentView addSubview:_cursorView];
    [_cursorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(2);
        make.centerX.offset(0);
        make.top.offset(5);
        make.bottom.offset(-5);
    }];
    
    [self initCellProperty];
}

- (void)initCellProperty
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    self.boxInputCellProperty = cellProperty;
}

#pragma mark - Setter & Getter
- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.layer.borderColor = self.boxInputCellProperty.cellBorderColorSelected.CGColor;
    }else{
        self.layer.borderColor = self.boxInputCellProperty.cellBorderColorNormal.CGColor;
    }
    
    if (_ifNeedCursor) {
        if (selected) {
            _cursorView.hidden= NO;
            [_cursorView.layer addAnimation:self.opacityAnimation forKey:CRBoxCursoryAnimationKey];
        }else{
            _cursorView.hidden= YES;
            [_cursorView.layer removeAnimationForKey:CRBoxCursoryAnimationKey];
        }
    }else{
        _cursorView.hidden= YES;
    }
}

- (void)setBoxInputCellProperty:(CRBoxInputCellProperty *)boxInputCellProperty
{
    _boxInputCellProperty = boxInputCellProperty;
    
    _cursorView.backgroundColor = boxInputCellProperty.cellCursorColor;
    self.backgroundColor = boxInputCellProperty.cellBgColor;
    self.layer.cornerRadius = boxInputCellProperty.cornerRadius;
    self.layer.borderWidth = boxInputCellProperty.borderWidth;
    
    if (boxInputCellProperty.cellFont) {
        _valueLabel.font = boxInputCellProperty.cellFont;
    }
    
    if (boxInputCellProperty.cellTextColor) {
        _valueLabel.textColor = boxInputCellProperty.cellTextColor;
    }
}

#pragma mark - Animation
- (CABasicAnimation *)opacityAnimation
{
    if (!_opacityAnimation) {
        _opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnimation.fromValue = @(1.0);
        _opacityAnimation.toValue = @(0.0);
        _opacityAnimation.duration = 0.9;
        _opacityAnimation.repeatCount = HUGE_VALF;
        _opacityAnimation.removedOnCompletion = YES;
        _opacityAnimation.fillMode = kCAFillModeForwards;
        _opacityAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    
    return _opacityAnimation;
}

@end