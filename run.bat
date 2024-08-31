@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 设置虚拟环境的名称
set VENV_NAME=myenv

:: 检查虚拟环境是否已存在
if exist %VENV_NAME% (
    echo 虚拟环境已存在。正在激活...
    call %VENV_NAME%\Scripts\activate.bat
) else (
    echo 正在创建虚拟环境...
    python -m venv %VENV_NAME%
    if errorlevel 1 (
        echo 创建虚拟环境失败。请确保已安装Python且已将其添加到PATH中。
        pause
        exit /b 1
    )
    echo 虚拟环境创建成功。正在激活...
    call %VENV_NAME%\Scripts\activate.bat
)

:: 进入脚本当前路径
cd /d %~dp0

echo 虚拟环境已激活，当前路径为：%CD%
echo 您现在可以开始工作了。
echo 使用 deactivate 命令可以退出虚拟环境。

:: 启动一个新的命令提示符，保持虚拟环境激活状态
flask run --debug

endlocal