# -*- coding: utf-8 -*-
"""
app.py
程序入口。
本地直接运行：  python app.py
打包为exe后：  双击 TE-AP-00.exe
"""
import os
import sys
import traceback

if getattr(sys, "frozen", False):
    _ROOT = os.path.dirname(os.path.abspath(sys.executable))
else:
    _ROOT = os.path.dirname(os.path.abspath(__file__))
    sys.path.insert(0, _ROOT)

os.chdir(_ROOT)


def main():
    from ui.main_window import MainWindow
    app = MainWindow()
    app.mainloop()


if __name__ == "__main__":
    try:
        main()
    except Exception:
        # 打包成exe后没有控制台，把异常写到文件方便排查
        with open(os.path.join(_ROOT, "error_log.txt"), "a", encoding="utf-8") as f:
            f.write(traceback.format_exc())
            f.write("\n" + "-" * 60 + "\n")
        try:
            import tkinter.messagebox as mb
            mb.showerror("程序出错", "程序运行出错，详细信息已写入 error_log.txt\n\n" + traceback.format_exc()[-500:])
        except Exception:
            raise
