#!/bin/bash

# カレントディレクトリから再帰的に探索
directory="$(pwd)"  # 引数がなければカレントディレクトリを使用

# 保存されたファイル名
output_file=".shell_configmap"

# 保存されたファイルの更新日時と現在の更新日時を比較する
if [ -f "$output_file" ]; then
    while IFS= read -r saved_line; do
        # 保存された更新日時とファイル名を取得
        saved_timestamp=$(echo "$saved_line" | awk '{print $1, $2, $3}')
        saved_file=$(echo "$saved_line" | awk '{print $4}')

        # 現在の更新日時を取得
        current_timestamp=$(stat --format="%y" "$saved_file" 2>/dev/null)

        # ファイルが存在し、更新日時が異なった場合
        if [ "$current_timestamp" != "$saved_timestamp" ]; then
            relative_path=$(realpath --relative-to="$directory" "$saved_file")
	    kubectl delete -f $relative_path -n monitoring
	    kubectl apply -f $relative_path -n monitoring
            echo "更新したファイル: $relative_path \n"
        fi
    done < "$output_file"
    kubectl rollout restart -n monitoring deployment/prometheus
else
    echo "エラー．もう一度実行しても失敗した場合は有田海斗に問い合わせてください．"
fi

# find コマンドで再帰的にファイルを探索し、各ファイルの更新日時を保存
find "$directory" -mindepth 2 -not -path "$directory/trash*" -type f -exec stat --format="%y %n" {} \; > "$output_file"
