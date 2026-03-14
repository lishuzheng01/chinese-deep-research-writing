# 模板文件清单与分类

所有模板位于 `templates/` 目录下，按阶段分类。初始化脚本会自动复制到项目目录。

## A 类：任务定义（项目启动时填写）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| templates/00-project-meta/task-brief.md | 任务定义：主题、体裁、读者、产出等级、篇幅、拆分阈值 | `00-project-meta/` |
| templates/00-project-meta/scope-and-constraints.md | 范围界定与硬约束 | `00-project-meta/` |
| templates/00-project-meta/checkpoint.md | 断点续传状态记录 | `00-project-meta/` |

## B 类：检索与评估（每章各一份）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| templates/01-collection/source-index.md | 来源登记索引 + 可用性六维评估 + 使用方式建议 | `01-collection/chapter-NN/` |
| templates/01-collection/source-capture.md | 单条来源捕获格式 | `01-collection/chapter-NN/sources/` |

## C 类：推理与验证（全局各一份）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| templates/02-reasoning/claim-map.md | 主张清单与证据映射 | `02-reasoning/` |
| templates/02-reasoning/logic-chain.md | 主张→证据→推论→边界条件 | `02-reasoning/` |
| templates/02-reasoning/contradiction-register.md | 信息冲突登记与处理策略 | `02-reasoning/` |
| templates/03-verification/fact-check-table.md | 关键事实交叉核验 | `03-verification/` |
| templates/03-verification/cross-source-check.md | 多来源一致性核对 | `03-verification/` |
| templates/03-verification/unresolved-items.md | 未解决事项跟踪 | `03-verification/` |

## D 类：学术校验（全局各一份）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| templates/04-academic-validation/concept-definitions.md | 核心概念定义一致性检查 | `04-academic-validation/` |
| templates/04-academic-validation/method-validity.md | 分析方法适配性校验 | `04-academic-validation/` |
| templates/04-academic-validation/citation-audit.md | 引用完整性与格式审计 | `04-academic-validation/` |

## E 类：写作指导（全局各一份）

| 模板文件 | 用途 | 目标路径 |
|---------|------|----------|
| templates/05-writing-guide/chapter-outline.md | 章节提纲与证据计划 | `05-writing-guide/` |
| templates/05-writing-guide/argument-order.md | 论证顺序与过渡策略 | `05-writing-guide/` |
| templates/05-writing-guide/style-guardrails.md | 体裁风格约束（含去 AI 检查清单） | `05-writing-guide/` |
