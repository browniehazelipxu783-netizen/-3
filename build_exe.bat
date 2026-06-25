@echo off
REM ============================================================
REM  TE-AP-00 执行器配置程序 - 本地一键打包成 exe 脚本
REM  使用方法：在 Windows 电脑上安装好 Python 3.10+ 后，
REM           直接双击本文件即可（需要能联网下载 PyInstaller）。
REM  打包完成后，可在 dist\TE-AP-00\ 文件夹中找到 TE-AP-00.exe，
REM  请把整个 dist\TE-AP-00 文件夹一起拷贝/分发（不要只拷贝 exe），
REM  因为 data 文件夹（厂家数据/设置/版本记录）需要和 exe 放在一起。
REM ============================================================

setlocal

echo [1/4] 检查 Python 是否已安装...
where python >nul 2>nul
if errorlevel 1 (
    echo 未检测到 Python，请先安装 Python 3.10 及以上版本（python.org），
    echo 安装时记得勾选 "Add Python to PATH"。
    pause
    exit /b 1
)

echo [2/4] 安装 PyInstaller...
python -m pip install --upgrade pip >nul
python -m pip install pyinstaller==6.10.0
if errorlevel 1 (
    echo 安装 PyInstaller 失败，请检查网络连接后重试。
    pause
    exit /b 1
)

echo [3/4] 开始打包（首次打包可能需要1-2分钟）...
python -m PyInstaller --noconfirm --windowed --name TE-AP-00 --paths . app.py
if errorlevel 1 (
    echo 打包失败，请查看上方报错信息。
    pause
    exit /b 1
)

echo [4/4] 复制厂家数据/配置文件...
xcopy /E /I /Y "data" "dist\TE-AP-00\data" >nul

echo.
echo ============================================================
echo  打包完成！可执行文件位于：dist\TE-AP-00\TE-AP-00.exe
echo  请把整个 dist\TE-AP-00 文件夹一起拷贝给使用者，不要只拷贝exe文件。
echo ============================================================
pause
