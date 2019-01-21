# Changelog
本项目的所有值得注意的更改都将记录在此文件中。
部分未对外发布的小版本以及改动，未一一列出。

## [Unreleased]
### Added
- 继续增加API 调用方法示例

---

## [1.4.0] - 2019-01-21
## Add
- 增加断连，然后重连示例
### Improved
- 加入房间 API 优化

## [1.3.17] - 2019-01-20
### Add
-  增加 url 拦截 API `urlInterrupter:` ，方便提供私有图片 URL（插入图片 API，以及插入 ppt API 都会被拦截）。
### Fixed
- 获取当前用户视角状态API `getBroadcastStateWithResult:` 返回错误的枚举值

## [1.3.16] - 2019-01-19
### Add
- 增加获取房间连接状态 API
- 添加部分示例 Demo
### Fixed
- 缩放比例到达极限值时，回弹会出现错位
- 视角模式变化时，RoomStateChange 返回错误的视角枚举值
### Improved
- 优化只读操作逻辑
### Changed
- 修改上传图片示例，使用文档推荐做法

## [1.3.15] - 2019-01-03
- 优化弱网环境下连接
- 优化笔画曲线
### Add
- 增加主动获取房间状态 API

## [1.3.14] - 2018-12-25
### Changed
- WhiteBorderView 默认禁用原生客户端滚动
### Added
- 提供单独的调用方法示例

## [1.3.13] - 2018-12-23
### Added
- 获取当前白板缩放状态 API `getZoomScaleWithResult:`
- 刷新白板视图大小 API `refreshViewSize`
- API 头文件注释
- 提供 Changelog

### Fixed
- 主播模式 API `setViewMode:` 调用失败
- 白板视图大小与白板内容大小不一致；禁用白板操作时，会出现滚动的情况（iOS 10及其以下，需要在调用时进行部分设置）

## [1.3.12] - 2018-12-01
### Added
- 白板只读操作 API `disableOperations:`
- 白板缩放操作 API `zoomChange:`

## [1.3.4] - 2018-11-04
### Changed
- 修改WhiteRoomPhase枚举

## [1.3.0] - 2018-10-27
提供视觉矩形功能，对移动端有需求的客户务必更新体验。

### Added
- 视觉矩形功能，用于适配移动端竖向屏幕和桌面端横向屏幕。

## [1.1.2] - 2018-10-11
增加对 iOS9 的支持，适配版本由 iOS10 变更为 iOS 9。

### Fixed
- iOS9 下兼容性问题

## [1.1.1] - 2018-10-10
### Added
- 自定义消息功能。可以用于实现类似点赞、弹幕、聊天等功能。

## [1.0] - 2018-09-26
1.0版本 API 保持向下兼容。

### Added
- demo 提供 iOS 12 适配兼容

## [0.2] - 2018-08-18
- 提供基础 API 功能
