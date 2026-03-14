# 第 1 步：检索与全量留存

> 先于写作完成，所有材料必须本地保存。

## 操作清单

1. 按章节维度制定检索词（中文优先，可补充英文）。
2. 所有通过 search-web 打开的材料必须本地保存，不得只保留摘要。
3. 每条来源单独保存为 `Sxxx-来源短名.md`，存入 `01-collection/chapter-NN/sources/pass-XX/`，包含：
   - 来源 URL
   - 检索词
   - 抓取时间
   - 所属章节
   - 原始抓取文本（完整保留）
4. 无论后续是否使用，均在 `source-index.md` 登记为 `used` 或 `unused`，并完成可用性评估字段填写。

## checkpoint 更新

- 开始时：`current_step` = `step-1-collection`，`status` = `in-progress`
- 进行中：更新 `progress_detail`（如「chapter-01 检索完成，已获取 5 条来源」）
- 完成后：`status` = `completed`，更新「已完成步骤」

## 完成标志

- 所有章节的检索材料已本地保存
- 每条来源在 source-index.md 中有登记
