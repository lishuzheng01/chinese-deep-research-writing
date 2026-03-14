<#
.SYNOPSIS
    中文深度研究写作 - 项目初始化脚本（PowerShell 版）

.DESCRIPTION
    创建标准项目目录结构，复制模板文件，生成 README 与 checkpoint。

.PARAMETER ArticleTitle
    文章标题，将作为项目目录名（不合法字符会被自动替换）。

.PARAMETER ChapterCount
    章节数量，默认为 4。

.EXAMPLE
    .\init_project.ps1 -ArticleTitle "平台劳动者权益保障研究" -ChapterCount 5
    .\init_project.ps1 "平台劳动者权益保障研究"
#>

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$ArticleTitle,

    [Parameter(Position = 1)]
    [int]$ChapterCount = 4
)

$ErrorActionPreference = "Stop"

# ── 标题清洗 ──
function Sanitize-DirName([string]$title) {
    $cleaned = $title -replace '[\\/:*?"<>|]', '-'
    $cleaned = $cleaned -replace '[：？！＊＜＞｜]', '-'
    $cleaned = $cleaned -replace '-{2,}', '-'
    $cleaned = $cleaned.Trim('- ')
    return $cleaned
}

$DirName = Sanitize-DirName $ArticleTitle

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TemplateDir = Join-Path (Split-Path -Parent $ScriptDir) "templates"
$ProjectDir = Join-Path "research-projects" $DirName

# ── 幂等性保护 ──
if (Test-Path $ProjectDir) {
    Write-Error "错误：项目目录已存在: $ProjectDir`n如需重新初始化，请先手动删除或重命名该目录。"
    exit 1
}

Write-Host "正在创建项目目录: $ProjectDir"

# ── 模板完整性校验 ──
$requiredTemplates = @(
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
    "07-delivery/references.md"
)

