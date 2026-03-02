module Data.Currency where

import Prelude

import Control.Monad.Except (throwError)
import Data.Enum (class Enum, class BoundedEnum, Cardinality(..), enumFromTo)
import Data.Maybe (Maybe(..))
import Foreign (ForeignError(..))
import Yoga.JSON (class ReadForeign, class WriteForeign, readImpl, writeImpl)

data Currency
  = AED
  | AFN
  | ALL
  | AMD
  | ANG
  | AOA
  | ARS
  | AUD
  | AWG
  | AZN
  | BAM
  | BBD
  | BDT
  | BGN
  | BHD
  | BIF
  | BMD
  | BND
  | BOB
  | BRL
  | BSD
  | BTN
  | BWP
  | BYN
  | BZD
  | CAD
  | CDF
  | CHF
  | CLP
  | CNY
  | COP
  | CRC
  | CUC
  | CUP
  | CVE
  | CZK
  | DJF
  | DKK
  | DOP
  | DZD
  | EGP
  | ERN
  | ETB
  | EUR
  | FJD
  | FKP
  | GBP
  | GEL
  | GHS
  | GIP
  | GMD
  | GNF
  | GTQ
  | GYD
  | HKD
  | HNL
  | HRK
  | HTG
  | HUF
  | IDR
  | ILS
  | INR
  | IQD
  | IRR
  | ISK
  | JMD
  | JOD
  | JPY
  | KES
  | KGS
  | KHR
  | KMF
  | KPW
  | KRW
  | KWD
  | KYD
  | KZT
  | LAK
  | LBP
  | LKR
  | LRD
  | LSL
  | LYD
  | MAD
  | MDL
  | MGA
  | MKD
  | MMK
  | MNT
  | MOP
  | MRU
  | MUR
  | MVR
  | MWK
  | MXN
  | MYR
  | MZN
  | NAD
  | NGN
  | NIO
  | NOK
  | NPR
  | NZD
  | OMR
  | PAB
  | PEN
  | PGK
  | PHP
  | PKR
  | PLN
  | PYG
  | QAR
  | RON
  | RSD
  | RUB
  | RWF
  | SAR
  | SBD
  | SCR
  | SDG
  | SEK
  | SGD
  | SHP
  | SLE
  | SLL
  | SOS
  | SRD
  | SSP
  | STN
  | SVC
  | SYP
  | SZL
  | THB
  | TJS
  | TMT
  | TND
  | TOP
  | TRY
  | TTD
  | TWD
  | TZS
  | UAH
  | UGX
  | USD
  | UYU
  | UZS
  | VES
  | VND
  | VUV
  | WST
  | XAF
  | XCD
  | XCG
  | XDR
  | XOF
  | XPF
  | XSU
  | YER
  | ZAR
  | ZMW
  | ZWG
  | ZWL

derive instance Eq Currency
derive instance Ord Currency

instance Show Currency where
  show = toString

instance Bounded Currency where
  bottom = AED
  top = ZWL

