# 断点续传状态

> 本文件是项目进度的「快照索引」。与 `90-process-logs/actions.log` 联合使用，实现精细化的过程管理与断点恢复。
> - **快速定位**：看本文件即可判断从哪里继续。
> - **细节追溯**：通过 `last_action_id` 定位到 `actions.log` 的具体条目，重建完整上下文。

## 当前状态

| 字段 | 内容 |
|------|------|
| current_step | （当前步骤标识，如 step-1-collection） |
| status | in-progress |
| last_action_id | （最后一条动作 ID，如 A012） |
| last_updated | YYYY-MM-DD HH:MM |

## 进度明细

（描述当前阶段内的详细进度。须具体到章节/子任务粒度。）

示例：
- step-1-collection：已完成 chapter-01、chapter-02 检索，chapter-03 检索进行中（已获取 3 条来源，尚需补充政策类材料）
- step-3-reasoning：逻辑链已完成，事实核验进行中（已核验 8/12 条关键事实）

## 下一步动作

（恢复后应执行的第一个具体操作。须精确到文件级别。）

示例：在 `01-collection/chapter-03/` 继续执行检索，检索词为「XXX」

## 已产出文件清单

> 列出当前已实际产出的关键文件，用于恢复时校验完整性。

| 文件路径 | 产出步骤 | 完成状态 | 关联动作ID |
|---------|---------|---------|------------|
| 00-project-meta/task-brief.md | step-0-init | done | A001 |

## 已完成步骤摘要

| 步骤 | 完成时间 | 关键结论/产出 | 起止动作ID |
|------|---------|--------------|------------|
| step-0-init | | 项目初始化完成 | A001 |

## 过程文件交叉索引

> 恢复时应读取的过程文件及其用途。

| 过程文件 | 用途 | 恢复时是否必读 |
|---------|------|---------------|
| 90-process-logs/actions.log | 从 `last_action_id` 处回溯近期动作 | 是 |
| 90-process-logs/timeline.md | 确认里程碑完成情况 | 是 |
| 00-project-meta/decision-log.md | 回顾关键决策 | 按需 |
