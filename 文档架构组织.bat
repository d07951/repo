@echo off
chcp 65001
setlocal enabledelayedexpansion

:: 创建主目录
if not exist "chapters" mkdir "chapters"

:: 创建一级目录和文件
cd chapters

mkdir "01 项目背景"
cd "01 项目背景"
type nul > "01 医院情况.md"
type nul > "02 医院发展需求.md"
type nul > "03 政策背景.md"
type nul > "04 智慧病房建设现状与痛点分析.md"
type nul > "05 项目建设目标与预期效益.md"
cd ..

mkdir "02 总体设计"
cd "02 总体设计"
type nul > "01 设计原则与建设思路.md"
type nul > "02 系统架构与技术路线.md"
type nul > "03 建设内容与实施范围.md"
type nul > "04 方案优势.md"
type nul > "05 八大亮点.md"
cd ..

mkdir "03 详细方案"
cd "03 详细方案"
type nul > "01 IP医护对讲.md"
type nul > "01 护理白板交互系统.md"
type nul > "02 智能床旁交互系统.md"
type nul > "03 病房控制系统.md"
type nul > "04 ICU探视系统.md"
type nul > "05 智能输液监控管理系统.md"
type nul > "06 患者无感监测系统.md"
type nul > "07 手术室对讲系统.md"
type nul > "08 生命体征智能采集监控系统.md"
type nul > "09 无线定位系统.md"
type nul > "10 智能门禁管理系统.md"
type nul > "11 机器人整体方案.md"
type nul > "12 可视化综合管理系统.md"
cd ..

mkdir "04 实施保障"
cd "04 实施保障"
type nul > "01 项目管理与实施计划.md"
type nul > "02 技术保障与系统集成.md"
type nul > "03 培训与运维支持.md"
cd ..


mkdir "05 投资预算与效益分析"
cd "05 投资预算与效益分析"
type nul > "01 项目投资概算.md"
type nul > "02 经济效益分析.md"
type nul > "03 社会效益评估.md"
cd ..

mkdir "06 企业介绍"
cd "06 企业介绍"
type nul > "01 狄耐克企业介绍.md"
cd ..

mkdir "07 案例分享"
cd "07 案例分享"
type nul > "01 成功案例介绍.md"
type nul > "02 客户价值分析.md"
cd ..

cd ..

echo 目录结构创建完成！
pause
