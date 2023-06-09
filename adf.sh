# リソースグループの作成からテキストファイルのアップロードまでのシェルスクリプト

# リソースグループを作成
az group create --name exampleRG --location eastus

# bicepファイルを使ってリソースをデプロイ　デプロイ結果をjsonに保存
az deployment group create --resource-group exampleRG --template-file main.bicep > deploy_result.json

# jsonから、生成されたIDを抽出する
VAR=`cat deploy_result.json| jq -r '.properties.outputs.uniqueRG.value'`

# Azure Storage コンテナーにテキストファイルをアップロード
az storage blob upload --account-name "storage${VAR}" --name input/emp.txt \
    --container-name "blob${VAR}" --file emp.txt --auth-mode key

# パイプラインを実行
# 初めて実行するとき「The command requires the extension datafactory.Do you want to install it now? The command will continue to run after the extension is installed. (Y/n):」
# という確認メッセージが出力される
# RUN_ID=`az datafactory pipeline create-run --resource-group exampleRG \
#     --name ArmtemplateSampleCopyPipeline --factory-name "datafactory${VAR}" | jq -r '.runId'`

# # 20秒待機
# sleep 20

# # パイプラインが正常に実行されたことを確認
# az datafactory pipeline-run show --resource-group exampleRG \
#     --factory-name "datafactory${VAR}" --run-id ${RUN_ID}