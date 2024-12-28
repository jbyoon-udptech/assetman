# sqltest

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Prerequsites

- sqlite3
  `sudo apt-get install sqlite3 libsqlite3-dev`

## code unit test

  `flutter test`

## 구조 설계

### Asset class

  자산을 표현하는 기본 정의
  name(이름): "KRW/USD", "한화오션", "Eli Lilly And Co"
  code(code): KRWUSD, 042660, LLY
  at(시각): "2024-10-10T09:10:00+09:00"
  value(가격): 1340
  currency(통화): KRW, USD
  klass(종류): 법정화폐(currency), KOSPI, NYSE, BTC, 채권, 예금
  method(값을 읽어오는 방식): manual, yahooapi, gogolapi, xxxapi
