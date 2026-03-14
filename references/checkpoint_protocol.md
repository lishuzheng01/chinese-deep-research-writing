# 断点续传协议

## checkpoint.md 字段说明

| 字段 | 说明 |
|------|------|
| current_step | 当前步骤标识（step-0-init ~ step-done） |
| status | not-started / in-progress / completed |
| last_updated | 最后更新时间 |
| progress_detail | 当前进度描述，1-2 句话 |
| next_action | 恢复后第一个操作，精确到文件 |
| 已完成步骤 | 步骤 + 完成时间 + 一句话小结 |
| 关键决策 | 时间 + 决策 + 理由 |

## 更新时机

| 事件 | 更新内容 |
|------|---------|
| 开始新步骤 | current_step、status → in-progress |
| 完成步骤内关键子任务 | progress_detail |
| 完成整个步骤 | status → completed、追加「已完成步骤」 |
| 遇到阻断或重大决策 | progress_detail 记录原因、追加「关键决策」 |
| 会话结束前 | 必须写入 next_action |

## 步骤标识对照表

| 步骤标识 | 阶段名称 |
|---------|---------|
| step-0-init | 初始化 |
| step-1-collection | 检索与留存 |
| step-2-evaluation | 可用性评估 |
| step-3-reasoning | 推理与验证 |
| step-4-writing | 章节化写作 |
| step-5-review | 终稿质检 |
| step-done | 全部完成 |

## 恢复流程

当用户要求继续之前的任务、或检测到项目目录已存在时：

1. **读取 checkpoint.md**：获取 current_step、status、next_action。
2. **校验关键文件**：检查当前步骤涉及的产出文件是否存在且非空。
   - 文件缺失或损坏：回退到对应步骤重新执行。
   - 文件完整：继续下一步。
3. **按需读取上下文**：
   - `task-brief.md`：回顾任务定义
   - 当前步骤涉及的工作文件
4. **向用户确认恢复**：汇报当前进度和下一步动作，确认后继续。
5. **从 next_action 继续执行**，而非从头开始。

## 一致性保障

- **文件存在性优先于状态记录**：如果 checkpoint 标记某步骤已完成但产出文件缺失，视为未完成，回退重做。
