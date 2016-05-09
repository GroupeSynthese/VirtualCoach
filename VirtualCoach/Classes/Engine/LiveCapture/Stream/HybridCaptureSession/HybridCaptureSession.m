//
//  HybridCaptureSession.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 09/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "HybridCaptureSession.h"

@implementation HybridCaptureSession

- (instancetype)initWithDevice:(AVCaptureDevice *)captureDevice sessionPreset:(NSString *)sessionPreset framerate:(int32_t)framerate
{
    self = [super initWithDevice:captureDevice sessionPreset:sessionPreset framerate:framerate];
    
    if (self)
    {
        _captureVideoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
        _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    }
    
    return self;
}

- (void)setup
{
    [super setup];
    
    NSDictionary *newSettings = @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    _captureVideoDataOutput.videoSettings = newSettings;
    _captureVideoDataOutput.alwaysDiscardsLateVideoFrames = YES;
    
    _videoDataOutputQueue = dispatch_queue_create("HCS_VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    
    _captureMovieFileOutput.maxRecordedDuration = kCMTimeInvalid;
    
    AVCaptureDeviceFormat *bestFormat = nil;
    AVFrameRateRange *bestFrameRateRange = nil;
    
    // setting to 60 fps by choosing highest rate range..
    
    for ( AVCaptureDeviceFormat *format in [self.captureDevice formats] )
    {
        for ( AVFrameRateRange *range in format.videoSupportedFrameRateRanges )
        {
            if ( range.maxFrameRate > bestFrameRateRange.maxFrameRate )
            {
                bestFormat = format;
                bestFrameRateRange = range;
            }
        }
    }
    
    if ( bestFormat )
    {
        if ( [self.captureDevice lockForConfiguration:NULL] == YES )
        {
            self.captureDevice.activeFormat = bestFormat;
            self.captureDevice.activeVideoMinFrameDuration = bestFrameRateRange.minFrameDuration;
            self.captureDevice.activeVideoMaxFrameDuration = bestFrameRateRange.minFrameDuration;
            [self.captureDevice unlockForConfiguration];
        }
    }
}

@end
