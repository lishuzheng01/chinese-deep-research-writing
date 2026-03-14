# 第 3 步：收集后推理与验证

> 完成收集后，按顺序执行以下四个子任务。未完成全部四项，不进入正式写作。

## 子任务 1：逻辑推理

在 `02-reasoning/logic-chain.md` 建立：

- 主张 → 证据 → 推论 → 边界条件

辅助文件：
- `02-reasoning/claim-map.md`：主张清单与证据映射
- `02-reasoning/contradiction-register.md`：信息冲突登记与处理策略

## 子任务 2：事实核验

在 `03-verification/fact-check-table.md` 做交叉来源核对。

辅助文件：
- `03-verification/cross-source-check.md`：多来源一致性核对
- `03-verification/unresolved-items.md`：未解决事项跟踪

## 子任务 3：学术校验

在 `04-academic-validation/` 检查：
- `concept-definitions.md`：核心概念定义一致性
- `method-validity.md`：分析方法适配性
- `citation-audit.md`：引用完整性与格式审计

## 子任务 4：形成写作指导文档

在 `05-writing-guide/` 输出：
- `chapter-outline.md`：章节提纲与证据计划
- `argument-order.md`：论证顺序与过渡策略
- `style-guardrails.md`：体裁风格约束

## 回退触发条件

在推理验证过程中，如果出现以下情况，必须回退到 Step 1（检索）或 Step 2（评估）补充材料：

| 触发条件 | 回退目标 | 回退范围 |
|---------|---------|----------|
| 某章核心主张缺少 2 条以上独立来源支撑 | Step 1 | 该章补充检索 |
| fact-check-table 中关键事实无法交叉验证 | Step 1 | 定向补检相关事实 |
| 评估发现来源权威性或时效性不足 | Step 2 | 重新评估并标记需替换来源 |
| 冲突登记中发现无法调和的矛盾且缺少权威来源裁决 | Step 1 | 针对冲突点补充权威来源 |

### 回退操作流程

1. 在 checkpoint 中记录回退原因（写入「关键决策」表）。
2. `当前步骤` 更新为回退目标步骤（如 `step-1-collection`），`状态` = `in-progress`。
3. `进度明细` 标注「从 step-3 回退，原因：XXX」。
4. 仅补充缺失部分，不重复已完成的检索或评估。
5. 补充完成后，重新进入 Step 3 继续后续子任务。

## checkpoint 更新

- 开始时：`当前步骤` = `step-3-reasoning`，`状态` = `in-progress`
- 进行中：更新 `进度明细`（如「逻辑链已完成，事实核验进行中 8/12」）
- 遇到重大决策：写入 checkpoint 的「关键决策」表
- 回退时：按上述回退操作流程更新 checkpoint
- 完成后：`状态` = `completed`

## 完成标志

- 逻辑链文件完整
- 事实核验覆盖所有关键事实
- 学术校验三个文件已填写
- 写作指导三个文件已产出
