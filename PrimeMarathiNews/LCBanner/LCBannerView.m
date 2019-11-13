//
//  LCBannerView.m
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 11/11/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//  LCBannerView.m
//
//  Created by Leo on 15/11/30.
//  Copyright © 2015年 Leo. All rights reserved.
//
//

#import "LCBannerView.h"
#import "UIImageView+WebCache.h"
#import "HexColors.h"
#import "FMDatabase.h"
#import "shree.h"

static CGFloat LCPageDistance = 10.0f;  // distance to bottom of pageControl

@interface LCBannerView () <UIScrollViewDelegate>
{
    UIButton *btnFav;
}

@property(nonatomic,weak) id<LCBannerViewDelegate> delegate;
@property(nonatomic,assign) CGFloat       timeInterval;
@property(nonatomic,strong) NSTimer       *timer;
@property(nonatomic,weak) UIScrollView  *scrollView;
@property(nonatomic,weak) UIPageControl *pageControl;
@property(nonatomic,assign) NSInteger     oldURLCount;

@end

@implementation LCBannerView

+ (instancetype)bannerViewWithFrame:(CGRect)frame delegate:(id<LCBannerViewDelegate>)delegate imageName:(NSString *)imageName count:(NSInteger)count timeInterval:(NSInteger)timeInterval currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    return [[self alloc] initWithFrame:frame
                              delegate:delegate
                             imageName:imageName
                                 count:count
                         timeInterval:timeInterval
         currentPageIndicatorTintColor:currentPageIndicatorTintColor
                pageIndicatorTintColor:pageIndicatorTintColor];
}

+ (instancetype)bannerViewWithFrame:(CGRect)frame delegate:(id<LCBannerViewDelegate>)delegate newsIDs:(NSArray *)newsIDs imageURLs:(NSArray *)imageURLs placeholderImageName:(NSString *)placeholderImageName Titles:(NSArray *)Titles Descriptions:(NSArray *)Descriptions Dates:(NSArray *)Dates Views:(NSArray *)Views NewsTypes:(NSArray *)NewsTypes VideoIDs:(NSArray *)VideoIDs VideoURLs:(NSArray *)VideoURLs timeInterval:(NSInteger)timeInterval currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    return [[self alloc] initWithFrame:frame
                              delegate:delegate
                            newsIDs:newsIDs
                             imageURLs:imageURLs
                  placeholderImageName:placeholderImageName
                              Titles:Titles
                               Descriptions:Descriptions
                                 Dates:Dates
                                 Views:Views
                             NewsTypes:NewsTypes
                              VideoIDs:VideoIDs
                             VideoURLs:VideoURLs
                         timeInterval:timeInterval
         currentPageIndicatorTintColor:currentPageIndicatorTintColor
                pageIndicatorTintColor:pageIndicatorTintColor];
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<LCBannerViewDelegate>)delegate imageName:(NSString *)imageName count:(NSInteger)count timeInterval:(NSInteger)timeInterval currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    if (self = [super initWithFrame:frame])
    {
        _delegate                      = delegate;
        _imageName                     = imageName;
        _count                         = count;
        _timeInterval                  = timeInterval;
        _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        _pageIndicatorTintColor        = pageIndicatorTintColor;

        [self setupMainView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<LCBannerViewDelegate>)delegate newsIDs:(NSArray *)newsIDs imageURLs:(NSArray *)imageURLs placeholderImageName:(NSString *)placeholderImageName Titles:(NSArray *)Titles Descriptions:(NSArray *)Descriptions Dates:(NSArray *)Dates Views:(NSArray *)Views NewsTypes:(NSArray *)NewsTypes VideoIDs:(NSArray *)VideoIDs VideoURLs:(NSArray *)VideoURLs timeInterval:(NSInteger)timeInterval currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    if (self = [super initWithFrame:frame]) {
        _delegate                      = delegate;
        _newsIDs                       = newsIDs;
        _imageURLs                     = imageURLs;
        _placeholderImageName          = placeholderImageName;
        _Titles                        = Titles;
        _Descriptions                  = Descriptions;
        _Dates                         = Dates;
        _Views                         = Views;
        _NewsTypes                     = NewsTypes;
        _VideoIDs                      = VideoIDs;
        _VideoURLs                     = VideoURLs;
        _oldURLCount                   = _count;
        _count                         = imageURLs.count;
        _timeInterval                  = timeInterval;
        _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        _pageIndicatorTintColor        = pageIndicatorTintColor;
        [self setupMainView];
    }
    return self;
}

