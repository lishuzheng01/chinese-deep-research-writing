#!/usr/bin/env bash
# ============================================================
# 中文深度研究写作 - 项目初始化脚本
# 用法: bash init_project.sh <文章标题> [章节数]
# 示例: bash init_project.sh 平台劳动者权益保障研究 5
# ============================================================

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "用法: bash init_project.sh <文章标题> [章节数]"
  echo "示例: bash init_project.sh 平台劳动者权益保障研究 5"
  exit 1
fi

ARTICLE_TITLE="$1"
CHAPTER_COUNT="${2:-4}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="${SCRIPT_DIR}/../templates"
PROJECT_DIR="research-projects/${ARTICLE_TITLE}"

echo "正在创建项目目录: ${PROJECT_DIR}"

# ── 创建目录结构 ──
mkdir -p "${PROJECT_DIR}/00-project-meta"

for i in $(seq -w 1 "${CHAPTER_COUNT}"); do
  mkdir -p "${PROJECT_DIR}/01-collection/chapter-${i}/sources/pass-01"
  mkdir -p "${PROJECT_DIR}/01-collection/chapter-${i}/sources/pass-02"
done

for folder in 02-reasoning 03-verification 04-academic-validation \
              05-writing-guide 06-drafts 07-delivery 90-process-logs; do
  mkdir -p "${PROJECT_DIR}/${folder}"
done

# ── 复制模板文件 ──
if [ -d "${TEMPLATE_DIR}" ]; then
  # 00-project-meta
  for f in task-brief.md scope-and-constraints.md decision-log.md; do
    [ -f "${TEMPLATE_DIR}/00-project-meta/${f}" ] && cp "${TEMPLATE_DIR}/00-project-meta/${f}" "${PROJECT_DIR}/00-project-meta/${f}"
  done

  # 01-collection（每章复制一份）
  for i in $(seq -w 1 "${CHAPTER_COUNT}"); do
    for f in source-index.md; do
      [ -f "${TEMPLATE_DIR}/01-collection/${f}" ] && cp "${TEMPLATE_DIR}/01-collection/${f}" "${PROJECT_DIR}/01-collection/chapter-${i}/${f}"
    done
  done

  # 02-reasoning
  for f in claim-map.md logic-chain.md contradiction-register.md; do
    [ -f "${TEMPLATE_DIR}/02-reasoning/${f}" ] && cp "${TEMPLATE_DIR}/02-reasoning/${f}" "${PROJECT_DIR}/02-reasoning/${f}"
  done

  # 03-verification
  for f in fact-check-table.md cross-source-check.md unresolved-items.md; do
    [ -f "${TEMPLATE_DIR}/03-verification/${f}" ] && cp "${TEMPLATE_DIR}/03-verification/${f}" "${PROJECT_DIR}/03-verification/${f}"
  done

  # 04-academic-validation
  for f in concept-definitions.md method-validity.md citation-audit.md; do
    [ -f "${TEMPLATE_DIR}/04-academic-validation/${f}" ] && cp "${TEMPLATE_DIR}/04-academic-validation/${f}" "${PROJECT_DIR}/04-academic-validation/${f}"
  done

  # 05-writing-guide
  for f in chapter-outline.md argument-order.md style-guardrails.md; do
    [ -f "${TEMPLATE_DIR}/05-writing-guide/${f}" ] && cp "${TEMPLATE_DIR}/05-writing-guide/${f}" "${PROJECT_DIR}/05-writing-guide/${f}"
  done

  # 90-process-logs
  for f in actions.log timeline.md; do
    [ -f "${TEMPLATE_DIR}/90-process-logs/${f}" ] && cp "${TEMPLATE_DIR}/90-process-logs/${f}" "${PROJECT_DIR}/90-process-logs/${f}"
  done

else
  echo "⚠️  模板目录不存在: ${TEMPLATE_DIR}，跳过模板复制（目录结构已创建）"
fi

# ── 写入初始化日志（JSON 格式） ──
INIT_TIME="$(date '+%Y-%m-%d %H:%M')"
LOG_FILE="${PROJECT_DIR}/90-process-logs/actions.log"

