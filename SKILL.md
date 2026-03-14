---
name: chinese-deep-research-writing
description: 中文深度研究写作技能。用于论文、研究报告、深度特稿、政策分析等高规格写作任务；强调先检索后写作、全量本地留存、全过程可追溯、去AI痕迹表达、逻辑连贯章节推进、GB/T 7714 引用规范与学术校验。适用于提纲、初稿、定稿三种产出等级。
argument-hint: 请提供主题、体裁、目标读者、产出等级（提纲/初稿/定稿）与篇幅要求
---

# 中文深度研究写作

本技能用于产出高可信、强逻辑、可追溯的中文长文写作成果。默认要求为：先检索、后推理、再写作；全过程本地留痕；所有中间产物可复核。

## 使用场景

- 硕士论文级研究报告、课程论文、综述文章
- 行业研究、政策分析、专题报告、深度特稿
- 需要检索材料、证据映射、章节化写作与引用规范的任务
- 需要降低 AI 写作痕迹、提升人类写作质感的任务

## 核心目标

1. 全文中文表达，避免模板化 AI 腔。
2. 所有文件本地保存，包括过程文件与中间文件。
3. 章节推进清晰，前后逻辑连贯。
4. search-web 获取的材料完整留存，并给出可用性评估和使用方式。
5. 完成资料收集后，必须执行逻辑推理、事实核验、学术校验、写作指导流程。
6. 使用可复用、标准化、独立的项目结构（支持 Python、Bash、PowerShell 工作流）。

## 标准项目结构（强制）

每个任务都在本地创建独立工作目录：

```text
research-projects/
   文章标题全名/
      README.md
      00-project-meta/
         task-brief.md
         scope-and-constraints.md
         checkpoint.md
      01-collection/
         chapter-01/
            sources/pass-01/
            sources/pass-02/
            source-index.md
         chapter-02/
            ...
      02-reasoning/
         claim-map.md
         logic-chain.md
         contradiction-register.md
      03-verification/
         fact-check-table.md
         cross-source-check.md
         unresolved-items.md
      04-academic-validation/
         concept-definitions.md
         method-validity.md
         citation-audit.md
      05-writing-guide/
         chapter-outline.md
         argument-order.md
         style-guardrails.md
      06-drafts/
         01-引言.md
         02-主体.md
         03-结论.md
         99-全文汇总.md
      07-delivery/
         final-manuscript.md
         references.md
      scripts/
         init_project.py
         init_project.sh
         init_project.ps1
```

说明：
- 项目目录名即文章标题。目录名必须与最终交付文章标题保持一致，不使用时间戳前缀。
- 使用 scripts/init_project.py（或 init_project.sh、init_project.ps1）初始化项目结构与模板。
- 项目根目录的 README.md 为项目描述文件，由初始化脚本自动生成。

## 模板与协议（按需加载）

为降低一次性加载负担，详细说明拆分在 references 目录，执行到具体步骤时再读取：

- 模板清单与用途：references/template_guide.md
- 断点续传协议：references/checkpoint_protocol.md

## 强制工作流（渐进式披露）

### 第 0 步：任务建档与初始化

按文章标题初始化项目、填写 task-brief 与范围约束，并完成 checkpoint 初始状态。

执行前加载：references/workflow_step0_init.md

### 第 1 步：检索与全量留存

按章节检索资料并本地全量保存，每条来源单独存档。

执行前加载：references/workflow_step1_collection.md

### 第 2 步：资料可用性评估

对每章来源做六维评估并标注建议用途。

执行前加载：references/workflow_step2_evaluation.md

### 第 3 步：收集后推理与验证

按顺序完成逻辑推理、事实核验、学术校验与写作指导。

执行前加载：references/workflow_step3_reasoning.md

### 第 4 步：章节化写作与汇总

按写作指导逐章写作，并生成汇总稿与交付稿。

执行前加载：references/workflow_step4_writing.md

### 第 5 步：终稿质检

完成逻辑、事实、引用、风格四类质检后交付。

执行前加载：references/workflow_step5_review.md

## 断点续传机制（简化版）

仅使用 00-project-meta/checkpoint.md 作为进度快照文件，不再维护 actions.log、timeline.md、decision-log.md。

checkpoint 至少包含：
- current_step
- status
- last_updated
- progress_detail
- next_action
- 已完成步骤
- 关键决策

恢复时：
1. 读取 checkpoint.md 获取 current_step、status、next_action。
2. 校验当前步骤关键产出文件是否存在且非空。
3. 从 next_action 指定位置继续执行，而非从头开始。

详细规则见 references/checkpoint_protocol.md。

## 去 AI 痕迹写作规范

### 必须避免

- 套话起手（如“随着时代发展”）
- 空洞拔高（无证据的大词结论）
- 三段式机械排比与口号化收束
- 模糊主语替代真实来源（如“有研究指出”但无出处）

### 建议写法

- 先给可核验事实，再给解释
- 段内保持“主张 -> 机制 -> 证据 -> 小结/过渡”
- 有争议观点注明分歧来源
- 结论只覆盖证据支持的边界

## 体裁与产出等级

### 提纲版

- 输出研究问题、章节框架、每章证据计划、风险与待补项

### 初稿版

- 输出完整正文与基础引用
- 对证据薄弱处透明标注并给出补强路径

### 定稿版

- 结构收束、转承自然、引用完整、术语统一
- 不保留占位语句与未处理冲突

## 引用与参考文献

- 默认执行 GB/T 7714（参考 references/gbt7714_quick_guide.md）。
- 缺失元数据时宁缺勿造，不得虚构作者、年份、页码、机构。

## 资源文件加载建议

- 交付拆分规则：references/markdown_delivery_rules.md
- 体裁模板：references/genre_templates.md
- 引用规范：references/gbt7714_quick_guide.md

## 分支决策规则

1. 资料不足：先补检索与可用性评估，不直接硬写。
2. 来源冲突：在 02-reasoning/contradiction-register.md 登记冲突并给出处理策略。
3. 主题过大：先缩小问题边界，再推进章节写作。
4. 时效性强主题：优先近 6-12 个月材料，并在验证环节二次核对。

## 完成判定（DoD）

仅当以下条件全部满足才可判定完成：

1. 全文与过程文件均已本地落盘。
2. 所有检索材料已完整保存并登记。
3. 每章完成可用性评估与使用方式说明。
4. 已完成推理、核验、学术校验与写作指导文档。
5. 正文章节逻辑连贯、证据可追溯、引用格式统一。
6. checkpoint.md 最终状态为 step-done / completed。
