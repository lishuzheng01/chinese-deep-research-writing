#!/usr/bin/env python3
"""
中文深度研究写作 - 项目初始化脚本

用法:
    python init_project.py <文章标题> [章节数]

示例:
    python init_project.py 平台劳动者权益保障研究 5
"""

import re
import sys
import shutil
from datetime import datetime
from pathlib import Path


def sanitize_dirname(title: str) -> str:
    """将文章标题转为合法目录名，替换文件系统不允许的字符。"""
    # 替换 Windows/Unix 不允许的字符：\ / : * ? " < > |
    cleaned = re.sub(r'[\\/:*?"<>|]', '-', title)
    # 全角冒号、问号等也替换
    cleaned = re.sub(r'[：？！＊＜＞｜]', '-', cleaned)
    # 合并连续短横线
    cleaned = re.sub(r'-{2,}', '-', cleaned)
    # 去除首尾短横线和空格
    cleaned = cleaned.strip('- ')
    return cleaned


def main():
    if len(sys.argv) < 2:
        print("用法: python init_project.py <文章标题> [章节数]")
        print("示例: python init_project.py 平台劳动者权益保障研究 5")
        sys.exit(1)

    article_title = sys.argv[1]
    chapter_count = int(sys.argv[2]) if len(sys.argv) > 2 else 4

    dir_name = sanitize_dirname(article_title)
    project_dir = Path("research-projects") / dir_name
    script_dir = Path(__file__).resolve().parent
    template_dir = script_dir.parent / "templates"

    # ── 幂等性保护 ──
    if project_dir.exists():
        print(f"错误：项目目录已存在: {project_dir}")
        print("如需重新初始化，请先手动删除或重命名该目录。")
        sys.exit(1)

    print(f"正在创建项目目录: {project_dir}")

    # ── 模板完整性校验 ──
    required_templates = [
        "00-project-meta/task-brief.md",
        "00-project-meta/scope-and-constraints.md",
        "00-project-meta/checkpoint.md",
        "01-collection/source-index.md",
        "01-collection/source-capture.md",
        "02-reasoning/claim-map.md",
        "02-reasoning/logic-chain.md",
        "02-reasoning/contradiction-register.md",
        "03-verification/fact-check-table.md",
        "03-verification/cross-source-check.md",
        "03-verification/unresolved-items.md",
        "04-academic-validation/concept-definitions.md",
        "04-academic-validation/method-validity.md",
        "04-academic-validation/citation-audit.md",
        "05-writing-guide/chapter-outline.md",
        "05-writing-guide/argument-order.md",
        "05-writing-guide/style-guardrails.md",
        "06-drafts/chapter-draft.md",
        "07-delivery/references.md",
    ]

    if template_dir.is_dir():
        missing = [t for t in required_templates if not (template_dir / t).is_file()]
        if missing:
            print("错误：以下模板文件缺失，请检查 templates 目录：")
            for m in missing:
                print(f"  - {m}")
            sys.exit(1)
    else:
        print(f"警告：模板目录不存在: {template_dir}，将只创建目录结构，不复制模板。")

    # ── 创建目录结构 ──
    (project_dir / "00-project-meta").mkdir(parents=True, exist_ok=True)

    for i in range(1, chapter_count + 1):
        ch = f"chapter-{i:02d}"
        (project_dir / "01-collection" / ch / "sources" / "pass-01").mkdir(
            parents=True, exist_ok=True
        )
        (project_dir / "01-collection" / ch / "sources" / "pass-02").mkdir(
            parents=True, exist_ok=True
        )

    (project_dir / "01-collection" / "user-provided" / "originals").mkdir(
        parents=True, exist_ok=True
    )

    for folder in [
        "02-reasoning",
        "03-verification",
        "04-academic-validation",
        "05-writing-guide",
        "06-drafts",
        "07-delivery",
    ]:
        (project_dir / folder).mkdir(parents=True, exist_ok=True)

    # ── 复制模板文件 ──
    template_map = {
        "00-project-meta": [
            "task-brief.md",
            "scope-and-constraints.md",
        ],
        "02-reasoning": [
            "claim-map.md",
            "logic-chain.md",
            "contradiction-register.md",
        ],
        "03-verification": [
            "fact-check-table.md",
            "cross-source-check.md",
            "unresolved-items.md",
        ],
        "04-academic-validation": [
            "concept-definitions.md",
            "method-validity.md",
            "citation-audit.md",
        ],
        "05-writing-guide": [
            "chapter-outline.md",
            "argument-order.md",
            "style-guardrails.md",
        ],
    }

    # 按章复制的模板
    chapter_templates = {
        "01-collection": [
            "source-index.md",
        ],
    }

    # 全局复制的额外模板
    global_templates = {
        "06-drafts": ["chapter-draft.md"],
        "07-delivery": ["references.md"],
    }

    if template_dir.is_dir():
        for folder, files in template_map.items():
            for filename in files:
                src = template_dir / folder / filename
                dst = project_dir / folder / filename
                if src.is_file():
                    shutil.copy2(src, dst)

        for i in range(1, chapter_count + 1):
            ch = f"chapter-{i:02d}"
            for folder, files in chapter_templates.items():
                for filename in files:
                    src = template_dir / folder / filename
                    dst = project_dir / folder / ch / filename
                    if src.is_file():
                        shutil.copy2(src, dst)

        for folder, files in global_templates.items():
            for filename in files:
                src = template_dir / folder / filename
                dst = project_dir / folder / filename
                if src.is_file():
                    shutil.copy2(src, dst)

    init_time = datetime.now().strftime("%Y-%m-%d %H:%M")

    # ── 生成 README.md ──
    readme_path = project_dir / "README.md"
    readme_content = f"""# {article_title}

> 创建时间: {init_time} | 章节数: {chapter_count}

## 项目概述

（请在此处用 3-5 句话描述本项目的研究内容与目标。结合主题、体裁、目标读者、核心问题等信息进行填写，不要过于简单也不要过于冗长。）

## 项目结构

| 目录 | 用途 |
|------|------|
| `00-project-meta/` | 任务定义、范围约束、断点续传 |
| `01-collection/` | 按章节组织的检索材料与可用性评估 |
| `01-collection/user-provided/` | 用户自备材料导入 |
| `02-reasoning/` | 主张映射、逻辑链、矛盾登记 |
| `03-verification/` | 事实核验、交叉来源核对 |
| `04-academic-validation/` | 概念定义、方法校验、引用审计 |
| `05-writing-guide/` | 章节提纲、论证顺序、风格约束 |
| `06-drafts/` | 各章节初稿与全文汇总 |
| `07-delivery/` | 最终交付稿与参考文献 |

## 当前状态

请查看 `00-project-meta/checkpoint.md` 获取最新进度。
"""
    with open(readme_path, "w", encoding="utf-8") as f:
        f.write(readme_content)

    # ── 初始化 checkpoint ──
    checkpoint_src = template_dir / "00-project-meta" / "checkpoint.md"
    checkpoint_dst = project_dir / "00-project-meta" / "checkpoint.md"
    if checkpoint_src.is_file():
        shutil.copy2(checkpoint_src, checkpoint_dst)
        # 写入初始状态
        with open(checkpoint_dst, "r", encoding="utf-8") as f:
            content = f.read()
        content = content.replace(
            "（如 step-1-collection）", "step-0-init"
        ).replace(
            "| 状态 | not-started |", "| 状态 | completed |"
        ).replace(
            "（当前阶段内的具体进度，1-2 句话。）",
            "项目初始化完成，所有目录与模板文件已就绪"
        ).replace(
            "（恢复后应执行的第一个具体操作，精确到文件级别。）",
            "填写 task-brief.md，然后开始第 1 步检索"
        ).replace(
            "YYYY-MM-DD HH:MM",
            init_time
        )
        with open(checkpoint_dst, "w", encoding="utf-8") as f:
            f.write(content)
    else:
        # 模板不存在时直接生成
        with open(checkpoint_dst, "w", encoding="utf-8") as f:
            f.write(
                f"# 断点续传状态\n\n"
                f"| 字段 | 内容 |\n|------|------|\n"
                f"| 当前步骤 | step-0-init |\n"
                f"| 状态 | completed |\n"
                f"| 最后更新 | {init_time} |\n\n"
                f"## 进度明细\n\n"
                f"项目初始化完成，所有目录与模板文件已就绪。\n\n"
                f"## 下一步动作\n\n"
                f"填写 task-brief.md，然后开始第 1 步检索\n"
            )

    print()
    print("项目初始化完成")
    print(f"  路径: {project_dir}")
    print(f"  标题: {article_title}")
    print(f"  章节数: {chapter_count}")
    print()
    print("下一步:")
    print("  1. 编辑 README.md 填写项目概述")
    print("  2. 编辑 00-project-meta/task-brief.md 填写任务定义")
    print("  3. 编辑 00-project-meta/scope-and-constraints.md 确定范围与约束")
    print("  4. 开始按章节执行检索")


if __name__ == "__main__":
    main()
