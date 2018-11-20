# ChordLogic

## About
コード進行作成補助

## Usage
SWI-Prologを利用
```
?- [chord]
```
コードを読み込み

```
?- complete([[c], X, [a, m], [e, m]]).
X = [c] ;
X = [e, m] ;
X = [a, m] ;
.
.
.
X = [e, dim7] ;
X = [as, dim7] ;
X = [f] ;
false.
```
T-SD-Dによるコード進行の成立を確認できる
大文字変数の部分は代理コードを提案する

good(X, Y)は部分的な進行の成立
agency(Chord, Agent)は代理コードの一覧
chord([Sound1, Sound2, Sound3(, Sound4)], [RootSound, Option])はコードと構成音の変換