- (void)setupMainView
{
    CGFloat scrollW = self.frame.size.width;
    CGFloat scrollH = self.frame.size.height;
    // set up scrollView
    [self addSubview:({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollW, scrollH)];
        [self addSubviewToScrollView:scrollView];
        scrollView.delegate                       = self;
        scrollView.scrollsToTop                   = NO;
        scrollView.pagingEnabled                  = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentOffset                  = CGPointMake(scrollW, 0);
        scrollView.contentSize                    = CGSizeMake((self.count + 2) * scrollW, 0);
        self.scrollView = scrollView;
    })];
    [self addTimer];
    
    // set up pageControl
    [self addSubview:({
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollH - 10.0f - LCPageDistance, scrollW, 10.0f)];
        pageControl.numberOfPages                 = self.count;
        pageControl.userInteractionEnabled        = NO;
        pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
        pageControl.pageIndicatorTintColor        = [UIColor clearColor];
        self.pageControl = pageControl;
    })];
//    [self handleDidScroll];
}

- (void)addSubviewToScrollView:(UIScrollView *)scrollView
{
    scrollView.layer.cornerRadius = 5.0f;
    scrollView.clipsToBounds = YES;
    
    CGFloat scrollW = self.frame.size.width;
    CGFloat scrollH = self.frame.size.height;
    for (int i = 0; i < self.count + 2; i++)
    {
        NSInteger tag = 0;
        NSString *currentImageName = nil;
        if (i == 0) {
            tag = self.count;
            currentImageName = [NSString stringWithFormat:@"%@_%02ld", self.imageName, (long)self.count];
        } else if (i == self.count + 1) {
            tag = 1;
            currentImageName = [NSString stringWithFormat:@"%@_01", self.imageName];
        } else {
            tag = i;
            currentImageName = [NSString stringWithFormat:@"%@_%02d", self.imageName, i];
        }
        
        //1.News Image
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = tag;
        if (self.imageName.length > 0) {    // from local
            UIImage *image = [UIImage imageNamed:currentImageName];
            if (!image) {
                NSLog(@"ERROR: No image named `%@`!", currentImageName);
            }
            imageView.image = image;
        } else {    // from internet
            NSString *newsType = self.NewsTypes[tag - 1];
            if ([newsType isEqualToString:@"video"]) {
                NSString *youtubeIMAGE = [NSString stringWithFormat:@"http://i3.ytimg.com/vi/%@/hqdefault.jpg",self.VideoIDs[tag - 1]];
                [imageView sd_setImageWithURL:[NSURL URLWithString:youtubeIMAGE]                         placeholderImage:self.placeholderImageName.length > 0 ? [UIImage imageNamed:self.placeholderImageName] : nil];
            } else {
                [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs[tag - 1]]                         placeholderImage:self.placeholderImageName.length > 0 ? [UIImage imageNamed:self.placeholderImageName] : nil];
            }
        }
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.layer.cornerRadius = 5.0f;
        imageView.clipsToBounds          = YES;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode            = UIViewContentModeScaleToFill;
        imageView.frame                  = CGRectMake(scrollW * i, 0, scrollW, scrollH);
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = imageView.bounds;
        gradient.startPoint = CGPointMake(1.0, 1.0); //Dark From bottom
        gradient.endPoint = CGPointMake(1.0, 0);
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[[UIColor blackColor] CGColor],
                           (id)[[UIColor clearColor] CGColor], nil];
        [imageView.layer insertSublayer:gradient atIndex:0];
        [scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTaped:)];
        [imageView addGestureRecognizer:tap];
        
        //2.Favourite Button
        btnFav = [UIButton buttonWithType:UIButtonTypeCustom];
        btnFav.frame = CGRectMake((scrollW * i)-35, 10, 30, 30);
        [btnFav addTarget:self action:@selector(OnFavouriteClick:)        forControlEvents:UIControlEventTouchUpInside];
        btnFav.tag = i;
        [btnFav setBackgroundImage:[UIImage imageNamed:@"ic_fav"] forState:UIControlStateNormal];

        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *documents_dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *db_path = [documents_dir stringByAppendingPathComponent:[NSString stringWithFormat:@"NewsAppPro.sqlite"]];
        NSString *template_path = [[NSBundle mainBundle] pathForResource:@"NewsAppPro" ofType:@"sqlite"];
        if (![fm fileExistsAtPath:db_path])
            [fm copyItemAtPath:template_path toPath:db_path error:nil];
        FMDatabase *database = [FMDatabase databaseWithPath:db_path];
        if (![database open]) {
            NSLog(@"Failed to open database!");
        } else {
            //NSLog(@"Database open!");
            NSMutableArray *myArr = [NSMutableArray arrayWithArray:self.newsIDs];
            NSString *lastElement = [myArr lastObject];
            [myArr insertObject:lastElement atIndex:0];
            NSString *newsID = [myArr objectAtIndex:tag-1];
            FMResultSet *results = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM Favourite WHERE id=%@",newsID]];
            while ([results next]) {
                //NSLog(@"news Id = %@",[results stringForColumn:@"id"]);
                //NSLog(@"news_title = %@",[results stringForColumn:@"news_title"]);
                [btnFav setBackgroundImage:[UIImage imageNamed:@"ic_favhov"] forState:UIControlStateNormal];
            }
        }
        [scrollView addSubview:btnFav];

        //3.News Title
        UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake((scrollW * i)+7,scrollH-115,scrollW-14,30)];
        [lbltitle setBackgroundColor:[UIColor clearColor]];
        [lbltitle setFont:[UIFont fontWithName:@"Poppins-Medium" size:16.0f]];
        [lbltitle setText:self.Titles[tag - 1]];
        lbltitle.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7f];
        [lbltitle setTextAlignment:NSTextAlignmentLeft];
        [lbltitle setClipsToBounds:YES];
        [scrollView addSubview:lbltitle];
        
        //4.News Description
        UITextView *txtDesc = [[UITextView alloc] initWithFrame:CGRectMake((scrollW * i)+5, scrollH-60, scrollW-10, 60)];
        NSString *htmlDesc = self.Descriptions[tag - 1];
        NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithData:[htmlDesc dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableAttributedString *newString1 = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString1];
        NSRange range1 = (NSRange){0,[newString1 length]};
        [newString1 enumerateAttribute:NSFontAttributeName inRange:range1 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop)
        {
            [newString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Poppins-Regular" size:12.0f] range:range];
            [newString1 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range];
        }];
        [txtDesc setBackgroundColor:[UIColor clearColor]];
        txtDesc.scrollEnabled = NO;
        txtDesc.attributedText = newString1;
        txtDesc.scrollEnabled = NO;
        [txtDesc setUserInteractionEnabled:NO];
        [scrollView addSubview:txtDesc];

        //5.Date Icon
        UIImageView *dateIcon =[[UIImageView alloc] initWithFrame:CGRectMake((scrollW * i)+7,scrollH-80,20,20)];
        dateIcon.image = [UIImage imageNamed:@"ic_cale"];
        [scrollView addSubview:dateIcon];
        
        //6.Date
        UILabel *lbldate = [[UILabel alloc] initWithFrame:CGRectMake((scrollW * i)+30,scrollH-78,80,20)];
        lbldate.text = self.Dates[tag - 1];
        lbldate.backgroundColor = [UIColor clearColor];
        lbldate.textColor = [UIColor lightGrayColor];
        lbldate.textAlignment = NSTextAlignmentLeft;
        [lbldate setFont:[UIFont fontWithName:@"Poppins-Regular" size:12.0f]];
        [scrollView addSubview:lbldate];
        
        //7.Views Icon
        UIImageView *viewsIcon =[[UIImageView alloc] initWithFrame:CGRectMake((scrollW * i)+110,scrollH-80,20,20)];
        viewsIcon.image = [UIImage imageNamed:@"ic_view"];
        [scrollView addSubview:viewsIcon];
        
        //8.Views
        UILabel *lblviews = [[UILabel alloc] initWithFrame:CGRectMake((scrollW * i)+135,scrollH-79,40,20)];
        lblviews.text = self.Views[tag - 1];
        lblviews.backgroundColor = [UIColor clearColor];
        lblviews.textColor = [UIColor lightGrayColor];
        lblviews.textAlignment = NSTextAlignmentLeft;
        [lblviews setFont:[UIFont fontWithName:@"Poppins-Regular" size:12.0f]];
        [scrollView addSubview:lblviews];
        
        //9.Share Icon
        UIButton *shareIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        shareIcon.frame = CGRectMake((scrollW * i)+170,scrollH-80,20,20);
        UIImage *imgname = [UIImage imageNamed:@"ic_share"];
        [shareIcon setBackgroundImage:imgname forState:UIControlStateNormal];
        [shareIcon setTag:tag];
        [shareIcon addTarget:self action:@selector(OnShareClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:shareIcon];

        //9.Share
        UIButton *btnshare = [UIButton buttonWithType:UIButtonTypeCustom];
        btnshare.frame = CGRectMake((scrollW * i)+195,scrollH-80,50,20);
        [btnshare setTitle:@"Share" forState:UIControlStateNormal];
        [btnshare setBackgroundColor:[UIColor clearColor]];
        [btnshare setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnshare setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnshare.titleLabel setFont:[UIFont fontWithName:@"Poppins-Regular" size:12.0f]];
        [btnshare setTag:tag];
        [btnshare addTarget:self action:@selector(OnShareClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnshare];
    }
}