instance Enum Currency where
  succ = case _ of
    AED -> Just AFN
    AFN -> Just ALL
    ALL -> Just AMD
    AMD -> Just ANG
    ANG -> Just AOA
    AOA -> Just ARS
    ARS -> Just AUD
    AUD -> Just AWG
    AWG -> Just AZN
    AZN -> Just BAM
    BAM -> Just BBD
    BBD -> Just BDT
    BDT -> Just BGN
    BGN -> Just BHD
    BHD -> Just BIF
    BIF -> Just BMD
    BMD -> Just BND
    BND -> Just BOB
    BOB -> Just BRL
    BRL -> Just BSD
    BSD -> Just BTN
    BTN -> Just BWP
    BWP -> Just BYN
    BYN -> Just BZD
    BZD -> Just CAD
    CAD -> Just CDF
    CDF -> Just CHF
    CHF -> Just CLP
    CLP -> Just CNY
    CNY -> Just COP
    COP -> Just CRC
    CRC -> Just CUC
    CUC -> Just CUP
    CUP -> Just CVE
    CVE -> Just CZK
    CZK -> Just DJF
    DJF -> Just DKK
    DKK -> Just DOP
    DOP -> Just DZD
    DZD -> Just EGP
    EGP -> Just ERN
    ERN -> Just ETB
    ETB -> Just EUR
    EUR -> Just FJD
    FJD -> Just FKP
    FKP -> Just GBP
    GBP -> Just GEL
    GEL -> Just GHS
    GHS -> Just GIP
    GIP -> Just GMD
    GMD -> Just GNF
    GNF -> Just GTQ
    GTQ -> Just GYD
    GYD -> Just HKD
    HKD -> Just HNL
    HNL -> Just HRK
    HRK -> Just HTG
    HTG -> Just HUF
    HUF -> Just IDR
    IDR -> Just ILS
    ILS -> Just INR
    INR -> Just IQD
    IQD -> Just IRR
    IRR -> Just ISK
    ISK -> Just JMD
    JMD -> Just JOD
    JOD -> Just JPY
    JPY -> Just KES
    KES -> Just KGS
    KGS -> Just KHR
    KHR -> Just KMF
    KMF -> Just KPW
    KPW -> Just KRW
    KRW -> Just KWD
    KWD -> Just KYD
    KYD -> Just KZT
    KZT -> Just LAK
    LAK -> Just LBP
    LBP -> Just LKR
    LKR -> Just LRD
    LRD -> Just LSL
    LSL -> Just LYD
    LYD -> Just MAD
    MAD -> Just MDL
    MDL -> Just MGA
    MGA -> Just MKD
    MKD -> Just MMK
    MMK -> Just MNT
    MNT -> Just MOP
    MOP -> Just MRU
    MRU -> Just MUR
    MUR -> Just MVR
    MVR -> Just MWK
    MWK -> Just MXN
    MXN -> Just MYR
    MYR -> Just MZN
    MZN -> Just NAD
    NAD -> Just NGN
    NGN -> Just NIO
    NIO -> Just NOK
    NOK -> Just NPR
    NPR -> Just NZD
    NZD -> Just OMR
    OMR -> Just PAB
    PAB -> Just PEN
    PEN -> Just PGK
    PGK -> Just PHP
    PHP -> Just PKR
    PKR -> Just PLN
    PLN -> Just PYG
    PYG -> Just QAR
    QAR -> Just RON
    RON -> Just RSD
    RSD -> Just RUB
    RUB -> Just RWF
    RWF -> Just SAR
    SAR -> Just SBD
    SBD -> Just SCR
    SCR -> Just SDG
    SDG -> Just SEK
    SEK -> Just SGD
    SGD -> Just SHP
    SHP -> Just SLE
    SLE -> Just SLL
    SLL -> Just SOS
    SOS -> Just SRD
    SRD -> Just SSP
    SSP -> Just STN
    STN -> Just SVC
    SVC -> Just SYP
    SYP -> Just SZL
    SZL -> Just THB
    THB -> Just TJS
    TJS -> Just TMT
    TMT -> Just TND
    TND -> Just TOP
    TOP -> Just TRY
    TRY -> Just TTD
    TTD -> Just TWD
    TWD -> Just TZS
    TZS -> Just UAH
    UAH -> Just UGX
    UGX -> Just USD
    USD -> Just UYU
    UYU -> Just UZS
    UZS -> Just VES
    VES -> Just VND
    VND -> Just VUV
    VUV -> Just WST
    WST -> Just XAF
    XAF -> Just XCD
    XCD -> Just XCG
    XCG -> Just XDR
    XDR -> Just XOF
    XOF -> Just XPF
    XPF -> Just XSU
    XSU -> Just YER
    YER -> Just ZAR
    ZAR -> Just ZMW
    ZMW -> Just ZWG
    ZWG -> Just ZWL
    ZWL -> Nothing
  pred = case _ of
    AED -> Nothing
    AFN -> Just AED
    ALL -> Just AFN
    AMD -> Just ALL
    ANG -> Just AMD
    AOA -> Just ANG
    ARS -> Just AOA
    AUD -> Just ARS
    AWG -> Just AUD
    AZN -> Just AWG
    BAM -> Just AZN
    BBD -> Just BAM
    BDT -> Just BBD
    BGN -> Just BDT
    BHD -> Just BGN
    BIF -> Just BHD
    BMD -> Just BIF
    BND -> Just BMD
    BOB -> Just BND
    BRL -> Just BOB
    BSD -> Just BRL
    BTN -> Just BSD
    BWP -> Just BTN
    BYN -> Just BWP
    BZD -> Just BYN
    CAD -> Just BZD
    CDF -> Just CAD
    CHF -> Just CDF
    CLP -> Just CHF
    CNY -> Just CLP
    COP -> Just CNY
    CRC -> Just COP
    CUC -> Just CRC
    CUP -> Just CUC
    CVE -> Just CUP
    CZK -> Just CVE
    DJF -> Just CZK
    DKK -> Just DJF
    DOP -> Just DKK
    DZD -> Just DOP
    EGP -> Just DZD
    ERN -> Just EGP
    ETB -> Just ERN
    EUR -> Just ETB
    FJD -> Just EUR
    FKP -> Just FJD
    GBP -> Just FKP
    GEL -> Just GBP
    GHS -> Just GEL
    GIP -> Just GHS
    GMD -> Just GIP
    GNF -> Just GMD
    GTQ -> Just GNF
    GYD -> Just GTQ
    HKD -> Just GYD
    HNL -> Just HKD
    HRK -> Just HNL
    HTG -> Just HRK
    HUF -> Just HTG
    IDR -> Just HUF
    ILS -> Just IDR
    INR -> Just ILS
    IQD -> Just INR
    IRR -> Just IQD
    ISK -> Just IRR
    JMD -> Just ISK
    JOD -> Just JMD
    JPY -> Just JOD
    KES -> Just JPY
    KGS -> Just KES
    KHR -> Just KGS
    KMF -> Just KHR
    KPW -> Just KMF
    KRW -> Just KPW
    KWD -> Just KRW
    KYD -> Just KWD
    KZT -> Just KYD
    LAK -> Just KZT
    LBP -> Just LAK
    LKR -> Just LBP
    LRD -> Just LKR
    LSL -> Just LRD
    LYD -> Just LSL
    MAD -> Just LYD
    MDL -> Just MAD
    MGA -> Just MDL
    MKD -> Just MGA
    MMK -> Just MKD
    MNT -> Just MMK
    MOP -> Just MNT
    MRU -> Just MOP
    MUR -> Just MRU
    MVR -> Just MUR
    MWK -> Just MVR
    MXN -> Just MWK
    MYR -> Just MXN
    MZN -> Just MYR
    NAD -> Just MZN
    NGN -> Just NAD
    NIO -> Just NGN
    NOK -> Just NIO
    NPR -> Just NOK
    NZD -> Just NPR
    OMR -> Just NZD
    PAB -> Just OMR
    PEN -> Just PAB
    PGK -> Just PEN
    PHP -> Just PGK
    PKR -> Just PHP
    PLN -> Just PKR
    PYG -> Just PLN
    QAR -> Just PYG
    RON -> Just QAR
    RSD -> Just RON
    RUB -> Just RSD
    RWF -> Just RUB
    SAR -> Just RWF
    SBD -> Just SAR
    SCR -> Just SBD
    SDG -> Just SCR
    SEK -> Just SDG
    SGD -> Just SEK
    SHP -> Just SGD
    SLE -> Just SHP
    SLL -> Just SLE
    SOS -> Just SLL
    SRD -> Just SOS
    SSP -> Just SRD
    STN -> Just SSP
    SVC -> Just STN
    SYP -> Just SVC
    SZL -> Just SYP
    THB -> Just SZL
    TJS -> Just THB
    TMT -> Just TJS
    TND -> Just TMT
    TOP -> Just TND
    TRY -> Just TOP
    TTD -> Just TRY
    TWD -> Just TTD
    TZS -> Just TWD
    UAH -> Just TZS
    UGX -> Just UAH
    USD -> Just UGX
    UYU -> Just USD
    UZS -> Just UYU
    VES -> Just UZS
    VND -> Just VES
    VUV -> Just VND
    WST -> Just VUV
    XAF -> Just WST
    XCD -> Just XAF
    XCG -> Just XCD
    XDR -> Just XCG
    XOF -> Just XDR
    XPF -> Just XOF
    XSU -> Just XPF
    YER -> Just XSU
    ZAR -> Just YER
    ZMW -> Just ZAR
    ZWG -> Just ZMW
    ZWL -> Just ZWG

