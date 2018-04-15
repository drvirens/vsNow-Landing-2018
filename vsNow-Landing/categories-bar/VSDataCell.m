//
//  VSDataCellCollectionViewCell.m
//  VSTopBarScrollView
//
//  Created by Nate on 7/8/16.
//  Copyright © 2016 Skully Inc. All rights reserved.
//

#import "VSDataCell.h"
#import "VSUIUtils.h"
#import "VSRegularItemView.h"

static const CGFloat kCellMargin = 2.5f;

@interface VSDataCell ()
@property (nonatomic) VSRegularItemView* regularItemView;
@property (nonatomic) BOOL hasAppliedConstraints;
@end

@implementation VSDataCell
- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self commonInit];
  }
  return self;
}
- (void)commonInit {
  [self.contentView addSubview:self.regularItemView];
}

+ (NSString*)reuseID {
  return NSStringFromClass([self class]);
}
- (void)configureWithModel:(VSItemModel*)model {
  [self.regularItemView configureWithModel:model];
}
- (void)prepareForReuse {
  [self.regularItemView reset];
}
#pragma mark - UI Elements
- (VSRegularItemView*)regularItemView {
  if (!_regularItemView) {
    VSRegularItemView* p = [[VSRegularItemView alloc] init];
    p.translatesAutoresizingMaskIntoConstraints = NO;
    _regularItemView = p;
  }
  return _regularItemView;
}

#pragma mark - constraints
+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}
- (void)updateConstraints {
  if (!self.hasAppliedConstraints) {
    [self applyConstraints];
    self.hasAppliedConstraints = YES;
  }
  [super updateConstraints];
}
- (void)applyConstraints {
  UIView* parent = self.contentView;


  NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:self.regularItemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:kCellMargin];
  NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:self.regularItemView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-kCellMargin];
  NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:self.regularItemView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:kCellMargin];
  NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem:self.regularItemView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-kCellMargin];
  
  [parent addConstraints:@[top, bottom, left, right]];

}
@end