- (void)imageViewTaped:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(bannerView:didClickedImageIndex:)]) {
        [self.delegate bannerView:self didClickedImageIndex:tap.view.tag - 1];
    }
    
    if (self.didClickedImageIndexBlock) {
        self.didClickedImageIndexBlock(self, tap.view.tag - 1);
    }
}

-(void)OnFavouriteClick:(UIButton *)sender
{
    //NSDictionary *dataInfo = @{@"Data": @(sender.tag-1)};
    //NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //[nc postNotificationName:@"FavouriteNotification" object:self userInfo:dataInfo];
    //[btnFav setBackgroundImage:[UIImage imageNamed:@"ic_favhov"] forState:UIControlStateNormal];
}

-(void)OnShareClick:(UIButton *)sender
{
    NSDictionary *userInfo = @{@"total": @(sender.tag-1)};
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"ShareNotification" object:self userInfo:userInfo];
}

- (void)setPageDistance:(CGFloat)pageDistance
{
    _pageDistance = pageDistance;
    if (pageDistance != LCPageDistance) {
        CGRect frame           = self.pageControl.frame;
        frame.origin.y         = self.frame.size.height - 10.0f - pageDistance;
        self.pageControl.frame = frame;
    }
}

- (void)setNotScrolling:(BOOL)notScrolling
{
    _notScrolling = notScrolling;
    if (notScrolling)
    {
        self.pageControl.hidden       = YES;
        self.scrollView.scrollEnabled = NO;
        if (self.timer) {
            [self removeTimer];
        }
    }
}

