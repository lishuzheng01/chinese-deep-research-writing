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
4. search-web 获取的材料完整留存，并给出“可用性评估 + 使用方式”。
5. 完成资料收集后，必须执行“逻辑推理 -> 事实核验 -> 学术校验 -> 写作指导文档”流程。
6. 使用可复用、标准化、独立的项目结构（支持 Bash 与 Python 工作流）。
7. 任意动作必须在文件系统中留下过程记录，可追溯、可复盘。

## 标准项目结构（强制）

每个任务都在本地创建独立工作目录：

```text
research-projects/
   文章标题全名/
      README.md
      00-project-meta/
         task-brief.md
         scope-and-constraints.md
         decision-log.md
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
      90-process-logs/
         actions.log
         timeline.md
      scripts/
         init_project.py
         init_project.sh
         init_project.ps1
```

说明：
- **项目目录名即文章标题**。目录名必须与最终交付文章的标题保持一致，不使用时间戳前缀。例如：写一篇《平台劳动者权益保障研究》，则目录名为 `平台劳动者权益保障研究`。
- 使用 [scripts/init_project.py](scripts/init_project.py)（或 [init_project.sh](scripts/init_project.sh)、[init_project.ps1](scripts/init_project.ps1)）初始化项目结构与模板，传入参数即为文章标题。
- 项目根目录下的 `README.md` 为项目描述文件，由初始化脚本自动生成，内容结合任务的主题、体裁、目标读者、核心问题等信息，概要性地说明整个项目的研究内容与目标。
- 任何新增、修改、删除、检索、判断行为，都要同步写入 `90-process-logs/`。

## 模板文件清单与分类

所有模板位于 `templates/` 目录下，按阶段分类。初始化脚本会自动复制到项目目录。

### A 类：任务定义（项目启动时填写）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| [templates/00-project-meta/task-brief.md](templates/00-project-meta/task-brief.md) | 任务定义：主题、体裁、读者、产出等级、篇幅、拆分阈值 | `00-project-meta/` |
| [templates/00-project-meta/scope-and-constraints.md](templates/00-project-meta/scope-and-constraints.md) | 范围界定与硬约束 | `00-project-meta/` |
| [templates/00-project-meta/decision-log.md](templates/00-project-meta/decision-log.md) | 过程决策日志 | `00-project-meta/` |
| [templates/00-project-meta/checkpoint.md](templates/00-project-meta/checkpoint.md) | 断点续传状态记录 | `00-project-meta/` |

### B 类：检索与评估（每章各一份）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| [templates/01-collection/source-index.md](templates/01-collection/source-index.md) | 来源登记索引 + 可用性六维评估 + 使用方式建议 | `01-collection/chapter-NN/` |
| [templates/01-collection/source-capture.md](templates/01-collection/source-capture.md) | 单条来源捕获格式 | `01-collection/chapter-NN/sources/` |

### C 类：推理与验证（全局各一份）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| [templates/02-reasoning/claim-map.md](templates/02-reasoning/claim-map.md) | 主张清单与证据映射 | `02-reasoning/` |
| [templates/02-reasoning/logic-chain.md](templates/02-reasoning/logic-chain.md) | 主张→证据→推论→边界条件 | `02-reasoning/` |
| [templates/02-reasoning/contradiction-register.md](templates/02-reasoning/contradiction-register.md) | 信息冲突登记与处理策略 | `02-reasoning/` |
| [templates/03-verification/fact-check-table.md](templates/03-verification/fact-check-table.md) | 关键事实交叉核验 | `03-verification/` |
| [templates/03-verification/cross-source-check.md](templates/03-verification/cross-source-check.md) | 多来源一致性核对 | `03-verification/` |
| [templates/03-verification/unresolved-items.md](templates/03-verification/unresolved-items.md) | 未解决事项跟踪 | `03-verification/` |

### D 类：学术校验（全局各一份）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| [templates/04-academic-validation/concept-definitions.md](templates/04-academic-validation/concept-definitions.md) | 核心概念定义一致性检查 | `04-academic-validation/` |
| [templates/04-academic-validation/method-validity.md](templates/04-academic-validation/method-validity.md) | 分析方法适配性校验 | `04-academic-validation/` |
| [templates/04-academic-validation/citation-audit.md](templates/04-academic-validation/citation-audit.md) | 引用完整性与格式审计 | `04-academic-validation/` |

