# 快速入门

用一个具体示例演示从初始化到交付的最短路径。

## 示例任务

写一篇 3000 字的行业分析报告：「中国新能源汽车出口竞争力分析」，目标读者为行业研究人员，产出等级为初稿。

## 第 1 步：初始化项目

```bash
# 任选一种脚本运行
python scripts/init_project.py "中国新能源汽车出口竞争力分析" 3
# 或
bash scripts/init_project.sh "中国新能源汽车出口竞争力分析" 3
# 或
.\scripts\init_project.ps1 -ArticleTitle "中国新能源汽车出口竞争力分析" -ChapterCount 3
```

完成后检查 `research-projects/中国新能源汽车出口竞争力分析/` 目录结构是否完整。

## 第 2 步：填写任务定义

编辑以下文件：
- `00-project-meta/task-brief.md`：填入主题、体裁（行业研究报告）、读者、产出等级（初稿）、篇幅（3000 字）
- `00-project-meta/scope-and-constraints.md`：限定分析范围（如2023-2025年数据）

## 第 3 步：按章节检索

对每章执行 search-web 检索，所有来源保存到 `01-collection/chapter-NN/sources/pass-01/`。
在各章的 `source-index.md` 中登记所有来源。

## 第 4 步：可用性评估

对 source-index 中的每条来源完成六维评估（可访问性、权威性、时效性、相关性、可引用性、风险项），标注建议用途。

## 第 5 步：推理与验证

按顺序完成：
1. `02-reasoning/` — 逻辑链构建、主张映射、矛盾登记
2. `03-verification/` — 事实核验、交叉来源核对
3. `04-academic-validation/` — 概念定义、引用审计
4. `05-writing-guide/` — 章节提纲、论证顺序、风格约束

## 第 6 步：写作与汇总

按 chapter-outline.md 逐章写入 `06-drafts/`，最后生成 `06-drafts/99-全文汇总.md`。

## 第 7 步：质检与交付

完成逻辑、事实、引用、风格四类质检，将终稿输出到 `07-delivery/final-manuscript.md`，参考文献输出到 `07-delivery/references.md`。

## 关键文件速查

| 需要做什么 | 查看哪个文件 |
|-----------|------------|
| 了解完整工作流 | `SKILL.md` |
| 查看当前进度 | `00-project-meta/checkpoint.md` |
| 查看模板清单 | `references/template_guide.md` |
| 查看引用规范 | `references/gbt7714_quick_guide.md` |
| 查看体裁模板 | `references/genre_templates.md` → 各体裁文件 |
| 查看断点续传规则 | `references/checkpoint_protocol.md` |