- (void)setHidePageControl:(BOOL)hidePageControl
{
    _hidePageControl = hidePageControl;
    self.pageControl.hidden = hidePageControl;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    [self refreshMainViewCountChanged:NO];
}

- (void)setImageURLs:(NSArray *)imageURLs
{
    _imageURLs = imageURLs;
    [self refreshMainViewCountChanged:imageURLs.count != self.oldURLCount];
    self.oldURLCount = imageURLs.count;
}

- (void)setCount:(NSInteger)count
{
    _count = count;
    [self refreshMainViewCountChanged:YES];
}

- (void)setPlaceholderImageName:(NSString *)placeholderImageName
{
    _placeholderImageName = placeholderImageName;
    [self refreshMainViewCountChanged:NO];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor ?: [UIColor orangeColor];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor ?: [UIColor lightGrayColor];
}

- (void)refreshMainViewCountChanged:(BOOL)changed
{
    if (changed)
    {
        for (UIView *childView in self.scrollView.subviews) {
            [childView removeFromSuperview];
        }
        if (self.imageName.length == 0) {
            _count = self.imageURLs.count;
        }
        [self addSubviewToScrollView:self.scrollView];
        self.pageControl.numberOfPages = self.count;
    } else {
        for (int i = 0; i < self.count + 2; i++)
        {
            NSInteger tag = 0;
            NSString *currentImageName = nil;
            if (i == 0) {
                tag = self.count;
                currentImageName = [NSString stringWithFormat:@"%@_%02ld", self.imageName, (long)self.count];
            } else if (i == self.count + 1) {
               tag = 1;
                currentImageName = [NSString stringWithFormat:@"%@_01", self.imageName];
            } else {
                tag = i;
                currentImageName = [NSString stringWithFormat:@"%@_%02d", self.imageName, i];
            }
            
            UIImageView *imageView = [self.scrollView viewWithTag:tag];
            if (self.imageName.length > 0) {    // from local
                UIImage *image = [UIImage imageNamed:currentImageName];
                if (!image) {
                    NSLog(@"ERROR: No image named `%@`!", currentImageName);
                }
                imageView.image = image;
            } else {    // from internet
                [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs[tag - 1]]
                             placeholderImage:self.placeholderImageName.length > 0 ? [UIImage imageNamed:self.placeholderImageName] : nil];
            }
        }
    }
}

