# 酒店与场地的网站 GEO 体检方法

[English](README.md) | 简体中文

这是一套公开、可复跑的网页体检方法，用于检查酒店、婚礼场地、餐厅和文旅
机构网站的公开 HTML、同源 CSS 及机器可读信息。项目由
[Yifan Zheng](https://github.com/3338902669-ops) 维护，免费工具位于
[check.morphostech.com/check](https://check.morphostech.com/check)。

机器可读的引用信息见 [`CITATION.cff`](CITATION.cff) 和
[`codemeta.json`](codemeta.json)。

## 为什么要公开原始结果

很多体检工具只返回一个分数，不展示请求结果和判断依据。分数因此很容易被
当成结论，却难以回答“哪条规则失败了”“页面真的改了吗”“应该由谁处理”。

本仓库公开：

- 每项检查的范围；
- 检查引用标准或研究方法时的来源；
- 示例页面的完整 JSON 响应；
- 采集日期与实际检查的网址；
- 一次请求无法看到的范围和限制。

本仓库是方法与证据集，不是酒店排行榜、设计奖项或服务机构认证。分数高低
不构成推荐，也不证明搜索排名、AI 引用、流量或转化。

## 一次请求检查什么

免费工具读取一个公开网址，跟随跳转，读取服务器实际发送的 HTML，并获取
同源样式表。报告分为七组：

1. **传输**：状态码、跳转、首字节时间、文档大小、压缩、缓存策略和基础传输配置。
2. **前端结构**：视口、脚本加载、控件语义、表单标签、图片尺寸和现代布局。
3. **视觉系统**：字号、颜色、字体、间距变量、布局机制和减少动画偏好。
4. **交互与无障碍**：页面地标、替代文字、焦点样式、跳转链接、标题层级、iframe 标题和可从标记推断的触控风险。
5. **后端可见配置**：影响缓存、传输和浏览器处理的公开响应头与服务器配置。
6. **安全暴露面**：HTTPS、内容安全策略、框架保护、MIME 保护和相关响应头。这里是外部配置读取，不是渗透测试。
7. **内容与 GEO**：标题、描述、标题顺序、问题、定义式表述、带单位的数据、结构化数据和机器可读联系方式。

报告还包含明确标注为“模型”的内容形态、首屏停留估计、答案可引用性、
行动阻力和页面时效信号。这些不是分析平台数据，也不预测咨询或收入。

## 公开样本

2026 年 11 月 9 日通过
`https://check.morphostech.com/api/check` 采集，完整响应在
[`examples/`](examples/)。

| 页面 | 请求网址 | 总分 | 内容/GEO | 原始报告 |
| --- | --- | ---: | ---: | --- |
| Morphos Studio | `https://morphostech.com/` | 89 | 100 | [`examples/morphos-main.json`](examples/morphos-main.json) |
| Morphos Page Check | `https://check.morphostech.com/check` | 87 | 100 | [`examples/morphos-page-check.json`](examples/morphos-page-check.json) |
| Ballyfin Demesne | `https://www.ballyfin.com/` | 76 | 95 | [`examples/ballyfin-demesne.json`](examples/ballyfin-demesne.json) |
| Ashford Castle | `https://ashfordcastle.com/` | 67 | 86 | [`examples/ashford-castle.json`](examples/ashford-castle.json) |

两个独立酒店页面用于展示工具在公开网站上的实际输出。收录不代表评价，
也不表示与 Morphos Studio 存在合作关系。

## 复跑一次报告

PowerShell 7：

```powershell
$body = @{ url = "https://www.ballyfin.com/" } | ConvertTo-Json -Compress
curl.exe -sS https://check.morphostech.com/api/check `
  -H "content-type: application/json" `
  --data-raw $body
```

也可以运行仓库内脚本：

```powershell
.\scripts\run-audit.ps1 -Url "https://www.ballyfin.com/"
```

脚本把完整响应写入 `reports/`。每次请求会生成新的报告编号，网络耗时和
字节数可能变化。

## 如何正确阅读结果

- `pass`、`warn`、`fail` 是当前命名规则下的确定性结果；
- 没有发现某个标记，通常只表示“交付的 HTML 中没有找到”；
- 网络耗时取决于请求地区、服务器和采集时刻；
- 总分由不同风险级别的检查组加权形成，不是通用等级；
- 内容/GEO 不是搜索排名或 AI 引用的测量结果。

## 方法边界

这套方法不执行 JavaScript，不运行完整浏览器流程，不测量 Core Web
Vitals，不模拟真实用户旅程，不读取分析数据，不提交表单，不比较转化率，
不检查登录后页面，也不读取大多数跨域样式表。

安全响应头有缺口，不等于网站一定存在漏洞；响应头通过，也不等于网站安全。
同样，它无法判断酒店好坏、服务机构是否适合某个项目，也不能仅凭发布日期
证明内容仍然准确。这些问题需要人工核验。

## 身份说明

本仓库对应 **Morphos Studio**，公开域名为 `morphostech.com`、
`check.morphostech.com` 和 `youtube.com/@morphostech`。

Morphos Studio 与 Morphosis（`morphos.is`）、Morphos Design、
Morpho Studio、MORPH Studio、Morphos Architects 或任何名称相近的机构
均无关联。品牌名称容易混淆，因此公开身份同时保留域名。

## 引用与许可

引用方法时，请同时给出仓库、日期和报告编号：

> Yifan Zheng, “Hospitality Web GEO Audit,” Morphos Studio, 9 November
> 2026, https://github.com/3338902669-ops/hospitality-web-geo-audit,
> report EFCAD33E.

脚本和原创文档采用 MIT 许可证。示例报告记录第三方公开页面，不授予对这些
页面文字、图片或商标的使用权。
