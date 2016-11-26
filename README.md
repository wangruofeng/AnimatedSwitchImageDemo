# 动画切换Image最佳实践

### 前言

`UIImageView`应该是iOS中使用最频换的控件，就如日常吃饭一样，天天都在重复，有时或许应该反思一下，怎么使用这个控件，达到低能耗，最佳用户体验。

针对单张图片来说，常见的处理是在图片准备显示时增加一个淡出动画，能使图片显示闲的很平滑。

多张图片也一样，在第一张图片的基础上淡出原来的图片，淡入新的图片。也可以说是溶解效果。

很多人喜欢对图片的`alpha`做淡出动画，使`alpha`从0到1动画改变。这种动画有一点不好的是，在动画结束后，图片会明显的出现一闪，这样使动画看起来有点突兀。比较好的做法时，在将要显示时给图片做一个转场动画。

### 淡出动画实现

下面是其中一种简单的实现

```Objective-c
@implementation UIImageView (RFWebImage)

- (void)animatedChangeToImage:(UIImage *)img
{
    [UIView transitionWithView:self
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.image = img;
                    } completion:NULL];
}

@end
```

思路：在ImageView将要显示是使用转场动画函数来实现淡出动画效果，体验应该是是各种动画中最好的了，而且使用起来很简单。


在淡出显示的动画基础上，我们引出今天的主角，动画切换Image。

思路：单张图片淡出我们已经实现，现在做的就是在切换一张新的图片时同时再加入淡出或者说溶解效果即可。

### 动画切换Image

比较常见的有下面3种实现：

* `CATransition`类实现
* `UIView`动画转场API实现
* `CABasicAnimation`类实现

#### CATransition实现

`CATransition`类是iOS中很好用的控制转场动画的类，通过简单的配置可以实现常见而炫酷的动画效果，变换类型通过`type`字段控制，`subtype`可以很细化控制动画的方向（比如动画开始的上下左右方向）。`CATransition`继承至`CAAnimation`可以对动画设置动画曲线（timingFunction），可以通过代理获取动画状态（是已经开始，还是已经停止，已经是否完成）。

`type`支持四种类型：

* kCATransitionFade    // 淡入淡出
* kCATransitionMoveIn  // 从某个方向向终点平移知道覆盖在上方
* kCATransitionPush    // 把原来的推出去，自己推出去
* kCATransitionReveal  // 把原来的从正上方解开，自己在下面

*下面是样板代码：*

```Objective-c
- (void)animatedSwichImageMethodOne {

    UIImage *toImage = [self getRadomImage];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    
    [self.imageViewOne.layer addAnimation:transition forKey:nil];
    [self.imageViewOne setImage:toImage];
}
```

#### UIView动画转场

```Objective-c
+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);
```

通过上面的函数实现，其实是对第一种的高级封装。通过设置`options`为`UIViewAnimationOptionTransitionCrossDissolve`即可。

*下面是样板代码：*

```Objective-c
- (void)animatedSwichImageMethodTwo {
    
    UIImage *toImage = [self getRadomImage];
    
    [UIView transitionWithView:self.imageViewTwo
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        self.imageViewTwo.image = toImage;
                    } completion:nil];
}
```

#### CABasicAnimation实现

`CABasicAnimation`是核心动画一个重要的类，继承至`CAPropertyAnimation`，可以对所有的可动画属性做动画，可以通过`fromValue`，`toValue`，`byValue`字段控制动画的进度。
在这里我们是对`CALayer`的`contents`属性做动画，在改变图片时，创建一个`CABasicAnimation`对象添加到ImageView的图层上即可。

*下面是样板代码：*

```Objective-c
- (void)animatedSwichImageMethodThree {
    
    UIImage *toImage = [self getRadomImage];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.toValue = toImage;
    animation.duration = 0.3f;
    
    [self.imageViewThree.layer addAnimation:animation forKey:@"contentsAnimationKey"];
    [self.imageViewThree setImage:toImage];
}
```
![Demo效果图](https://github.com/wangruofeng/AnimatedSwitchImageDemo/blob/master/AnimatedSwitchImageDemo/screenShot%402x.jpg)

更多内容请下载Demo查看（**🤔Bonus： Flip效果🤔**）
喜欢该文章的请打💖，以便鼓励我继续创作，非常谢谢。