instance BoundedEnum Currency where
  cardinality = Cardinality 162
  toEnum = case _ of
    0 -> Just AED
    1 -> Just AFN
    2 -> Just ALL
    3 -> Just AMD
    4 -> Just ANG
    5 -> Just AOA
    6 -> Just ARS
    7 -> Just AUD
    8 -> Just AWG
    9 -> Just AZN
    10 -> Just BAM
    11 -> Just BBD
    12 -> Just BDT
    13 -> Just BGN
    14 -> Just BHD
    15 -> Just BIF
    16 -> Just BMD
    17 -> Just BND
    18 -> Just BOB
    19 -> Just BRL
    20 -> Just BSD
    21 -> Just BTN
    22 -> Just BWP
    23 -> Just BYN
    24 -> Just BZD
    25 -> Just CAD
    26 -> Just CDF
    27 -> Just CHF
    28 -> Just CLP
    29 -> Just CNY
    30 -> Just COP
    31 -> Just CRC
    32 -> Just CUC
    33 -> Just CUP
    34 -> Just CVE
    35 -> Just CZK
    36 -> Just DJF
    37 -> Just DKK
    38 -> Just DOP
    39 -> Just DZD
    40 -> Just EGP
    41 -> Just ERN
    42 -> Just ETB
    43 -> Just EUR
    44 -> Just FJD
    45 -> Just FKP
    46 -> Just GBP
    47 -> Just GEL
    48 -> Just GHS
    49 -> Just GIP
    50 -> Just GMD
    51 -> Just GNF
    52 -> Just GTQ
    53 -> Just GYD
    54 -> Just HKD
    55 -> Just HNL
    56 -> Just HRK
    57 -> Just HTG
    58 -> Just HUF
    59 -> Just IDR
    60 -> Just ILS
    61 -> Just INR
    62 -> Just IQD
    63 -> Just IRR
    64 -> Just ISK
    65 -> Just JMD
    66 -> Just JOD
    67 -> Just JPY
    68 -> Just KES
    69 -> Just KGS
    70 -> Just KHR
    71 -> Just KMF
    72 -> Just KPW
    73 -> Just KRW
    74 -> Just KWD
    75 -> Just KYD
    76 -> Just KZT
    77 -> Just LAK
    78 -> Just LBP
    79 -> Just LKR
    80 -> Just LRD
    81 -> Just LSL
    82 -> Just LYD
    83 -> Just MAD
    84 -> Just MDL
    85 -> Just MGA
    86 -> Just MKD
    87 -> Just MMK
    88 -> Just MNT
    89 -> Just MOP
    90 -> Just MRU
    91 -> Just MUR
    92 -> Just MVR
    93 -> Just MWK
    94 -> Just MXN
    95 -> Just MYR
    96 -> Just MZN
    97 -> Just NAD
    98 -> Just NGN
    99 -> Just NIO
    100 -> Just NOK
    101 -> Just NPR
    102 -> Just NZD
    103 -> Just OMR
    104 -> Just PAB
    105 -> Just PEN
    106 -> Just PGK
    107 -> Just PHP
    108 -> Just PKR
    109 -> Just PLN
    110 -> Just PYG
    111 -> Just QAR
    112 -> Just RON
    113 -> Just RSD
    114 -> Just RUB
    115 -> Just RWF
    116 -> Just SAR
    117 -> Just SBD
    118 -> Just SCR
    119 -> Just SDG
    120 -> Just SEK
    121 -> Just SGD
    122 -> Just SHP
    123 -> Just SLE
    124 -> Just SLL
    125 -> Just SOS
    126 -> Just SRD
    127 -> Just SSP
    128 -> Just STN
    129 -> Just SVC
    130 -> Just SYP
    131 -> Just SZL
    132 -> Just THB
    133 -> Just TJS
    134 -> Just TMT
    135 -> Just TND
    136 -> Just TOP
    137 -> Just TRY
    138 -> Just TTD
    139 -> Just TWD
    140 -> Just TZS
    141 -> Just UAH
    142 -> Just UGX
    143 -> Just USD
    144 -> Just UYU
    145 -> Just UZS
    146 -> Just VES
    147 -> Just VND
    148 -> Just VUV
    149 -> Just WST
    150 -> Just XAF
    151 -> Just XCD
    152 -> Just XCG
    153 -> Just XDR
    154 -> Just XOF
    155 -> Just XPF
    156 -> Just XSU
    157 -> Just YER
    158 -> Just ZAR
    159 -> Just ZMW
    160 -> Just ZWG
    161 -> Just ZWL
    _ -> Nothing
  fromEnum = case _ of
    AED -> 0
    AFN -> 1
    ALL -> 2
    AMD -> 3
    ANG -> 4
    AOA -> 5
    ARS -> 6
    AUD -> 7
    AWG -> 8
    AZN -> 9
    BAM -> 10
    BBD -> 11
    BDT -> 12
    BGN -> 13
    BHD -> 14
    BIF -> 15
    BMD -> 16
    BND -> 17
    BOB -> 18
    BRL -> 19
    BSD -> 20
    BTN -> 21
    BWP -> 22
    BYN -> 23
    BZD -> 24
    CAD -> 25
    CDF -> 26
    CHF -> 27
    CLP -> 28
    CNY -> 29
    COP -> 30
    CRC -> 31
    CUC -> 32
    CUP -> 33
    CVE -> 34
    CZK -> 35
    DJF -> 36
    DKK -> 37
    DOP -> 38
    DZD -> 39
    EGP -> 40
    ERN -> 41
    ETB -> 42
    EUR -> 43
    FJD -> 44
    FKP -> 45
    GBP -> 46
    GEL -> 47
    GHS -> 48
    GIP -> 49
    GMD -> 50
    GNF -> 51
    GTQ -> 52
    GYD -> 53
    HKD -> 54
    HNL -> 55
    HRK -> 56
    HTG -> 57
    HUF -> 58
    IDR -> 59
    ILS -> 60
    INR -> 61
    IQD -> 62
    IRR -> 63
    ISK -> 64
    JMD -> 65
    JOD -> 66
    JPY -> 67
    KES -> 68
    KGS -> 69
    KHR -> 70
    KMF -> 71
    KPW -> 72
    KRW -> 73
    KWD -> 74
    KYD -> 75
    KZT -> 76
    LAK -> 77
    LBP -> 78
    LKR -> 79
    LRD -> 80
    LSL -> 81
    LYD -> 82
    MAD -> 83
    MDL -> 84
    MGA -> 85
    MKD -> 86
    MMK -> 87
    MNT -> 88
    MOP -> 89
    MRU -> 90
    MUR -> 91
    MVR -> 92
    MWK -> 93
    MXN -> 94
    MYR -> 95
    MZN -> 96
    NAD -> 97
    NGN -> 98
    NIO -> 99
    NOK -> 100
    NPR -> 101
    NZD -> 102
    OMR -> 103
    PAB -> 104
    PEN -> 105
    PGK -> 106
    PHP -> 107
    PKR -> 108
    PLN -> 109
    PYG -> 110
    QAR -> 111
    RON -> 112
    RSD -> 113
    RUB -> 114
    RWF -> 115
    SAR -> 116
    SBD -> 117
    SCR -> 118
    SDG -> 119
    SEK -> 120
    SGD -> 121
    SHP -> 122
    SLE -> 123
    SLL -> 124
    SOS -> 125
    SRD -> 126
    SSP -> 127
    STN -> 128
    SVC -> 129
    SYP -> 130
    SZL -> 131
    THB -> 132
    TJS -> 133
    TMT -> 134
    TND -> 135
    TOP -> 136
    TRY -> 137
    TTD -> 138
    TWD -> 139
    TZS -> 140
    UAH -> 141
    UGX -> 142
    USD -> 143
    UYU -> 144
    UZS -> 145
    VES -> 146
    VND -> 147
    VUV -> 148
    WST -> 149
    XAF -> 150
    XCD -> 151
    XCG -> 152
    XDR -> 153
    XOF -> 154
    XPF -> 155
    XSU -> 156
    YER -> 157
    ZAR -> 158
    ZMW -> 159
    ZWG -> 160
    ZWL -> 161

