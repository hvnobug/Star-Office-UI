# Phase 7 验收单（生图链路稳态加固）

本阶段目标（非破坏）：
- 避免并发生图任务互相抢占，导致卡顿/失败
- 限制超长 prompt 和不可控超时

## 已做内容
1) 生图并发互斥
- `/assets/generate-rpg-background` 同时只允许 1 个任务
- 并发请求返回 `429 GEN_BUSY`

2) 生图超时可配置
- 新增：`STAR_OFFICE_GEMINI_TIMEOUT_SECONDS`（默认 240）

3) prompt 长度上限可配置
- 新增：`STAR_OFFICE_GEMINI_PROMPT_MAX_CHARS`（默认 1200）
- 超长 prompt 自动截断，避免异常请求拖垮服务

4) 配置检查同步
- `.env.example` 和 `scripts/security_check.py` 已同步

## 线上验收
- 正常装修/生图流程不受影响
- 连点生图时，第二个请求应提示“任务进行中”

## 回滚
- 代码回滚：`git revert <phase7_commit>`