if [ -f "${LOG_FILE}" ]; then
  # 使用 printf 写入 JSON 行，避免特殊字符问题
  printf '{"action_id":"A001","time":"%s","step":"step-0-init","type":"INIT","status":"completed","message":"项目初始化完成，标题: %s，章节数: %s","files":["task-brief.md","checkpoint.md","README.md"]}\n' \
    "${INIT_TIME}" "${ARTICLE_TITLE}" "${CHAPTER_COUNT}" >> "${LOG_FILE}"
fi

# ── 生成 README.md ──
cat > "${PROJECT_DIR}/README.md" <<EOF
# ${ARTICLE_TITLE}

> 创建时间: ${INIT_TIME} | 章节数: ${CHAPTER_COUNT}

## 项目概述

（请在此处用 3-5 句话描述本项目的研究内容与目标。结合主题、体裁、目标读者、核心问题等信息进行填写，不要过于简单也不要过于冗长。）

## 项目结构

| 目录 | 用途 |
|------|------|
| \`00-project-meta/\` | 任务定义、范围约束、决策日志、断点续传 |
| \`01-collection/\` | 按章节组织的检索材料与可用性评估 |
| \`02-reasoning/\` | 主张映射、逻辑链、矛盾登记 |
| \`03-verification/\` | 事实核验、交叉来源核对 |
| \`04-academic-validation/\` | 概念定义、方法校验、引用审计 |
| \`05-writing-guide/\` | 章节提纲、论证顺序、风格约束 |
| \`06-drafts/\` | 各章节初稿与全文汇总 |
| \`07-delivery/\` | 最终交付稿与参考文献 |
| \`90-process-logs/\` | 行为日志、时间线 |

## 当前状态

请查看 \`00-project-meta/checkpoint.md\` 获取最新进度。
EOF

# ── 初始化 checkpoint ──
CHECKPOINT_SRC="${TEMPLATE_DIR}/00-project-meta/checkpoint.md"
CHECKPOINT_DST="${PROJECT_DIR}/00-project-meta/checkpoint.md"

if [ -f "${CHECKPOINT_SRC}" ]; then
  cp "${CHECKPOINT_SRC}" "${CHECKPOINT_DST}"
  sed -i \
    -e "s|（当前步骤标识，如 step-1-collection）|step-0-init|g" \
    -e "s|in-progress|completed|g" \
    -e "s|（最后一条动作 ID，如 A012）|A001|g" \
    -e "s|（描述当前阶段内的详细进度。须具体到章节/子任务粒度。）|项目初始化完成，所有目录与模板文件已就绪|g" \
    -e "s|（恢复后应执行的第一个具体操作。须精确到文件级别。）|填写 task-brief.md，然后开始第 1 步检索|g" \
    -e "s|YYYY-MM-DD HH:MM|${INIT_TIME}|g" \
    "${CHECKPOINT_DST}"
else
  cat > "${CHECKPOINT_DST}" <<CPEOF
# 断点续传状态

| 字段 | 内容 |
|------|------|
| current_step | step-0-init |
| status | completed |
| last_action_id | A001 |
| last_updated | ${INIT_TIME} |

## 下一步动作

填写 task-brief.md，然后开始第 1 步检索
CPEOF
fi

# ── 更新 timeline 初始记录 ──
TIMELINE_FILE="${PROJECT_DIR}/90-process-logs/timeline.md"
if [ -f "${TIMELINE_FILE}" ]; then
  sed -i "s|YYYY-MM-DD HH:MM | step-0-init|${INIT_TIME} | step-0-init|g" "${TIMELINE_FILE}" 2>/dev/null || true
fi

echo ""
echo "项目初始化完成"
echo "  路径: ${PROJECT_DIR}"
echo "  标题: ${ARTICLE_TITLE}"
echo "  章节数: ${CHAPTER_COUNT}"
echo ""
echo "下一步:"
echo "  1. 编辑 README.md 填写项目概述"
echo "  2. 编辑 00-project-meta/task-brief.md 填写任务定义"
echo "  3. 编辑 00-project-meta/scope-and-constraints.md 确定范围与约束"
echo "  4. 开始按章节执行检索"
