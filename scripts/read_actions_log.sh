#!/usr/bin/env bash
# ============================================================
# actions.log 日志读取与查询工具（Bash 版）
#
# 用法:
#   bash read_actions_log.sh <日志文件路径> [选项]
#
# 选项:
#   --last N          显示最近 N 条记录
#   --step STEP       按步骤标识过滤
#   --type TYPE       按动作类型过滤
#   --status STATUS   按状态过滤
#   --from-id ID      从指定动作 ID 开始显示
#   --json            以 JSON 原始格式输出
#
# 依赖: grep, tail, awk（标准 Unix 工具）
# 可选依赖: jq（用于 JSON 格式化输出）
#
# 示例:
#   bash read_actions_log.sh 90-process-logs/actions.log
#   bash read_actions_log.sh 90-process-logs/actions.log --last 10
#   bash read_actions_log.sh 90-process-logs/actions.log --step step-1-collection
# ============================================================

set -euo pipefail

# ── 参数解析 ──
LOGFILE=""
LAST=""
STEP=""
TYPE=""
STATUS=""
FROM_ID=""
OUTPUT_JSON=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --last)   LAST="$2"; shift 2 ;;
        --step)   STEP="$2"; shift 2 ;;
        --type)   TYPE="$2"; shift 2 ;;
        --status) STATUS="$2"; shift 2 ;;
        --from-id) FROM_ID="$2"; shift 2 ;;
        --json)   OUTPUT_JSON=true; shift ;;
        -h|--help)
            head -25 "$0" | grep '^#' | sed 's/^# \?//'
            exit 0
            ;;
        *)
            if [ -z "$LOGFILE" ]; then
                LOGFILE="$1"
            else
                echo "错误: 未知参数 $1" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

if [ -z "$LOGFILE" ]; then
    echo "用法: bash read_actions_log.sh <日志文件路径> [选项]" >&2
    echo "使用 --help 查看详细帮助" >&2
    exit 1
fi

if [ ! -f "$LOGFILE" ]; then
    echo "错误: 文件不存在 - $LOGFILE" >&2
    exit 1
fi

# ── 提取 JSON 行（跳过 Markdown 头部和注释） ──
extract_json_lines() {
    grep -E '^\{' "$LOGFILE" 2>/dev/null || true
}

# ── 过滤逻辑 ──
apply_filters() {
    local input
    input=$(cat)

    if [ -n "$STEP" ]; then
        input=$(echo "$input" | grep "\"step\":\"$STEP\"" || true)
    fi

    if [ -n "$TYPE" ]; then
        local upper_type
        upper_type=$(echo "$TYPE" | tr '[:lower:]' '[:upper:]')
        input=$(echo "$input" | grep "\"type\":\"$upper_type\"" || true)
    fi

    if [ -n "$STATUS" ]; then
        input=$(echo "$input" | grep "\"status\":\"$STATUS\"" || true)
    fi

    if [ -n "$FROM_ID" ]; then
        input=$(echo "$input" | awk -v id="$FROM_ID" '
            BEGIN { found=0 }
            { if (index($0, "\"action_id\":\"" id "\"") > 0) found=1; if (found) print }
        ')
    fi

    if [ -n "$LAST" ]; then
        input=$(echo "$input" | tail -n "$LAST")
    fi

    echo "$input"
}

# ── 表格输出 ──
print_table() {
    local lines
    lines=$(cat)

    if [ -z "$lines" ]; then
        echo "（无匹配记录）"
        return
    fi

    printf "%-8s %-18s %-22s %-10s %-12s %s\n" "动作ID" "时间" "步骤" "类型" "状态" "描述"
    printf '%0.s-' {1..100}
    echo ""

    local count=0
    while IFS= read -r line; do
        if [ -z "$line" ]; then continue; fi
        count=$((count + 1))

        # 使用简单的字符串提取（兼容无 jq 环境）
        if command -v jq &>/dev/null; then
            local aid time step rtype status msg files
            aid=$(echo "$line" | jq -r '.action_id // ""')
            time=$(echo "$line" | jq -r '.time // ""')
            step=$(echo "$line" | jq -r '.step // ""')
            rtype=$(echo "$line" | jq -r '.type // ""')
            status=$(echo "$line" | jq -r '.status // ""')
            msg=$(echo "$line" | jq -r '.message // ""')
            files=$(echo "$line" | jq -r '(.files // []) | join(", ")')

            printf "%-8s %-18s %-22s %-10s %-12s %s\n" "$aid" "$time" "$step" "$rtype" "$status" "$msg"
            if [ -n "$files" ]; then
                printf "%-8s 关联文件: %s\n" "" "$files"
            fi
        else
            # 无 jq 时直接输出 JSON 行
            echo "$line"
        fi
    done <<< "$lines"

    echo ""
    echo "共 ${count} 条记录"
}

# ── 主逻辑 ──
RESULT=$(extract_json_lines | apply_filters)

if [ "$OUTPUT_JSON" = true ]; then
    if command -v jq &>/dev/null; then
        echo "$RESULT" | jq -s '.'
    else
        echo "[$RESULT]"
    fi
else
    echo "$RESULT" | print_table
fi
