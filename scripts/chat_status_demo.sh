#!/usr/bin/env bash
set -euo pipefail

# 对话链路状态切换示例（可直接集成到 agent 工作流）
# 用法：
#   bash scripts/chat_status_demo.sh --reply "这是回复内容"

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SET_STATE="python3 $ROOT_DIR/set_state.py"

REPLY=""
TRACE_ID="chat-$(date +%s)-$RANDOM"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --reply)
      REPLY="$2"; shift 2 ;;
    --trace-id)
      TRACE_ID="$2"; shift 2 ;;
    *)
      echo "未知参数: $1"
      exit 2 ;;
  esac
done

if [[ -z "$REPLY" ]]; then
  REPLY="好的，收到。"
fi

# 1) 收到消息立刻切 working
$SET_STATE start "正在回复主人..." --ttl 120 --source chat --trace-id "$TRACE_ID" >/dev/null || true

# 2) 模拟思考/处理
sleep 0.4

# 3) 输出回复（在真实代理里就是发消息动作）
echo "$REPLY"

# 4) finally 回 idle（核心）
$SET_STATE done "待命中，随时准备" --source chat --trace-id "$TRACE_ID" >/dev/null || true
