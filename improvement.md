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