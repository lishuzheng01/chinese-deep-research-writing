#!/usr/bin/env python3
"""
actions.log 日志读取与查询工具

用法:
    python read_actions_log.py <日志文件路径> [选项]

选项:
    --last N          显示最近 N 条记录（默认全部）
    --step STEP       按步骤标识过滤（如 step-1-collection）
    --type TYPE       按动作类型过滤（如 SEARCH、CAPTURE）
    --status STATUS   按状态过滤（如 completed、failed）
    --from-id ID      从指定动作 ID 开始显示（如 A005）
    --json            以 JSON 格式输出（默认表格格式）

示例:
    python read_actions_log.py 90-process-logs/actions.log
    python read_actions_log.py 90-process-logs/actions.log --last 10
    python read_actions_log.py 90-process-logs/actions.log --step step-1-collection --type CAPTURE
    python read_actions_log.py 90-process-logs/actions.log --from-id A005 --json
"""

import json
import sys
import argparse
from pathlib import Path


def parse_log(filepath: str) -> list[dict]:
    """解析 actions.log 文件，提取所有 JSON 行记录。"""
    records = []
    with open(filepath, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#") or line.startswith(">") or line.startswith("|") or line.startswith("-"):
                continue
            try:
                record = json.loads(line)
                if isinstance(record, dict) and "action_id" in record:
                    records.append(record)
            except json.JSONDecodeError:
                continue
    return records


def filter_records(records: list[dict], args) -> list[dict]:
    """根据命令行参数过滤记录。"""
    filtered = records

    if args.step:
        filtered = [r for r in filtered if r.get("step") == args.step]

    if args.type:
        filtered = [r for r in filtered if r.get("type") == args.type.upper()]

    if args.status:
        filtered = [r for r in filtered if r.get("status") == args.status]

    if args.from_id:
        start_idx = None
        for i, r in enumerate(filtered):
            if r.get("action_id") == args.from_id:
                start_idx = i
                break
        if start_idx is not None:
            filtered = filtered[start_idx:]

    if args.last:
        filtered = filtered[-args.last:]

    return filtered


def print_table(records: list[dict]):
    """以表格格式输出记录。"""
    if not records:
        print("（无匹配记录）")
        return

    print(f"{'动作ID':<8} {'时间':<18} {'步骤':<22} {'类型':<10} {'状态':<12} 描述")
    print("-" * 100)
    for r in records:
        action_id = r.get("action_id", "")
        time = r.get("time", "")
        step = r.get("step", "")
        rtype = r.get("type", "")
        status = r.get("status", "")
        message = r.get("message", "")
        print(f"{action_id:<8} {time:<18} {step:<22} {rtype:<10} {status:<12} {message}")

        files = r.get("files", [])
        if files:
            print(f"{'':>8} 关联文件: {', '.join(files)}")

        terminal_input = r.get("terminal_input")
        if terminal_input:
            print(f"{'':>8} 终端输入: {terminal_input}")

        terminal_output = r.get("terminal_output")
        if terminal_output:
            output_preview = terminal_output[:120] + ("..." if len(terminal_output) > 120 else "")
            print(f"{'':>8} 终端输出: {output_preview}")

    print(f"\n共 {len(records)} 条记录")


def print_json(records: list[dict]):
    """以 JSON 格式输出记录。"""
    print(json.dumps(records, ensure_ascii=False, indent=2))


def main():
    parser = argparse.ArgumentParser(description="actions.log 日志读取与查询工具")
    parser.add_argument("logfile", help="actions.log 文件路径")
    parser.add_argument("--last", type=int, help="显示最近 N 条记录")
    parser.add_argument("--step", help="按步骤标识过滤")
    parser.add_argument("--type", help="按动作类型过滤")
    parser.add_argument("--status", help="按状态过滤")
    parser.add_argument("--from-id", help="从指定动作 ID 开始显示")
    parser.add_argument("--json", action="store_true", dest="output_json", help="以 JSON 格式输出")

    args = parser.parse_args()

    if not Path(args.logfile).is_file():
        print(f"错误: 文件不存在 - {args.logfile}", file=sys.stderr)
        sys.exit(1)

    records = parse_log(args.logfile)
    filtered = filter_records(records, args)

    if args.output_json:
        print_json(filtered)
    else:
        print_table(filtered)


if __name__ == "__main__":
    main()
