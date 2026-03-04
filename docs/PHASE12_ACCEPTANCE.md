# Phase 12 验收单（对话链路闭环模板）

本阶段目标：
- 把“聊天秒切状态”固化成可复用模板，避免反复靠口头约定

## 已做内容
1) 新增 `scripts/chat_status_demo.sh`
- 演示“收到消息->working，回复后->idle”完整闭环

2) 新增 `docs/CHAT_STATUS_INTEGRATION_TEMPLATE.md`
- 提供 Python/Shell 模板
- 明确 try/finally 回 idle、异常切 error 的标准

3) README/SKILL 补充模板入口

## 线上验收
- 你看体感：回复链路状态切换应更稳定
- 重点观察是否还有“回复完不回待命”的漏切

## 回滚
- `git revert <phase12_commit>`
