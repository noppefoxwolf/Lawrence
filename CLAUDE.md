# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

LawrenceはSwift Package Managerを使用したmacOS用実行可能プロジェクトです。Vapor WebフレームワークをベースとしたActivityPubプロトコルの実装を目的としています。

## 開発環境要件

- Swift 6.1以上
- macOS 11以上

## コマンド

### ビルド
```bash
swift build
```

### 実行
```bash
swift run Lawrence
```

### テスト
```bash
swift test
```

### リント・フォーマット
現在設定されたリント・フォーマットツールはありません。

## アーキテクチャ

### 技術スタック
- **Vapor**: Webサーバーフレームワーク（v4.115.1+）
- **ActivityPub**: 分散型ソーシャルネットワークプロトコル

### プロジェクト構造
- `Sources/main.swift`: アプリケーションのエントリーポイント（現在は空ファイル）
- `docs/activity-pub.md`: ActivityPub仕様書のコピー（W3C勧告）

### 実装ガイドライン
- ActivityPubプロトコルの実装はdocs/activity-pub.mdの仕様に従う
- クライアント・サーバー間通信とサーバー間連携の両方をサポート予定
- 認証・認可はActivityPub仕様のセキュリティ要件に準拠

## Railwayデプロイ

### 必要な環境変数

1. **BASE_URL**: サーバーのベースURL（例: `https://your-app.railway.app`）
2. **DOMAIN**: ドメイン名（例: `your-app.railway.app`）
3. **PORT**: Railwayが自動設定（通常設定不要）

### デプロイ手順

1. GitHubリポジトリをRailwayに接続
2. 環境変数を設定:
   ```
   BASE_URL=https://your-app.railway.app
   DOMAIN=your-app.railway.app
   ```
3. デプロイ後のテスト:
   ```bash
   # WebFinger確認
   curl "https://your-app.railway.app/.well-known/webfinger?resource=acct:testuser@your-app.railway.app"
   
   # ユーザープロフィール確認  
   curl -H "Accept: application/activity+json" "https://your-app.railway.app/users/testuser"
   ```

## 開発時の注意点

- プロジェクトは開発初期段階でmain.swiftは空のため、基本的な構造から実装する必要がある
- ActivityPubの仕様実装において、セキュリティ要件（認証、認可、コンテンツ検証等）を十分に考慮する
- 分散型ネットワークにおけるDoS攻撃対策やスパム対策の実装が必要

## 実装済み機能

- WebFinger対応（`/.well-known/webfinger`）
- ユーザープロフィール取得（`/users/:username`）
- 投稿一覧取得（`/users/:username/outbox`）
- 個別投稿取得（`/users/:username/posts/:id`）
- CORS対応
- Railway対応（動的URL・ポート設定）