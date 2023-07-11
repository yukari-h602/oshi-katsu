# oshi_katsu

## サービス概要
全ての推しがいる皆様の「推しを布教したい！」「同志を発見して繋がりたい！」「グッズ情報を共有したい！」
そんな気持ちを可視化するサービスです。

## 想定されるユーザー層
年齢性別を問わず「推し」のいる人。または新たな「推し」を発見したい人。

## サービスコンセプト
### ユーザーが抱える問題
- 自分の推しを布教したい、同志を探したいとは思っていても、Twitterでは単語で検索しても布教以外の情報に埋もれてしまい、検索するのが大変
- 推しのグッズ情報をTwitterで入手して、リツイートやいいねをしても他の情報ですぐに埋もれてしまう

### 解決方法
- 推しを布教するためのテンプレート(推しのカルテ)を作り、SNSにシェアできるようにする
- Twitterを埋め込み、グッズ情報を一覧で見やすく配置し、いい情報はブックマークできるようにする

### なぜこのサービスを作りたいのか？
最近、推しカクテルを作ってくれるお店に行き、そこで推しへの愛を語るのですが、SNSに推しを布教する時にもテンプレートがあるとわかりやすく同志も探しやすいかなと思いました。
みんなの推しへの愛を見たいから。
グッズ情報はすぐにタイムラインなどから埋もれてしまい、その情報を探しだすのが大変なので、一覧で表示したいと思ったから。
推しの布教方法はいくつかあるが、テンプレートでシェアできるのは無いと思うので差別化できるかなと思います。

## 実装予定の機能
### MVP
- ユーザーアカウント機能
  - サインアップ、ログイン、ログアウト、プロフィール編集などの基本的なアカウント機能

- 投稿機能
  - テンプレートに基づいた推しのカルテを記入し、アプリ内に投稿またはSNSにシェアできる

- カテゴリー、タグ機能
  - ユーザーはカテゴリーやタグから同志を探すことができる

- いいね、コメント機能
  - 投稿された情報にいいねやコメントをすることができる

- フォロー・フォロワー機能
  - 同志や気になるユーザーをフォローできるし、またフォローされることができる

- 検索機能
  - Stimulus Autocompleteを使用し、候補を表示し、検索しやすくする

- DM・チャット機能
- ユーザーはDMを送れ、個人間でチャットでコミュニケーションをとれる

### その他の機能
- フォロー、いいねやコメントをされた際に通知される
- ゲストログイン機能