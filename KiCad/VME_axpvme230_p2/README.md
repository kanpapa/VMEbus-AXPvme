# VMEbus-axpvme230_p2

AXPvme 230 moduleを動作させるためには専用のAXPvme Breakout module (54-22621-01)が必要です。  
ドキュメントを参考にして簡易的なAXPvme Breakout boardを製作します。

## Breakout boardの設計方針

* AXPvme 230 moduleに確実に電源を供給することを目標にします。
* 試作の段階なので、VMEラックへの取り付けは行わず机上で確認できるようにシンプルなものにします。
* SCSIやその他の信号についてはコネクタに引き出すだけにします。
* 電源ラインは4層基板にすることで他の信号から電源ラインを分離します。
* [製作済のP1ブレイクアウトボード](https://github.com/kanpapa/VMEbus/tree/main/VME_power)と同じサイズにします。

## KiCadデータ

KiCADで設計からガーバーデータの作成を行いました。

* [回路図](./VME_axpvme230_p2_sch.pdf)
* [BOM](./VME_axpvme230_p2.csv)

## Breakout boardのイメージ図

![基板のイメージ図](./VME_axpvme230_p2_3d.jpg)

## Disclaimer
The contents of this repository are the result of personal research and are provided "as is" without any warranty.