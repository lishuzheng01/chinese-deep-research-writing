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

# ── 标题清洗 ──
sanitize_dirname() {
  local cleaned="$1"
  # 替换文件系统不允许的字符
  cleaned=$(echo "$cleaned" | sed 's/[\\/:*?"<>|]/-/g')
  cleaned=$(echo "$cleaned" | sed 's/[：？！＊＜＞｜]/-/g')
  cleaned=$(echo "$cleaned" | sed 's/-\{2,\}/-/g')
  cleaned=$(echo "$cleaned" | sed 's/^[- ]*//;s/[- ]*$//')
  echo "$cleaned"
}

DIR_NAME=$(sanitize_dirname "$ARTICLE_TITLE")

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="${SCRIPT_DIR}/../templates"
PROJECT_DIR="research-projects/${DIR_NAME}"

# ── 幂等性保护 ──
if [ -d "${PROJECT_DIR}" ]; then
  echo "错误：项目目录已存在: ${PROJECT_DIR}"
  echo "如需重新初始化，请先手动删除或重命名该目录。"
  exit 1
fi

echo "正在创建项目目录: ${PROJECT_DIR}"

# ── 模板完整性校验 ──
REQUIRED_TEMPLATES=(
  "00-project-meta/task-brief.md"
  "00-project-meta/scope-and-constraints.md"
  "00-project-meta/checkpoint.md"
  "01-collection/source-index.md"
  "01-collection/source-capture.md"
  "02-reasoning/claim-map.md"
  "02-reasoning/logic-chain.md"
  "02-reasoning/contradiction-register.md"
  "03-verification/fact-check-table.md"
  "03-verification/cross-source-check.md"
  "03-verification/unresolved-items.md"
  "04-academic-validation/concept-definitions.md"
  "04-academic-validation/method-validity.md"
  "04-academic-validation/citation-audit.md"
  "05-writing-guide/chapter-outline.md"
  "05-writing-guide/argument-order.md"
  "05-writing-guide/style-guardrails.md"
  "06-drafts/chapter-draft.md"
  "07-delivery/references.md"
)

if [ -d "${TEMPLATE_DIR}" ]; then
  MISSING=()
  for t in "${REQUIRED_TEMPLATES[@]}"; do
    if [ ! -f "${TEMPLATE_DIR}/${t}" ]; then
      MISSING+=("  - ${t}")
    fi
  done
  if [ ${#MISSING[@]} -gt 0 ]; then
    echo "错误：以下模板文件缺失，请检查 templates 目录："
    printf '%s\n' "${MISSING[@]}"
    exit 1
  fi
else
  echo "⚠️  模板目录不存在: ${TEMPLATE_DIR}，将只创建目录结构，不复制模板。"
fi

# ── 创建目录结构 ──
mkdir -p "${PROJECT_DIR}/00-project-meta"

for i in $(seq -w 1 "${CHAPTER_COUNT}"); do
  mkdir -p "${PROJECT_DIR}/01-collection/chapter-${i}/sources/pass-01"
  mkdir -p "${PROJECT_DIR}/01-collection/chapter-${i}/sources/pass-02"
done

for folder in 02-reasoning 03-verification 04-academic-validation \
              05-writing-guide 06-drafts 07-delivery; do
  mkdir -p "${PROJECT_DIR}/${folder}"
done

# 用户自备材料目录
mkdir -p "${PROJECT_DIR}/01-collection/user-provided/originals"

# ── 复制模板文件 ──
if [ -d "${TEMPLATE_DIR}" ]; then
  # 00-project-meta
  for f in task-brief.md scope-and-constraints.md; do
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

  # 06-drafts
  [ -f "${TEMPLATE_DIR}/06-drafts/chapter-draft.md" ] && cp "${TEMPLATE_DIR}/06-drafts/chapter-draft.md" "${PROJECT_DIR}/06-drafts/chapter-draft.md"

  # 07-delivery
  [ -f "${TEMPLATE_DIR}/07-delivery/references.md" ] && cp "${TEMPLATE_DIR}/07-delivery/references.md" "${PROJECT_DIR}/07-delivery/references.md"

else
  echo "⚠️  模板目录不存在: ${TEMPLATE_DIR}，跳过模板复制（目录结构已创建）"
fi

INIT_TIME="$(date '+%Y-%m-%d %H:%M')"

# ── 生成 README.md ──
cat > "${PROJECT_DIR}/README.md" <<EOF
# ${ARTICLE_TITLE}

> 创建时间: ${INIT_TIME} | 章节数: ${CHAPTER_COUNT}

## 项目概述

（请在此处用 3-5 句话描述本项目的研究内容与目标。结合主题、体裁、目标读者、核心问题等信息进行填写，不要过于简单也不要过于冗长。）

## 项目结构

| 目录 | 用途 |
|------|------|
| \`00-project-meta/\` | 任务定义、范围约束、断点续传 |
| \`01-collection/\` | 按章节组织的检索材料与可用性评估 |
| \`01-collection/user-provided/\` | 用户自备材料导入 |
| \`02-reasoning/\` | 主张映射、逻辑链、矛盾登记 |
| \`03-verification/\` | 事实核验、交叉来源核对 |
| \`04-academic-validation/\` | 概念定义、方法校验、引用审计 |
| \`05-writing-guide/\` | 章节提纲、论证顺序、风格约束 |
| \`06-drafts/\` | 各章节初稿与全文汇总 |
| \`07-delivery/\` | 最终交付稿与参考文献 |

## 当前状态

请查看 \`00-project-meta/checkpoint.md\` 获取最新进度。
EOF

# ── 初始化 checkpoint ──
CHECKPOINT_SRC="${TEMPLATE_DIR}/00-project-meta/checkpoint.md"
CHECKPOINT_DST="${PROJECT_DIR}/00-project-meta/checkpoint.md"

if [ -f "${CHECKPOINT_SRC}" ]; then
  cp "${CHECKPOINT_SRC}" "${CHECKPOINT_DST}"
  sed -i \
    -e "s|（如 step-1-collection）|step-0-init|g" \
    -e "s|\| 状态 \| not-started \||\| 状态 \| completed \||g" \
    -e "s|（当前阶段内的具体进度，1-2 句话。）|项目初始化完成，所有目录与模板文件已就绪|g" \
    -e "s|（恢复后应执行的第一个具体操作，精确到文件级别。）|填写 task-brief.md，然后开始第 1 步检索|g" \
    -e "s|YYYY-MM-DD HH:MM|${INIT_TIME}|g" \
    "${CHECKPOINT_DST}"
else
  cat > "${CHECKPOINT_DST}" <<CPEOF
# 断点续传状态

| 字段 | 内容 |
|------|------|
| 当前步骤 | step-0-init |
| 状态 | completed |
| 最后更新 | ${INIT_TIME} |

## 进度明细

项目初始化完成，所有目录与模板文件已就绪。

## 下一步动作

填写 task-brief.md，然后开始第 1 步检索
CPEOF
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