### E 类：写作指导（全局各一份）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| [templates/05-writing-guide/chapter-outline.md](templates/05-writing-guide/chapter-outline.md) | 章节提纲与证据计划 | `05-writing-guide/` |
| [templates/05-writing-guide/argument-order.md](templates/05-writing-guide/argument-order.md) | 论证顺序与过渡策略 | `05-writing-guide/` |
| [templates/05-writing-guide/style-guardrails.md](templates/05-writing-guide/style-guardrails.md) | 体裁风格约束（含去 AI 检查清单） | `05-writing-guide/` |

### F 类：过程记录与断点续传（项目初始化时生成）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| [templates/90-process-logs/actions.log](templates/90-process-logs/actions.log) | 全量行为日志（JSON Lines 格式，带动作ID，过程追溯主链） | `90-process-logs/` |
| [templates/90-process-logs/timeline.md](templates/90-process-logs/timeline.md) | 里程碑时间线（关联步骤标识与动作ID） | `90-process-logs/` |

## 强制工作流

### 第 0 步：任务建档与初始化

1. 使用文章标题作为项目目录名，创建任务目录与标准子目录。
2. 生成 `README.md`：结合主题、体裁、目标读者、核心问题等信息，用 3-5 句话概要描述本项目的研究内容与目标（不要过于简单也不要过于冗长）。
3. 写入 `00-project-meta/task-brief.md`：主题、目标读者、体裁、产出等级（提纲/初稿/定稿）、篇幅要求。
4. 初始化 `00-project-meta/checkpoint.md`，将当前阶段设为 `step-0-init`，状态设为 `completed`。
5. 写入首条过程记录到 `90-process-logs/actions.log`：`[A001] [时间] [step-0-init] [INIT] [completed] 项目初始化完成 | task-brief.md, checkpoint.md`。
6. 在 `90-process-logs/timeline.md` 追加初始化里程碑，关联动作 A001。

### 第 1 步：检索与全量留存（先于写作）

> **过程记录联动**：
> - 开始前：在 `actions.log` 追加 `[SEARCH] [started]`，更新 `checkpoint.md` 为 `step-1-collection / in-progress`，在 `timeline.md` 追加里程碑。
> - 每完成一条来源的检索与保存：在 `actions.log` 追加 `[CAPTURE] [completed]`，并记录关联文件路径（如 `01-collection/chapter-01/sources/pass-01/S001-xxx.md`）。
> - 每完成一章的检索：更新 `checkpoint.md` 的 `progress_detail`（如「chapter-01 检索完成，已获取 5 条来源」）和「已产出文件清单」。
> - 全部完成后：更新 `checkpoint.md` 状态为 `completed`，追加「已完成步骤摘要」。

1. 按章节维度制定检索词（中文优先，可补充英文）。
2. 所有通过 search-web 打开的材料必须本地保存，不得只保留摘要。
3. 每条来源单独保存为 `Sxxx-来源短名.md`，包含：
    - 来源 URL
    - 检索词
    - 抓取时间
    - 所属章节
    - 原始抓取文本（完整保留）
4. 无论后续是否使用，均在 `source-index.md` 登记为 `used` 或 `unused`，并完成可用性评估字段填写。

### 第 2 步：资料可用性评估（强制）

> **过程记录联动**：
> - 开始前：在 `actions.log` 追加 `[EVAL] [started]`，更新 `checkpoint.md` 为 `step-2-evaluation / in-progress`。
> - 每完成一章的评估：在 `actions.log` 追加 `[EVAL] [completed]`，记录关联文件（如 `01-collection/chapter-01/source-index.md`），更新 `checkpoint.md` 的 `progress_detail` 和「已产出文件清单」。
> - 全部完成后：更新 `checkpoint.md` 状态为 `completed`，在 `timeline.md` 追加里程碑。

在每章 `source-index.md` 的评估矩阵中逐条评估并给出使用方式：

