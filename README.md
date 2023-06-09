[クイックスタート: Bicep を使用して Azure Data Factory を作成する](https://learn.microsoft.com/ja-jp/azure/data-factory/quickstart-create-data-factory-bicep) 見ながら実際に作成してみる

## セットアップ
1. ソースコードを取得
    ```
    git clone https://github.com/aopontan-b/create-adf-bicep.git
    cd create-adf-azure-cli
    ```

2. ログイン（ログイン済みならスキップ）
    ```
    az login
    ```

3. アクティブなサブスクリプションを変更する
    ```
    az account set --subscription "my Demos"
    ```

4. リソースグループを作成
    ```
    az group create --name exampleRG --location eastus
    ```

5. bicepファイルをデプロイする
    ```
    az deployment group create --resource-group exampleRG --template-file main.bicep
    ```

6. デプロイされているリソースを確認する
    ```
    az resource list --resource-group ${RESOUCE_GROUP_NAME}
    ```
7. Azure portal を使用して emp.txt ファイルを[アップロード](https://learn.microsoft.com/ja-jp/azure/data-factory/quickstart-create-data-factory-bicep?tabs=CLI#upload-a-file)する

8. トリガーを[開始](https://learn.microsoft.com/ja-jp/azure/data-factory/quickstart-create-data-factory-bicep?tabs=CLI#start-trigger)する

9. リソースの削除
    ```
    az group delete --name ${RESOUCE_GROUP_NAME}
    ```

### おまけ
次のコマンドを実行することで、ファイルのアップロード、bicepファイルをデプロイ、トリガーの開始
を全て自動で行うことができる
```
./adf.sh
```

### メモ
クイックスタートで使用される Bicep ファイルでデプロイされたリソースには、[uniqueString](https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/bicep/bicep-functions-string#uniquestring)関数を使って生成されたIDが指定されている。  
例：`storagehexw2amoej22i`  
クイックスタートでは、GUIでファイルのアップロードをしているが、  
GUIを使わずにファイルアップロードしたい場合は、JSON プロセッサーツールの [jq](https://github.com/jqlang/jq) を使って、  
デプロイ結果が出力されたJSONデータからIDを抽出し、CLIのパラメーターに指定する必要がある。


## 参考記事
- [Bicep のドキュメント](https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/bicep/)