if (Test-Path $TemplateDir) {
    $missing = @()
    foreach ($t in $requiredTemplates) {
        if (-not (Test-Path (Join-Path $TemplateDir $t))) {
            $missing += $t
        }
    }
    if ($missing.Count -gt 0) {
        Write-Error "错误：以下模板文件缺失，请检查 templates 目录：`n$($missing -join "`n")"
        exit 1
    }
} else {
    Write-Warning "模板目录不存在: $TemplateDir，将只创建目录结构，不复制模板。"
}

# ── 创建目录结构 ──
New-Item -ItemType Directory -Path (Join-Path $ProjectDir "00-project-meta") -Force | Out-Null

for ($i = 1; $i -le $ChapterCount; $i++) {
    $ch = "chapter-{0:D2}" -f $i
    New-Item -ItemType Directory -Path (Join-Path $ProjectDir "01-collection/$ch/sources/pass-01") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $ProjectDir "01-collection/$ch/sources/pass-02") -Force | Out-Null
}

foreach ($folder in @("02-reasoning", "03-verification", "04-academic-validation",
                       "05-writing-guide", "06-drafts", "07-delivery")) {
    New-Item -ItemType Directory -Path (Join-Path $ProjectDir $folder) -Force | Out-Null
}

# 用户自备材料目录
New-Item -ItemType Directory -Path (Join-Path $ProjectDir "01-collection/user-provided/originals") -Force | Out-Null

# ── 复制模板文件 ──
$templateMap = @{
    "00-project-meta"       = @("task-brief.md", "scope-and-constraints.md")
    "02-reasoning"          = @("claim-map.md", "logic-chain.md", "contradiction-register.md")
    "03-verification"       = @("fact-check-table.md", "cross-source-check.md", "unresolved-items.md")
    "04-academic-validation" = @("concept-definitions.md", "method-validity.md", "citation-audit.md")
    "05-writing-guide"      = @("chapter-outline.md", "argument-order.md", "style-guardrails.md")
}

$chapterTemplates = @{
    "01-collection" = @("source-index.md")
}

if (Test-Path $TemplateDir) {
    foreach ($folder in $templateMap.Keys) {
        foreach ($file in $templateMap[$folder]) {
            $src = Join-Path $TemplateDir "$folder/$file"
            $dst = Join-Path $ProjectDir "$folder/$file"
            if (Test-Path $src) {
                Copy-Item -Path $src -Destination $dst -Force
            }
        }
    }

    for ($i = 1; $i -le $ChapterCount; $i++) {
        $ch = "chapter-{0:D2}" -f $i
        foreach ($folder in $chapterTemplates.Keys) {
            foreach ($file in $chapterTemplates[$folder]) {
                $src = Join-Path $TemplateDir "$folder/$file"
                $dst = Join-Path $ProjectDir "$folder/$ch/$file"
                if (Test-Path $src) {
                    Copy-Item -Path $src -Destination $dst -Force
                }
            }
        }
    }

    # 额外全局模板
    $globalTemplates = @{
        "06-drafts" = @("chapter-draft.md")
        "07-delivery" = @("references.md")
    }
    foreach ($folder in $globalTemplates.Keys) {
        foreach ($file in $globalTemplates[$folder]) {
            $src = Join-Path $TemplateDir "$folder/$file"
            $dst = Join-Path $ProjectDir "$folder/$file"
            if (Test-Path $src) {
                Copy-Item -Path $src -Destination $dst -Force
            }
        }
    }
} else {
    Write-Warning "模板目录不存在: $TemplateDir，跳过模板复制（目录结构已创建）"
}

$initTime = Get-Date -Format "yyyy-MM-dd HH:mm"

# ── 生成 README.md ──
$readmePath = Join-Path $ProjectDir "README.md"
$readmeContent = @"
# $ArticleTitle

> 创建时间: $initTime | 章节数: $ChapterCount

## 项目概述

（请在此处用 3-5 句话描述本项目的研究内容与目标。结合主题、体裁、目标读者、核心问题等信息进行填写，不要过于简单也不要过于冗长。）

## 项目结构

| 目录 | 用途 |
|------|------|
| ``00-project-meta/`` | 任务定义、范围约束、断点续传 |
| ``01-collection/`` | 按章节组织的检索材料与可用性评估 |
| ``01-collection/user-provided/`` | 用户自备材料导入 |
| ``02-reasoning/`` | 主张映射、逻辑链、矛盾登记 |
| ``03-verification/`` | 事实核验、交叉来源核对 |
| ``04-academic-validation/`` | 概念定义、方法校验、引用审计 |
| ``05-writing-guide/`` | 章节提纲、论证顺序、风格约束 |
| ``06-drafts/`` | 各章节初稿与全文汇总 |
| ``07-delivery/`` | 最终交付稿与参考文献 |

## 当前状态

请查看 ``00-project-meta/checkpoint.md`` 获取最新进度。
"@
Set-Content -Path $readmePath -Value $readmeContent -Encoding UTF8

# ── 初始化 checkpoint ──
$checkpointSrc = Join-Path $TemplateDir "00-project-meta/checkpoint.md"
$checkpointDst = Join-Path $ProjectDir "00-project-meta/checkpoint.md"

if (Test-Path $checkpointSrc) {
    Copy-Item -Path $checkpointSrc -Destination $checkpointDst -Force
    $content = Get-Content -Path $checkpointDst -Raw -Encoding UTF8
    $content = $content `
        -replace '（如 step-1-collection）', 'step-0-init' `
        -replace '\| 状态 \| not-started \|', '| 状态 | completed |' `
        -replace '（当前阶段内的具体进度，1-2 句话。）', '项目初始化完成，所有目录与模板文件已就绪' `
        -replace '（恢复后应执行的第一个具体操作，精确到文件级别。）', '填写 task-brief.md，然后开始第 1 步检索' `
        -replace 'YYYY-MM-DD HH:MM', $initTime
    Set-Content -Path $checkpointDst -Value $content -Encoding UTF8
} else {
    $checkpointContent = @"
# 断点续传状态

| 字段 | 内容 |
|------|------|
| 当前步骤 | step-0-init |
| 状态 | completed |
| 最后更新 | $initTime |

## 进度明细

项目初始化完成，所有目录与模板文件已就绪。

## 下一步动作

填写 task-brief.md，然后开始第 1 步检索
"@
    Set-Content -Path $checkpointDst -Value $checkpointContent -Encoding UTF8
}

Write-Host ""
Write-Host "项目初始化完成"
Write-Host "  路径: $ProjectDir"
Write-Host "  标题: $ArticleTitle"
Write-Host "  章节数: $ChapterCount"
Write-Host ""
Write-Host "下一步:"
Write-Host "  1. 编辑 README.md 填写项目概述"
Write-Host "  2. 编辑 00-project-meta/task-brief.md 填写任务定义"
Write-Host "  3. 编辑 00-project-meta/scope-and-constraints.md 确定范围与约束"
Write-Host "  4. 开始按章节执行检索"