- 可访问性：全文可得、部分可得、受限不可得
- 权威性：官方/学术/机构/媒体/二手
- 时效性：是否满足主题时间窗口
- 相关性：与章节论点的直接关联度
- 可引用性：能否形成可核验引用
- 风险项：偏见、立场、样本局限、统计口径问题

每条材料都要给出“建议用途”：
- 直接证据
- 背景说明
- 反方观点
- 仅作线索（不直接引用）

### 第 3 步：收集后推理与验证

> **过程记录联动**：
> - 开始前：在 `actions.log` 追加 `[REASON] [started]`，更新 `checkpoint.md` 为 `step-3-reasoning / in-progress`。
> - 每完成一个子任务（推理/核验/学术校验/写作指导）：
>   - 在 `actions.log` 追加对应类型的 `[completed]` 记录（`REASON`/`VERIFY`/`VALIDATE`/`GUIDE`），记录关联文件。
>   - 更新 `checkpoint.md` 的 `progress_detail`（如「逻辑链已完成，事实核验进行中 8/12」）和「已产出文件清单」。
> - 遇到重大决策点时：同时写入 `decision-log.md` 和 `actions.log`（类型为 `DECISION`）。
> - 全部完成后：更新 `checkpoint.md` 状态为 `completed`，在 `timeline.md` 追加里程碑。

完成收集后，按顺序执行：

1. 逻辑推理：在 `02-reasoning/logic-chain.md` 建立“主张 -> 证据 -> 推论 -> 边界条件”。
2. 事实核验：在 `03-verification/fact-check-table.md` 做交叉来源核对。
3. 学术校验：在 `04-academic-validation/` 检查概念定义、方法适配、引用规范。
4. 形成写作指导文档：在 `05-writing-guide/` 输出章节写作指令。

未完成上述四项，不进入正式写作。

### 第 4 步：章节化写作与汇总

> **过程记录联动**：
> - 开始前：在 `actions.log` 追加 `[DRAFT] [started]`，更新 `checkpoint.md` 为 `step-4-writing / in-progress`。
> - 每完成一章的写作：在 `actions.log` 追加 `[DRAFT] [completed]`，记录关联文件（如 `06-drafts/01-引言.md`），更新 `checkpoint.md` 的 `progress_detail`（如「已完成 1-3 章，第 4 章写作中」）和「已产出文件清单」。
> - 修改已有章节时：在 `actions.log` 追加 `[EDIT]` 记录，说明修改内容与原因。
> - 全部完成后：更新 `checkpoint.md` 状态为 `completed`，在 `timeline.md` 追加里程碑。

1. 按 `05-writing-guide/chapter-outline.md` 逐章写入 `06-drafts/`。
2. 章节拆分阈值为弹性规则，按以下优先级确定：
   - **用户指定** > **体裁默认** > **全局默认**
   - 用户可在 `task-brief.md` 中自定义阈值。
   - 体裁默认参考值：
     | 体裁 | 全文阈值 | 单章阈值 |
     |------|---------|----------|
     | 学术论文 | 12000 字 | 3000 字 |
     | 研究报告 | 15000 字 | 3500 字 |
     | 深度特稿/评论 | 8000 字 | 2500 字 |
     | 新闻/解释性报道 | 6000 字 | 2000 字 |
     | 政策分析 | 15000 字 | 3000 字 |
   - 全局默认值：全文 15000 字 / 单章 3000 字。
   - 超过阈值时，必须分章文件 + 汇总文件并存。
3. 汇总稿统一输出为 `06-drafts/99-全文汇总.md`，交付稿输出到 `07-delivery/final-manuscript.md`。

### 第 5 步：终稿质检

> **过程记录联动**：
> - 开始前：在 `actions.log` 追加 `[REVIEW] [started]`，更新 `checkpoint.md` 为 `step-5-review / in-progress`。
> - 每完成一项质检维度：在 `actions.log` 追加 `[REVIEW] [completed]`，说明检查内容与结果。
> - 质检通过后：在 `actions.log` 追加 `[DELIVER] [completed]`，更新 `checkpoint.md` 为 `step-done / completed`，在 `timeline.md` 追加交付里程碑。

