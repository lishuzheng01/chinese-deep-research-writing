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
