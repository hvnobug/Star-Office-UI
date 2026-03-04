# 对话状态切换集成模板（最终版）

这是“聊天秒切动画状态”的推荐模板，核心是 **try/finally 一定回 idle**。

## 伪代码模板

```python
trace_id = gen_trace_id()
set_state("start", "正在回复主人...", ttl=120, source="chat", trace_id=trace_id)
try:
    # 你的正常处理逻辑
    # 如遇到 git push / 上传 / 同步等重动作：
    set_state("sync", "正在同步中...", ttl=300, source="sync", trace_id=trace_id)
    run_heavy_task()

    send_reply("...回复内容...")
except Exception:
    set_state("err", "处理失败，正在排查", ttl=120, source="chat", trace_id=trace_id)
    raise
finally:
    set_state("done", "待命中，随时准备", source="chat", trace_id=trace_id)
```

## Shell 版模板

```bash
python3 set_state.py start "正在回复主人..." --ttl 120 --source chat --trace-id "$TRACE_ID"

# ...处理逻辑...

python3 set_state.py done "待命中，随时准备" --source chat --trace-id "$TRACE_ID"
```

## 关键原则
1) 收到消息先切状态，再开始处理
2) 回复后一定回 idle（finally）
3) 同步动作切 syncing，失败切 error
4) trace_id 串联一整次会话，便于排查“漏切”