- (void)handleDidScroll
{
    if ([self.delegate respondsToSelector:@selector(bannerView:didScrollToIndex:)]) {
        [self.delegate bannerView:self didScrollToIndex:self.pageControl.currentPage];
    }
    
    if (self.didScrollToIndexBlock) {
        self.didScrollToIndexBlock(self, self.pageControl.currentPage);
    }
}

#pragma mark - Timer
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)nextImage
{
    NSInteger currentPage = self.pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake((currentPage + 2) * self.scrollView.frame.size.width, 0) animated:YES];
}

#pragma mark - UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollW = self.scrollView.frame.size.width;
    NSInteger currentPage = self.scrollView.contentOffset.x / scrollW;
    if (currentPage == self.count + 1) {
        self.pageControl.currentPage = 0;
    } else if (currentPage == 0) {
        self.pageControl.currentPage = self.count;
    } else {
        self.pageControl.currentPage = currentPage - 1;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollW = self.scrollView.frame.size.width;
    NSInteger currentPage = self.scrollView.contentOffset.x / scrollW;
    if (currentPage == self.count + 1) {
        self.pageControl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(scrollW, 0) animated:NO];
    } else if (currentPage == 0) {
        self.pageControl.currentPage = self.count;
        [self.scrollView setContentOffset:CGPointMake(self.count * scrollW, 0) animated:NO];
    } else {
        self.pageControl.currentPage = currentPage - 1;
    }
    [self handleDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

@end
