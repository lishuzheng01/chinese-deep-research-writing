# 中文深度研究写作（Chinese Deep Research Writing）

一套面向 AI 编程助手的技能模块，用于产出高可信、强逻辑、可追溯的中文长文写作成果。适用于论文、研究报告、深度特稿、政策分析等高规格写作任务。

## 核心特性

- **先检索后写作**：所有写作基于实际检索材料，拒绝凭空生成
- **全量本地留存**：检索材料、过程文件、中间产物全部保存在本地项目目录
- **全过程可追溯**：从来源到论点到正文，每一步都可复核
- **去 AI 痕迹表达**：内置风格约束与质检清单，降低 AI 写作的模板感
- **GB/T 7714 引用规范**：默认使用中国国家标准引用格式
- **断点续传**：通过 checkpoint 机制支持跨会话恢复，不丢失进度
- **渐进式披露**：按需加载步骤说明，减轻模型上下文负担

## 适用场景

- 硕士论文级研究报告、课程论文、综述文章
- 行业研究、政策分析、专题报告
- 深度特稿、解释性报道、评论
- 任何需要检索材料、证据映射、章节化写作与引用规范的任务

## 项目结构

```
chinese-deep-research-writing/
├── SKILL.md                  # 技能入口文件（AI 助手读取此文件）
├── QUICKSTART.md             # 快速入门指南
├── CHANGELOG.md              # 版本变更记录与迁移指南
├── README.md                 # 本文件
├── agents/
│   └── openai.yaml           # OpenAI 平台适配配置
├── references/               # 按需加载的详细说明
│   ├── workflow_step0_init.md       # Step 0：初始化
│   ├── workflow_step1_collection.md # Step 1：检索与留存
│   ├── workflow_step2_evaluation.md # Step 2：可用性评估
│   ├── workflow_step3_reasoning.md  # Step 3：推理与验证
│   ├── workflow_step4_writing.md    # Step 4：章节化写作
│   ├── workflow_step5_review.md     # Step 5：终稿质检
│   ├── template_guide.md           # 模板清单与用途索引
│   ├── checkpoint_protocol.md       # 断点续传协议
│   ├── context_budget.md            # 上下文窗口预算策略
│   ├── anti_ai_style_guide.md       # 去 AI 痕迹写作规范
│   ├── genre_templates.md           # 体裁模板索引
│   ├── genres/                      # 各体裁独立模板
│   ├── gbt7714_quick_guide.md       # GB/T 7714 引用速查
│   └── markdown_delivery_rules.md   # 交付格式规范
├── scripts/                  # 项目初始化脚本
│   ├── init_project.py
│   ├── init_project.sh
│   └── init_project.ps1
└── templates/                # 标准化模板文件
    ├── 00-project-meta/      # 任务定义与断点续传
    ├── 01-collection/        # 检索来源登记与评估
    ├── 02-reasoning/         # 逻辑推理与矛盾登记
    ├── 03-verification/      # 事实核验
    ├── 04-academic-validation/ # 学术校验
    ├── 05-writing-guide/     # 写作指导
    ├── 06-drafts/            # 章节草稿模板
    └── 07-delivery/          # 交付稿与参考文献模板
```

## 工作流概览

| 步骤 | 名称 | 说明 |
|------|------|------|
| Step 0 | 初始化 | 创建项目目录、填写任务定义与范围约束 |
| Step 1 | 检索与留存 | 按章节检索材料，全量本地保存 |
| Step 2 | 可用性评估 | 对来源做六维评估，标注建议用途 |
| Step 3 | 推理与验证 | 逻辑推理、事实核验、学术校验、写作指导 |
| Step 4 | 章节化写作 | 逐章写作、汇总、生成交付稿 |
| Step 5 | 终稿质检 | 逻辑/事实/引用/风格四维质检 |

## 快速开始

1. 将本项目放置到 AI 编程助手可识别的技能目录中。
2. 向 AI 提出写作任务，例如：

   > 请写一篇 5000 字的研究报告：「中国新能源汽车出口竞争力分析」，目标读者为行业研究人员，产出等级为初稿。

3. AI 将自动读取 `SKILL.md`，按工作流逐步执行。
4. 详细的分步示例参见 [QUICKSTART.md](QUICKSTART.md)。

### 手动初始化项目（可选）

```bash
# Python
python scripts/init_project.py "文章标题" 4

# Bash
bash scripts/init_project.sh "文章标题" 4

# PowerShell
.\scripts\init_project.ps1 -ArticleTitle "文章标题" -ChapterCount 4
```

## 支持的体裁

学术论文、文献综述、行业/政策研究报告、个案分析、深度特稿/评论、调查/解释性报道、政策建议。

## 产出等级

| 等级 | 输出内容 |
|------|---------|
| 提纲 | 研究问题、章节框架、证据计划、风险与待补项 |
| 初稿 | 完整正文与基础引用，薄弱处标注补强路径 |
| 定稿 | 结构收束、引用完整、术语统一、无占位语句 |

## 版本记录

参见 [CHANGELOG.md](CHANGELOG.md)，包含各版本变更内容与迁移指南。