交付前必须完成：

- 逻辑链闭合：结论都能回溯到证据
- 事实可核验：关键陈述可定位到来源文件
- 引用一致：按 GB/T 7714 保持统一格式
- 风格达标：无明显 AI 套话、无空泛过渡、无机械排比
- 过程可追溯：日志与索引齐全

## 去 AI 痕迹写作规范

### 必须避免

- 套话起手（如“随着时代发展”）
- 空洞拔高（无证据的大词结论）
- 三段式机械排比与口号化收束
- 频繁“首先/其次/最后”且无实质推进
- 以模糊主语替代真实来源（如“有研究指出”但无出处）
- 同义改写堆字数

### 建议写法

- 先给可核验事实，再给解释
- 段内保持“主张 -> 机制 -> 证据 -> 小结/过渡”
- 有争议观点必须注明分歧来源
- 结论只覆盖证据支持的边界

## 体裁与产出等级

### 提纲版

- 输出研究问题、章节框架、每章证据计划、风险与待补项
- 必须体现论证顺序，而非仅列标题

### 初稿版

- 输出完整正文与基础引用
- 对证据薄弱处透明标注并给出补强路径

### 定稿版

- 结构收束、转承自然、引用完整、术语统一
- 不保留占位语句与未处理冲突

## 引用与参考文献

- 默认执行 GB/T 7714（参考 [references/gbt7714_quick_guide.md](references/gbt7714_quick_guide.md)）。
- 缺失元数据时宁缺勿造，不得虚构作者、年份、页码、机构。
- 分章与汇总稿的引用编号保持一致。

## 资源文件加载建议

- 交付拆分规则：见 [references/markdown_delivery_rules.md](references/markdown_delivery_rules.md)
- 体裁模板：见 [references/genre_templates.md](references/genre_templates.md)
- 引用规范：见 [references/gbt7714_quick_guide.md](references/gbt7714_quick_guide.md)

## 日志查询工具

`actions.log` 使用 JSON Lines 格式记录，推荐使用以下脚本读取和查询日志，避免直接用 AI 解析以减少 token 消耗：

| 脚本 | 适用环境 |
|------|---------|
| [scripts/read_actions_log.py](scripts/read_actions_log.py) | Python 3 |
| [scripts/read_actions_log.sh](scripts/read_actions_log.sh) | Bash / Linux / macOS |
| [scripts/read_actions_log.ps1](scripts/read_actions_log.ps1) | PowerShell / Windows |

支持的查询选项：`--last N`（最近 N 条）、`--step`（按步骤）、`--type`（按类型）、`--status`（按状态）、`--from-id`（从指定 ID 起）、`--json`（JSON 输出）。

## 分支决策规则

1. 资料不足：先补检索与可用性评估，不直接硬写。
2. 来源冲突：在 `contradiction-register.md` 登记冲突并给出处理策略。
3. 主题过大：先缩小问题边界，再推进章节写作。
4. 时效性强主题：优先近 6-12 个月材料，并在验证环节二次核对。

## 完成判定（DoD）

仅当以下条件全部满足才可判定完成：

1. 全文与过程文件均已本地落盘。
2. 所有检索材料已完整保存并登记。
3. 每章完成可用性评估与使用方式说明。
4. 已完成推理、核验、学术校验与写作指导文档。
5. 正文章节逻辑连贯、证据可追溯、引用格式统一。
6. 过程日志可复盘每一步行为。
7. `checkpoint.md` 最终状态为 `step-done / completed`。

## 断点续传机制

本技能支持任务中断后恢复。通过 `checkpoint.md` 与 `90-process-logs/` 下的过程记录文件联合工作，实现精细化的过程管理与无缝断点恢复。

### 过程管理体系

三个文件协同构成完整的过程管理链：

```text
checkpoint.md ──── 快照索引（当前在哪、下一步做什么）
     │
     ├── actions.log ── 主记录链（JSON Lines 格式，每个动作的ID、步骤、类型、状态、关联文件）
     │
     ├── timeline.md ── 里程碑记录（步骤转换事件，关联到具体动作ID）
     │
     └── decision-log.md ── 关键决策记录
```

