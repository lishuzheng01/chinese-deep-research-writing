# 第 0 步：任务建档与初始化

## 操作清单

1. 使用文章标题作为项目目录名，运行初始化脚本创建标准目录结构。
2. 生成 `README.md`：结合主题、体裁、目标读者、核心问题，用 3-5 句话概要描述研究内容与目标。
3. 填写 `00-project-meta/task-brief.md`：主题、目标读者、体裁、产出等级（提纲/初稿/定稿）、篇幅要求。
4. 填写 `00-project-meta/scope-and-constraints.md`：范围界定与硬约束。
5. 更新 `00-project-meta/checkpoint.md`：`current_step` = `step-0-init`，`status` = `completed`。

## 初始化脚本

使用以下任一脚本，传入文章标题和章节数：

- Python：`python init_project.py <文章标题> [章节数]`
- Bash：`bash init_project.sh <文章标题> [章节数]`
- PowerShell：`.\init_project.ps1 -ArticleTitle "<文章标题>" [-ChapterCount N]`

## 完成标志

- 项目目录结构完整
- task-brief.md 已填写
- checkpoint.md 状态为 completed
