//
//  VSMenuItemCameraPreviewView.m
//  vsNow-Landing
//
//  Created by Virendra Shakya on 6/11/16.
//  Copyright © 2016 Virendra Shakya. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "VSMenuItemCameraPreviewView.h"
#import "VSUIUtils.h"
#import "VSLandingTheme.h"

@interface VSMenuItemCameraPreviewView () <AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic) UIView* wrapperView;
@property (nonatomic) UIImageView* imageView;
@property (nonatomic) BOOL hasAppliedConstraints;

@property (nonatomic) AVCaptureSession* captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer* captureVideoPreviewLayer;
@end

@implementation VSMenuItemCameraPreviewView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
  [self initCapture];
  
	[self.contentView addSubview:self.wrapperView];
	[self.wrapperView addSubview:self.imageView];
	self.layer.cornerRadius = kCornerRadius;
}

/*!
 @method captureOutput:didOutputSampleBuffer:fromConnection:
 @abstract
    Called whenever an AVCaptureVideoDataOutput instance outputs a new video frame.

 @param captureOutput
    The AVCaptureVideoDataOutput instance that output the frame.
 @param sampleBuffer
    A CMSampleBuffer object containing the video frame data and additional information about the frame, such as its format and presentation time.
 @param connection
    The AVCaptureConnection from which the video was received.

 @discussion
    Delegates receive this message whenever the output captures and outputs a new video frame, decoding or re-encoding it as specified by its videoSettings property. Delegates can use the provided video frame in conjunction with other APIs for further processing. This method will be called on the dispatch queue specified by the output's sampleBufferCallbackQueue property. This method is called periodically, so it must be efficient to prevent capture performance problems, including dropped frames.

    Clients that need to reference the CMSampleBuffer object outside of the scope of this method must CFRetain it and then CFRelease it when they are finished with it.

    Note that to maintain optimal performance, some sample buffers directly reference pools of memory that may need to be reused by the device system and other capture inputs. This is frequently the case for uncompressed device native capture where memory blocks are copied as little as possible. If multiple sample buffers reference such pools of memory for too long, inputs will no longer be able to copy new samples into memory and those samples will be dropped. If your application is causing samples to be dropped by retaining the provided CMSampleBuffer objects for too long, but it needs access to the sample data for a long period of time, consider copying the data into a new buffer and then calling CFRelease on the sample buffer if it was previously retained so that the memory it references can be reused.
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
}

/*!
 @method captureOutput:didDropSampleBuffer:fromConnection:
 @abstract
    Called once for each frame that is discarded.

 @param captureOutput
    The AVCaptureVideoDataOutput instance that dropped the frame.
 @param sampleBuffer
    A CMSampleBuffer object containing information about the dropped frame, such as its format and presentation time. This sample buffer will contain none of the original video data.
 @param connection
    The AVCaptureConnection from which the dropped video frame was received.

 @discussion
    Delegates receive this message whenever a video frame is dropped. This method is called once for each dropped frame. The CMSampleBuffer object passed to this delegate method will contain metadata about the dropped video frame, such as its duration and presentation time stamp, but will contain no actual video data. On iOS, Included in the sample buffer attachments is the kCMSampleBufferAttachmentKey_DroppedFrameReason, which indicates why the frame was dropped. This method will be called on the dispatch queue specified by the output's sampleBufferCallbackQueue property. Because this method will be called on the same dispatch queue that is responsible for outputting video frames, it must be efficient to prevent further capture performance problems, such as additional dropped video frames.
  */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
}


- (void)initCapture {
  AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
  if (!captureInput) {
      return;
  }
  AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
  /* captureOutput:didOutputSampleBuffer:fromConnection delegate method !*/
  [captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
  NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
  NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
  NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
  [captureOutput setVideoSettings:videoSettings];
  self.captureSession = [[AVCaptureSession alloc] init];
  NSString* preset = 0;
  if (!preset) {
      preset = AVCaptureSessionPresetMedium;
  }
  self.captureSession.sessionPreset = preset;
  if ([self.captureSession canAddInput:captureInput]) {
      [self.captureSession addInput:captureInput];
  }
  if ([self.captureSession canAddOutput:captureOutput]) {
      [self.captureSession addOutput:captureOutput];
  }

  //handle prevLayer
  if (!self.captureVideoPreviewLayer) {
      self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
			self.captureVideoPreviewLayer.cornerRadius = kCornerRadius;
  }

  //if you want to adjust the previewlayer frame, here!
  self.captureVideoPreviewLayer.frame = self.bounds;
  self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
  [self.contentView.layer addSublayer: self.captureVideoPreviewLayer];
  [self.captureSession startRunning];
}

- (void)prepareForReuse {
	self.imageView.image = nil;
	self.hasAppliedConstraints = NO;
}

- (void)configureWithImageUrl:(NSString*)imageUrl {
	UIImage* header = [UIImage imageNamed:imageUrl];
  header = [header imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.imageView.tintColor = [VSLandingTheme cameraOverlayColor];
	self.imageView.image = header;
}

+ (NSString*)reusableID {
	return NSStringFromClass([self class]);
}

#pragma mark - UI Elements
- (UIView*)wrapperView {
	if (!_wrapperView) {
		UIView* v = [[UIView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		_wrapperView = v;
	}
	return _wrapperView;
}

- (UIImageView*)imageView {
	if (!_imageView) {
		UIImageView* v = [[UIImageView alloc] init];
		v.translatesAutoresizingMaskIntoConstraints = NO;
		v.contentMode = UIViewContentModeScaleAspectFit;
		_imageView = v;
	}
	return _imageView;
}

#pragma mark - layout constraints
+ (BOOL)requiresConstraintBasedLayout {
	return YES;
}

- (void)updateConstraints {
	if (!self.hasAppliedConstraints) {
		self.hasAppliedConstraints = YES;
		[self applyConstraints];
	}
	[super updateConstraints];
}

- (void)applyConstraints {
	UIView* parent = self.contentView;
	
	//image view
	CGFloat margin = 0;
  //margin = [[UIScreen mainScreen] scale] * 0;
	
	NSLayoutConstraint* leadingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeLeading multiplier:1.f constant:margin];
	NSLayoutConstraint* trailingWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTrailing multiplier:1.f constant:-margin];
	NSLayoutConstraint* topWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeTop multiplier:1.f constant:margin];
	NSLayoutConstraint* bottomWrapperView = [NSLayoutConstraint constraintWithItem:self.wrapperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeBottom multiplier:1.f constant:-margin];
	
	[parent addConstraints:@[leadingWrapperView, trailingWrapperView, topWrapperView, bottomWrapperView]];
	
	parent = self.wrapperView;
  
      	//lhs icon width and height
	NSLayoutConstraint* lhsIconHeight = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44];
	NSLayoutConstraint* lhsIconWidth = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44];
	[self.imageView addConstraints:@[lhsIconHeight, lhsIconWidth]];
	
	NSLayoutConstraint* leadingImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
	NSLayoutConstraint* trailingImageView = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:parent attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0];
	
	[parent addConstraints:@[leadingImageView, trailingImageView/*, topImageView, bottomImageView*/]];
	
}

@end