**职责分工：**

| 文件 | 职责 | 粒度 |
|------|------|------|
| `checkpoint.md` | 快速定位当前进度 + 恢复入口 | 步骤/子任务级 |
| `actions.log` | 全量操作记录（JSON Lines），过程追溯的主链 | 单次操作级 |
| `timeline.md` | 里程碑事件，进度总览 | 步骤转换级 |
| `decision-log.md` | 关键决策记录 | 决策事件级 |

### 动作 ID 机制

`actions.log` 中每条记录有唯一动作 ID（格式 `A001`、`A002`...），全局递增。其他文件通过动作 ID 交叉引用：

- `checkpoint.md` 的 `last_action_id` → 定位到 actions.log 的最后操作
- `checkpoint.md` 的「已产出文件清单」→ 每个文件关联到产出它的动作 ID
- `timeline.md` 的「关联动作ID」→ 每个里程碑对应的 actions.log 条目

### 记录规则（强制）

每次执行操作时，必须按以下顺序同步更新过程文件：

1. **写 actions.log**：追加一行 JSON 记录，包含 action_id、time、step、type、status、message、files 字段。如有终端操作，额外记录 terminal_input 和 terminal_output。
2. **写 checkpoint.md**：更新 `last_action_id`、`last_updated`；如果进度发生变化，更新 `progress_detail` 和「已产出文件清单」。
3. **写 timeline.md**（如发生步骤转换）：追加里程碑记录，关联到触发转换的动作 ID。
4. **写 decision-log.md**（如有关键决策）：记录决策内容、理由、影响范围。

### checkpoint 更新时机

| 事件 | 更新内容 |
|------|---------|
| 开始新的工作流步骤 | `current_step`、`status` → `in-progress`、`last_action_id` |
| 完成步骤内关键子任务 | `progress_detail`（精确到章节/文件）、「已产出文件清单」追加新文件 |
| 完成整个步骤 | `status` → `completed`、追加「已完成步骤摘要」 |
| 遇到阻断/决策点 | `progress_detail` 记录阻断原因、`next_action` 记录待处理事项 |
| 每次会话结束前 | 无论是否完成当前步骤，必须写入 `next_action`（精确到文件级操作） |

### 恢复流程（强制）

当用户要求继续之前的任务、或 agent 检测到项目目录已存在时，执行以下恢复流程：

1. **读取 checkpoint.md**：获取 `current_step`、`status`、`last_action_id`、`next_action`。
2. **读取 actions.log**：从 `last_action_id` 处回溯最近 5-10 条记录，重建操作上下文。
3. **读取 timeline.md**：确认已完成的里程碑，与 checkpoint 的「已完成步骤摘要」交叉验证。
4. **校验文件完整性**：对照 checkpoint 的「已产出文件清单」，逐一检查文件是否存在且非空。
   - 如有文件缺失或损坏：在 actions.log 记录 `[RESUME]` 异常条目，回退到对应步骤重新执行。
   - 如文件完整：继续下一步。
5. **读取上下文文件**（按需）：
   - `task-brief.md`：回顾任务定义
   - `decision-log.md`：回顾影响当前步骤的关键决策
   - 当前步骤涉及的工作文件（如正在检索的章节目录、正在写作的草稿等）
6. **在 actions.log 中记录恢复事件**：追加 `[RESUME]` 类型条目，记录恢复时间和恢复点。
7. **向用户确认恢复**：简要汇报当前进度（来自 checkpoint）、最近操作（来自 actions.log）和下一步动作，确认后继续。
8. **从 `next_action` 指示的位置继续执行**，而非从头开始。

### 一致性保障

- **actions.log 是真相来源**：如果 checkpoint 与 actions.log 记录不一致，以 actions.log 的实际记录为准。
- **文件存在性优先于状态记录**：如果 checkpoint 标记某步骤已完成但产出文件缺失，视为未完成，回退重做。
- **timeline 与 checkpoint 双重验证**：恢复时 timeline 的里程碑记录必须与 checkpoint 的已完成步骤一一对应，发现不一致时以文件实际状态为准。
