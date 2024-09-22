#!/bin/bash

# リポジトリ内の指定のディレクトリを除く全ファイルをテキストファイルに出力
# 生成 AI に読み込ませる用

# より洗練された手法でGitHubリポジトリ全体を生成 AI に読み込ませるような手法はあるようです。
# https://note.com/nike_cha_n/n/ne8d53fcccc32
# https://note.com/nike_cha_n/n/n1d2f5ee81644
find . -type d \( -name '.terraform' -o -name 'assets' \) -prune -o -type f -exec echo "===== {} =====" \; -exec cat {} \; > all_files.txt