toString :: Currency -> String
toString = case _ of
  AED -> "AED"
  AFN -> "AFN"
  ALL -> "ALL"
  AMD -> "AMD"
  ANG -> "ANG"
  AOA -> "AOA"
  ARS -> "ARS"
  AUD -> "AUD"
  AWG -> "AWG"
  AZN -> "AZN"
  BAM -> "BAM"
  BBD -> "BBD"
  BDT -> "BDT"
  BGN -> "BGN"
  BHD -> "BHD"
  BIF -> "BIF"
  BMD -> "BMD"
  BND -> "BND"
  BOB -> "BOB"
  BRL -> "BRL"
  BSD -> "BSD"
  BTN -> "BTN"
  BWP -> "BWP"
  BYN -> "BYN"
  BZD -> "BZD"
  CAD -> "CAD"
  CDF -> "CDF"
  CHF -> "CHF"
  CLP -> "CLP"
  CNY -> "CNY"
  COP -> "COP"
  CRC -> "CRC"
  CUC -> "CUC"
  CUP -> "CUP"
  CVE -> "CVE"
  CZK -> "CZK"
  DJF -> "DJF"
  DKK -> "DKK"
  DOP -> "DOP"
  DZD -> "DZD"
  EGP -> "EGP"
  ERN -> "ERN"
  ETB -> "ETB"
  EUR -> "EUR"
  FJD -> "FJD"
  FKP -> "FKP"
  GBP -> "GBP"
  GEL -> "GEL"
  GHS -> "GHS"
  GIP -> "GIP"
  GMD -> "GMD"
  GNF -> "GNF"
  GTQ -> "GTQ"
  GYD -> "GYD"
  HKD -> "HKD"
  HNL -> "HNL"
  HRK -> "HRK"
  HTG -> "HTG"
  HUF -> "HUF"
  IDR -> "IDR"
  ILS -> "ILS"
  INR -> "INR"
  IQD -> "IQD"
  IRR -> "IRR"
  ISK -> "ISK"
  JMD -> "JMD"
  JOD -> "JOD"
  JPY -> "JPY"
  KES -> "KES"
  KGS -> "KGS"
  KHR -> "KHR"
  KMF -> "KMF"
  KPW -> "KPW"
  KRW -> "KRW"
  KWD -> "KWD"
  KYD -> "KYD"
  KZT -> "KZT"
  LAK -> "LAK"
  LBP -> "LBP"
  LKR -> "LKR"
  LRD -> "LRD"
  LSL -> "LSL"
  LYD -> "LYD"
  MAD -> "MAD"
  MDL -> "MDL"
  MGA -> "MGA"
  MKD -> "MKD"
  MMK -> "MMK"
  MNT -> "MNT"
  MOP -> "MOP"
  MRU -> "MRU"
  MUR -> "MUR"
  MVR -> "MVR"
  MWK -> "MWK"
  MXN -> "MXN"
  MYR -> "MYR"
  MZN -> "MZN"
  NAD -> "NAD"
  NGN -> "NGN"
  NIO -> "NIO"
  NOK -> "NOK"
  NPR -> "NPR"
  NZD -> "NZD"
  OMR -> "OMR"
  PAB -> "PAB"
  PEN -> "PEN"
  PGK -> "PGK"
  PHP -> "PHP"
  PKR -> "PKR"
  PLN -> "PLN"
  PYG -> "PYG"
  QAR -> "QAR"
  RON -> "RON"
  RSD -> "RSD"
  RUB -> "RUB"
  RWF -> "RWF"
  SAR -> "SAR"
  SBD -> "SBD"
  SCR -> "SCR"
  SDG -> "SDG"
  SEK -> "SEK"
  SGD -> "SGD"
  SHP -> "SHP"
  SLE -> "SLE"
  SLL -> "SLL"
  SOS -> "SOS"
  SRD -> "SRD"
  SSP -> "SSP"
  STN -> "STN"
  SVC -> "SVC"
  SYP -> "SYP"
  SZL -> "SZL"
  THB -> "THB"
  TJS -> "TJS"
  TMT -> "TMT"
  TND -> "TND"
  TOP -> "TOP"
  TRY -> "TRY"
  TTD -> "TTD"
  TWD -> "TWD"
  TZS -> "TZS"
  UAH -> "UAH"
  UGX -> "UGX"
  USD -> "USD"
  UYU -> "UYU"
  UZS -> "UZS"
  VES -> "VES"
  VND -> "VND"
  VUV -> "VUV"
  WST -> "WST"
  XAF -> "XAF"
  XCD -> "XCD"
  XCG -> "XCG"
  XDR -> "XDR"
  XOF -> "XOF"
  XPF -> "XPF"
  XSU -> "XSU"
  YER -> "YER"
  ZAR -> "ZAR"
  ZMW -> "ZMW"
  ZWG -> "ZWG"
  ZWL -> "ZWL"

