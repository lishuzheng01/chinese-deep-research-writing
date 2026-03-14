# 版本2.1.0

## 变更内容

### 流程设计
1. **步骤回退机制**：Step 3/4/5 发现前置步骤产出不足时，可回退到 Step 1/2/3 补充材料，checkpoint 记录回退原因
2. **上下文窗口预算**：新增 `references/context_budget.md`，定义各步骤输入输出预算、材料压缩三级策略和超限处理规则
3. **用户自备材料导入**：`workflow_step1_collection.md` 增加用户素材存放路径（`01-collection/user-provided/`）、评估流程和来源标记规则
4. **检索工具降级方案**：当 search-web 不可用时，支持 fetch_webpage 替代、用户手动提供和已有材料优先三种降级路径

### 模板体系
5. **source-index.md 重构**：从 13 列宽表格改为"每条来源一个区块"的列表式排版，可读性大幅提升
6. **checkpoint 字段统一**：所有字段名统一为中文（当前步骤、状态、最后更新、进度明细、下一步动作、已完成步骤、关键决策）
7. **新增参考文献汇总模板**：`templates/07-delivery/references.md`，预置 GB/T 7714 格式示例和编号规则
8. **新增章节草稿模板**：`templates/06-drafts/chapter-draft.md`，包含论证目标、引用占位、待处理事项

### 脚本工程
9. **幂等性保护**：三套脚本在目标目录已存在时提示用户确认，不再静默覆盖
10. **模板完整性校验**：脚本复制前校验所有必需模板文件，缺失时给出明确错误信息
11. **标题特殊字符处理**：自动将文件系统不允许的字符（全角冒号、问号等）替换为短横线
12. **脚本一致性保障**：三套脚本同步更新，行为一致

### 渐进式披露
13. **去 AI 痕迹段落迁移**：从 SKILL.md 迁出到独立文件 `references/anti_ai_style_guide.md`，入口文档仅保留引用链接
14. **体裁模板拆分**：`genre_templates.md` 改为索引，7 种体裁各自独立为 `references/genres/` 下的文件，Step 0 确认体裁后只加载对应文件

### 可用性
15. **快速入门指南**：新增 `QUICKSTART.md`，用一个具体示例演示从初始化到交付的最短路径
16. **版本迁移指南**：CHANGELOG 每个大版本增加迁移步骤

## 从 2.0.0 迁移到 2.1.0

### 必须手动调整
1. **checkpoint.md 字段名**：将现有项目中的 `current_step` → `当前步骤`、`status` → `状态`、`last_updated` → `最后更新` 更新，或重新从模板复制
2. **source-index.md 格式**：新格式为列表式排版，建议从模板重新复制并手动迁移已有数据
3. **项目目录**：如需使用用户自备材料导入功能，手动创建 `01-collection/user-provided/originals/` 目录

### 自动兼容（无需手动操作）
- 新增的 reference 文件（context_budget.md、anti_ai_style_guide.md、genres/）不影响已有项目
- 新增模板（06-drafts/chapter-draft.md、07-delivery/references.md）在新项目初始化时自动复制，已有项目可按需手动复制

---

# 版本1.0.0
## 优化改进

1.项目的起名必须有明确的名称，具体的名称和文章的标题名称保持一致

2.项目的描述必须有明确的描述，具体的描述结合整个项目的内容进行描述，不能过于简单或者过于复杂。保存在根目录，命名为README.md

3.实现整个项目的断点续传功能

# 版本1.0.1
## 优化改进

1.命令行工具支持
 - Python脚本：`init_project.py`
 - Bash脚本：`init_project.sh`
 - powershell脚本：`init_project.ps1` 

2.action.log日志文件功能变更
 - 记录终端输入命令和终端输出内容
 - 使用JSON格式记录，便于后续分析和调试
 - 使用自动化脚本进行读取输出，避免直接使用AI导致token消耗过多
   - 脚本包含“Python”、“Bash”、“powershell”三种版本，满足不同用户需求
 - 删除tool-usage.log日志文件及其对应功能，减少冗余日志记录
 - 更新频率保持不变
 
3.合并相似模板
 - 合并检索模板：将 source-index.md 和 availability-eval.md 合并

# 版本2.0.0

1.全面简化日志记录，仅满足断点传续功能即可。
2.增强渐进式披露的特性，缓解模型的记忆负担，提升模型的理解和响应能力。

## 实施明细

1.日志体系简化为单文件 checkpoint
 - 保留：`templates/00-project-meta/checkpoint.md`
 - 删除：`templates/00-project-meta/decision-log.md`
 - 删除：`templates/90-process-logs/`（含 `actions.log`、`timeline.md`）
 - 删除：`scripts/read_actions_log.py`、`scripts/read_actions_log.sh`、`scripts/read_actions_log.ps1`

2.断点续传协议更新
 - checkpoint 模板字段精简为：`current_step`、`status`、`last_updated`、`progress_detail`、`next_action`、`已完成步骤`、`关键决策`
 - 不再使用动作 ID（A001/A002）与多文件联动记录

3.渐进式披露落地
 - `SKILL.md` 重构为入口文档，只保留概览与步骤入口
 - 新增并启用按需加载文件：
   - `references/workflow_step0_init.md`
   - `references/workflow_step1_collection.md`
   - `references/workflow_step2_evaluation.md`
   - `references/workflow_step3_reasoning.md`
   - `references/workflow_step4_writing.md`
   - `references/workflow_step5_review.md`
   - `references/template_guide.md`
   - `references/checkpoint_protocol.md`

4.初始化脚本同步升级
 - 更新：`scripts/init_project.py`
 - 更新：`scripts/init_project.sh`
 - 更新：`scripts/init_project.ps1`
 - 调整内容：
   - 移除 `90-process-logs` 目录创建
   - 移除 `decision-log.md`、`actions.log`、`timeline.md` 的模板复制
   - 移除初始化日志写入逻辑
   - README 项目结构说明同步去除旧日志目录描述
   - checkpoint 初始化逻辑改为简化字段模型

## 从 1.0.1 迁移到 2.0.0

1. 删除项目中的 `90-process-logs/` 目录（含 `actions.log`、`timeline.md`）
2. 删除 `00-project-meta/decision-log.md`
3. 重新从模板复制 `00-project-meta/checkpoint.md`，按新字段模型填写
4. 重新运行初始化脚本或手动对齐目录结构


