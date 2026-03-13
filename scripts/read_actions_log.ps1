<#
.SYNOPSIS
    actions.log 日志读取与查询工具（PowerShell 版）

.DESCRIPTION
    解析 JSON Lines 格式的 actions.log，支持按步骤、类型、状态过滤，并以表格或 JSON 格式输出。

.PARAMETER LogFile
    actions.log 文件路径。

.PARAMETER Last
    显示最近 N 条记录。

.PARAMETER Step
    按步骤标识过滤（如 step-1-collection）。

.PARAMETER Type
    按动作类型过滤（如 SEARCH、CAPTURE）。

.PARAMETER Status
    按状态过滤（如 completed、failed）。

.PARAMETER FromId
    从指定动作 ID 开始显示（如 A005）。

.PARAMETER AsJson
    以 JSON 格式输出。

.EXAMPLE
    .\read_actions_log.ps1 -LogFile 90-process-logs/actions.log
    .\read_actions_log.ps1 -LogFile 90-process-logs/actions.log -Last 10
    .\read_actions_log.ps1 -LogFile 90-process-logs/actions.log -Step step-1-collection -Type CAPTURE
    .\read_actions_log.ps1 -LogFile 90-process-logs/actions.log -FromId A005 -AsJson
#>

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$LogFile,

    [int]$Last = 0,
    [string]$Step = "",
    [string]$Type = "",
    [string]$Status = "",
    [string]$FromId = "",
    [switch]$AsJson
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $LogFile)) {
    Write-Error "错误: 文件不存在 - $LogFile"
    exit 1
}

# ── 解析 JSON 行 ──
$records = @()
foreach ($line in Get-Content -Path $LogFile -Encoding UTF8) {
    $trimmed = $line.Trim()
    if (-not $trimmed -or $trimmed.StartsWith("#") -or $trimmed.StartsWith(">") -or $trimmed.StartsWith("|") -or $trimmed.StartsWith("-")) {
        continue
    }
    try {
        $obj = $trimmed | ConvertFrom-Json
        if ($null -ne $obj.action_id) {
            $records += $obj
        }
    } catch {
        continue
    }
}

# ── 过滤 ──
if ($Step) {
    $records = $records | Where-Object { $_.step -eq $Step }
}

if ($Type) {
    $upperType = $Type.ToUpper()
    $records = $records | Where-Object { $_.type -eq $upperType }
}

if ($Status) {
    $records = $records | Where-Object { $_.status -eq $Status }
}

if ($FromId) {
    $startIdx = -1
    for ($i = 0; $i -lt $records.Count; $i++) {
        if ($records[$i].action_id -eq $FromId) {
            $startIdx = $i
            break
        }
    }
    if ($startIdx -ge 0) {
        $records = $records[$startIdx..($records.Count - 1)]
    }
}

if ($Last -gt 0 -and $records.Count -gt $Last) {
    $records = $records[($records.Count - $Last)..($records.Count - 1)]
}

# ── 输出 ──
if ($records.Count -eq 0) {
    Write-Host "（无匹配记录）"
    exit 0
}

if ($AsJson) {
    $records | ConvertTo-Json -Depth 5
} else {
    Write-Host ("{0,-8} {1,-18} {2,-22} {3,-10} {4,-12} {5}" -f "动作ID", "时间", "步骤", "类型", "状态", "描述")
    Write-Host ("-" * 100)

    foreach ($r in $records) {
        $aid     = if ($r.action_id) { $r.action_id } else { "" }
        $time    = if ($r.time) { $r.time } else { "" }
        $step    = if ($r.step) { $r.step } else { "" }
        $rtype   = if ($r.type) { $r.type } else { "" }
        $rstatus = if ($r.status) { $r.status } else { "" }
        $msg     = if ($r.message) { $r.message } else { "" }

        Write-Host ("{0,-8} {1,-18} {2,-22} {3,-10} {4,-12} {5}" -f $aid, $time, $step, $rtype, $rstatus, $msg)

        $files = $r.files
        if ($files -and $files.Count -gt 0) {
            Write-Host ("{0,8} 关联文件: {1}" -f "", ($files -join ", "))
        }

        if ($r.terminal_input) {
            Write-Host ("{0,8} 终端输入: {1}" -f "", $r.terminal_input)
        }

        if ($r.terminal_output) {
            $preview = $r.terminal_output
            if ($preview.Length -gt 120) { $preview = $preview.Substring(0, 120) + "..." }
            Write-Host ("{0,8} 终端输出: {1}" -f "", $preview)
        }
    }

    Write-Host ""
    Write-Host "共 $($records.Count) 条记录"
}