fromString :: String -> Maybe Currency
fromString = case _ of
  "AED" -> Just AED
  "AFN" -> Just AFN
  "ALL" -> Just ALL
  "AMD" -> Just AMD
  "ANG" -> Just ANG
  "AOA" -> Just AOA
  "ARS" -> Just ARS
  "AUD" -> Just AUD
  "AWG" -> Just AWG
  "AZN" -> Just AZN
  "BAM" -> Just BAM
  "BBD" -> Just BBD
  "BDT" -> Just BDT
  "BGN" -> Just BGN
  "BHD" -> Just BHD
  "BIF" -> Just BIF
  "BMD" -> Just BMD
  "BND" -> Just BND
  "BOB" -> Just BOB
  "BRL" -> Just BRL
  "BSD" -> Just BSD
  "BTN" -> Just BTN
  "BWP" -> Just BWP
  "BYN" -> Just BYN
  "BZD" -> Just BZD
  "CAD" -> Just CAD
  "CDF" -> Just CDF
  "CHF" -> Just CHF
  "CLP" -> Just CLP
  "CNY" -> Just CNY
  "COP" -> Just COP
  "CRC" -> Just CRC
  "CUC" -> Just CUC
  "CUP" -> Just CUP
  "CVE" -> Just CVE
  "CZK" -> Just CZK
  "DJF" -> Just DJF
  "DKK" -> Just DKK
  "DOP" -> Just DOP
  "DZD" -> Just DZD
  "EGP" -> Just EGP
  "ERN" -> Just ERN
  "ETB" -> Just ETB
  "EUR" -> Just EUR
  "FJD" -> Just FJD
  "FKP" -> Just FKP
  "GBP" -> Just GBP
  "GEL" -> Just GEL
  "GHS" -> Just GHS
  "GIP" -> Just GIP
  "GMD" -> Just GMD
  "GNF" -> Just GNF
  "GTQ" -> Just GTQ
  "GYD" -> Just GYD
  "HKD" -> Just HKD
  "HNL" -> Just HNL
  "HRK" -> Just HRK
  "HTG" -> Just HTG
  "HUF" -> Just HUF
  "IDR" -> Just IDR
  "ILS" -> Just ILS
  "INR" -> Just INR
  "IQD" -> Just IQD
  "IRR" -> Just IRR
  "ISK" -> Just ISK
  "JMD" -> Just JMD
  "JOD" -> Just JOD
  "JPY" -> Just JPY
  "KES" -> Just KES
  "KGS" -> Just KGS
  "KHR" -> Just KHR
  "KMF" -> Just KMF
  "KPW" -> Just KPW
  "KRW" -> Just KRW
  "KWD" -> Just KWD
  "KYD" -> Just KYD
  "KZT" -> Just KZT
  "LAK" -> Just LAK
  "LBP" -> Just LBP
  "LKR" -> Just LKR
  "LRD" -> Just LRD
  "LSL" -> Just LSL
  "LYD" -> Just LYD
  "MAD" -> Just MAD
  "MDL" -> Just MDL
  "MGA" -> Just MGA
  "MKD" -> Just MKD
  "MMK" -> Just MMK
  "MNT" -> Just MNT
  "MOP" -> Just MOP
  "MRU" -> Just MRU
  "MUR" -> Just MUR
  "MVR" -> Just MVR
  "MWK" -> Just MWK
  "MXN" -> Just MXN
  "MYR" -> Just MYR
  "MZN" -> Just MZN
  "NAD" -> Just NAD
  "NGN" -> Just NGN
  "NIO" -> Just NIO
  "NOK" -> Just NOK
  "NPR" -> Just NPR
  "NZD" -> Just NZD
  "OMR" -> Just OMR
  "PAB" -> Just PAB
  "PEN" -> Just PEN
  "PGK" -> Just PGK
  "PHP" -> Just PHP
  "PKR" -> Just PKR
  "PLN" -> Just PLN
  "PYG" -> Just PYG
  "QAR" -> Just QAR
  "RON" -> Just RON
  "RSD" -> Just RSD
  "RUB" -> Just RUB
  "RWF" -> Just RWF
  "SAR" -> Just SAR
  "SBD" -> Just SBD
  "SCR" -> Just SCR
  "SDG" -> Just SDG
  "SEK" -> Just SEK
  "SGD" -> Just SGD
  "SHP" -> Just SHP
  "SLE" -> Just SLE
  "SLL" -> Just SLL
  "SOS" -> Just SOS
  "SRD" -> Just SRD
  "SSP" -> Just SSP
  "STN" -> Just STN
  "SVC" -> Just SVC
  "SYP" -> Just SYP
  "SZL" -> Just SZL
  "THB" -> Just THB
  "TJS" -> Just TJS
  "TMT" -> Just TMT
  "TND" -> Just TND
  "TOP" -> Just TOP
  "TRY" -> Just TRY
  "TTD" -> Just TTD
  "TWD" -> Just TWD
  "TZS" -> Just TZS
  "UAH" -> Just UAH
  "UGX" -> Just UGX
  "USD" -> Just USD
  "UYU" -> Just UYU
  "UZS" -> Just UZS
  "VES" -> Just VES
  "VND" -> Just VND
  "VUV" -> Just VUV
  "WST" -> Just WST
  "XAF" -> Just XAF
  "XCD" -> Just XCD
  "XCG" -> Just XCG
  "XDR" -> Just XDR
  "XOF" -> Just XOF
  "XPF" -> Just XPF
  "XSU" -> Just XSU
  "YER" -> Just YER
  "ZAR" -> Just ZAR
  "ZMW" -> Just ZMW
  "ZWG" -> Just ZWG
  "ZWL" -> Just ZWL
  _ -> Nothing

allCurrencies :: Array Currency
allCurrencies = enumFromTo bottom top

instance WriteForeign Currency where
  writeImpl = toString >>> writeImpl

instance ReadForeign Currency where
  readImpl f = do
    let parse s = case fromString s of
          Just c -> pure c
          Nothing -> throwError $ pure $ ForeignError $ "Unknown currency: " <> s
    s <- readImpl f
    parse s

