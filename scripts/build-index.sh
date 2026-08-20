#!/usr/bin/env bash
#
# README.md のインデックス部分を、実ファイルから再生成する。
# 各エントリの見出し(H1)をタイトルとして使う。

set -eu
cd "$(dirname "$0")/.."

count=$(find . -name '*.md' -not -path './.git/*' -not -name 'README.md' | wc -l | tr -d ' ')

{
  echo "# TIL"
  echo
  echo "Today I Learned — 実際に手元で確かめたことだけを書く。"
  echo
  echo "現在 **${count}** 件。"
  echo
  echo "<!-- INDEX:START -->"
  for dir in $(find . -mindepth 1 -maxdepth 1 -type d \
                 -not -name '.git' -not -name 'scripts' | sed 's|^\./||' | sort); do
    n=$(find "$dir" -name '*.md' | wc -l | tr -d ' ')
    [ "$n" -gt 0 ] || continue
    echo
    echo "### ${dir} (${n})"
    echo
    for f in $(find "$dir" -name '*.md' | sort); do
      title=$(grep -m1 '^# ' "$f" | sed 's/^# //')
      echo "- [${title}](./${f#./})"
    done
  done
  echo
  echo "<!-- INDEX:END -->"
  echo
  echo "---"
  echo
  echo "インデックスは \`scripts/build-index.sh\` で再生成する。"
} > README.md

echo "README.md を再生成しました (${count} エントリ)"
