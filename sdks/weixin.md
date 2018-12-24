# 微信 JS-SDK 说明文档

[online reading](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421141115)

## 使用步骤

1. 绑定域名
2. 引入 JS 文件 http://res.wx.qq.com/open/js/jweixin-1.4.0.js
3. 通过 config 接口注入权限验证配置
4. 通过 ready 接口处理成功验证
5. 通过 error 接口处理失败验证

```js
wx.config({
  debug: true,
  appId: "",
  timestamp: "",
  nonceStr: "",
  signature: "",
  jsApiList: []
});

wx.ready(function() {
  // do something
});

wx.error(function() {
  // do something error handler
});
```

## 基础接口

判断当前客户端版本是否支持指定的 JS 接口

```js
wx.checkJsApi({
  jsApiList: ["chooseImage"],
  success: function(res) {
    // do something
  }
});
```

## 分享接口

原有的分享接口（如 `wx.onMenuShareTimeline`）即将废弃，应尽快迁移使用客户端 6.7.2 及 1.4.0 以上版本支持的 `wx.updateAppMessageShareData`, `updateTimelineShareData` 接口。

```js
wx.ready(function() {
  wx.updateAppMessageShareData({
    title: "",
    desc: "",
    link: "",
    imgUrl: "",
    success: function() {
      /* do something */
    }
  }),
    wx.updateTimelineShareData({
      title: "",
      link: "",
      imgUrl: "",
      success: function() {
        /* do something */
      }
    });
});
```

## 界面操作

关闭当前窗口

```js
wx.closeWindow();
```

批量隐藏功能按钮接口

```js
wx.hideMenuItems({
  menuList: [] // 智能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
});
```

批量显示功能按钮接口

```js
wx.showMenuItems({
  menuList: []
});
```

隐藏所有非基础按钮接口

```js
wx.hideAllNonBaseMenuItem();
```

显示所有功能按钮接口

```js
wx.showAllNonBaseMenuItem();
```

## 图像接口

```js
wx.previewImage({
  current: '', // current url
  urls: []
})
```

## 微信支付

具体细节参见[微信支付开发文档](https://pay.weixin.qq.com/wiki/doc/api/index.html)

```js
wx.chooseWXPay({
  timestamp: 0,
  nonceStr: "",
  package: "",
  signType: "",
  paySign: "",
  success: function(res) {
    // do something
  }
});
```

## 附录 3 - 所有菜单项列表

### 基本类

- 举报："menuItem: exposeArticle"
- 调整字体："menuItem: setFont"
- 日间模式："menuItem: dayMode"
- 夜间模式："menuItem: nightMode"
- 刷新："menuItem: refresh"
- 查看公众号（已添加）："menuItem: profile"
- 查看公众号（未添加）："menuItem: addContact"

### 传播类

- 发送给朋友："menuItem:share:appMessage"
- 分享到朋友圈："menuItem:share:timeline"
- 分享到 QQ："menuItem:share:qq"
- 分享到 Weibo："menuItem:share:weiboApp"
- 收藏："menuItem:favorite"
- 分享到 FB："menuItem:share:facebook"
- 分享到 QQ 空间："menuItem:share:QZone"

### 保护类

- 编辑标签："menuItem:editTag"
- 删除："menuItem:delete"
- 复制链接："menuItem:copyUrl"
- 原网页："menuItem:originPage"
- 阅读模式："menuItem:readMode"
- 在 QQ 浏览器中打开："menuItem:openWithQQBrowser"
- 在 Safari 中打开："menuItem:openWithSafari"
- 邮件："menuItem:share:email"
- 一些特殊公众号："menuItem:share:brand"
