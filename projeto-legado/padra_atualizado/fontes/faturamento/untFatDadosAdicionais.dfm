inherited frmFatDadosAdicionais: TfrmFatDadosAdicionais
  Left = 282
  Top = 334
  Width = 609
  Height = 363
  Caption = 'Dados Adicionais'
  ExplicitWidth = 609
  ExplicitHeight = 363
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 101
    Top = 17
    Width = 63
    Height = 14
    Alignment = taRightJustify
    Caption = 'Mercadorias:'
  end
  object Label1: TLabel [1]
    Left = 26
    Top = 88
    Width = 138
    Height = 14
    Alignment = taRightJustify
    Caption = 'Frete e seguro internacional:'
  end
  object Label4: TLabel [2]
    Left = 57
    Top = 157
    Width = 107
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valores dos Produtos:'
  end
  object Label5: TLabel [3]
    Left = 68
    Top = 180
    Width = 96
    Height = 14
    Alignment = taRightJustify
    Caption = 'Taxa do SISCOMEX:'
  end
  object Label6: TLabel [4]
    Left = 111
    Top = 203
    Width = 53
    Height = 14
    Alignment = taRightJustify
    Caption = 'PIS/PASEP:'
  end
  object Label7: TLabel [5]
    Left = 124
    Top = 226
    Width = 40
    Height = 14
    Alignment = taRightJustify
    Caption = 'COFINS:'
  end
  object Label11: TLabel [6]
    Left = 139
    Top = 249
    Width = 27
    Height = 14
    Alignment = taRightJustify
    Caption = 'ICMS:'
  end
  object Label3: TLabel [7]
    Left = 23
    Top = 134
    Width = 141
    Height = 14
    Alignment = taRightJustify
    Caption = 'Imposto de Importa'#231#227'o(20%):'
  end
  object Label12: TLabel [8]
    Left = 5
    Top = 111
    Width = 159
    Height = 14
    Alignment = taRightJustify
    Caption = 'Base C'#225'lculo Imposto Importa'#231#227'o'
  end
  object Label13: TLabel [9]
    Left = 246
    Top = 110
    Width = 110
    Height = 14
    Alignment = taRightJustify
    Caption = 'Despesas Aduaneiras:'
  end
  object Label14: TLabel [10]
    Left = 309
    Top = 133
    Width = 47
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor IOF:'
  end
  object Label8: TLabel [11]
    Left = 276
    Top = 154
    Width = 78
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor  A.F.R.M.M'
  end
  object Label9: TLabel [12]
    Left = 290
    Top = 178
    Width = 64
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor Outros:'
  end
  object Label10: TLabel [13]
    Left = 72
    Top = 41
    Width = 92
    Height = 14
    Alignment = taRightJustify
    Caption = 'Frete internacional:'
  end
  object Label15: TLabel [14]
    Left = 62
    Top = 64
    Width = 102
    Height = 14
    Alignment = taRightJustify
    Caption = 'Seguro internacional:'
  end
  inherited pnlBotoes: TPanel
    Top = 292
    Width = 603
    Height = 26
    TabOrder = 12
    ExplicitTop = 250
    ExplicitWidth = 603
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 77
      Width = 447
      Height = 22
      TabOrder = 2
      ExplicitLeft = 77
      ExplicitWidth = 447
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 524
      Top = 2
      Align = alRight
      ExplicitLeft = 524
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 75
      Height = 22
      Align = alLeft
      Caption = '&Confirma'
      ModalResult = 1
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 318
    Width = 603
    TabOrder = 13
    ExplicitTop = 276
    ExplicitWidth = 603
    inherited pnlNomeForm: TPanel
      Left = 432
      ExplicitLeft = 432
    end
    inherited pnlInfo: TPanel
      Width = 432
      ExplicitWidth = 432
    end
  end
  object edtImpMer: TEditFocus [17]
    Tag = 99
    Left = 168
    Top = 10
    Width = 62
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtImpSeg: TEditFocus [18]
    Tag = 99
    Left = 168
    Top = 81
    Width = 62
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtImpPro: TEditFocus [19]
    Tag = 99
    Left = 168
    Top = 150
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ReadOnly = True
    TabOrder = 6
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtImpTax: TEditFocus [20]
    Tag = 99
    Left = 168
    Top = 173
    Width = 62
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    TabOrder = 7
    OnChange = edtImpTaxChange
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtImpPis: TEditFocus [21]
    Tag = 99
    Left = 168
    Top = 196
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ReadOnly = True
    TabOrder = 8
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtImpCof: TEditFocus [22]
    Tag = 99
    Left = 168
    Top = 219
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ReadOnly = True
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtImpIC1: TEditFocus [23]
    Tag = 99
    Left = 168
    Top = 242
    Width = 425
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 250
    TabOrder = 10
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtImpIC2: TEditFocus [24]
    Tag = 99
    Left = 168
    Top = 265
    Width = 425
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 250
    TabOrder = 11
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtImpImp: TEditFocus [25]
    Tag = 99
    Left = 168
    Top = 127
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ReadOnly = True
    TabOrder = 4
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtBaseII: TEditFocus [26]
    Tag = 99
    Left = 168
    Top = 104
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ReadOnly = True
    TabOrder = 2
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtDesAdu: TEditFocus [27]
    Tag = 99
    Left = 360
    Top = 103
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ReadOnly = True
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtValIOF: TEditFocus [28]
    Tag = 99
    Left = 360
    Top = 126
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ReadOnly = True
    TabOrder = 5
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object btnDespesasAduaneiras: TBitBtnLocked [29]
    Left = 424
    Top = 103
    Width = 23
    Height = 23
    Hint = 'Valores para Despesas Aduaneiras'
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000340B0000340B00000001000000000000EA8F3100B66A
      5000AB735800C07B5800EAA15800FFB65800AB6A6000B67B6000C08460006A6A
      6A00A16A6A00A1736A00C0846A006AFF6A00A17B7300B68F7B00F4C07B00B68F
      8400F4C08400F4CA8400B6988F00C0988F00F4CA8F00B6AB9800F4CA9800D4AB
      A100D4B6A100E0B6A100EAB6A100EAC0A100F4D4A100FFD4A100EAC0AB00F4D4
      AB00F4E0B600E0C0C000E0CAC000E0CACA00F4E0CA00FFEACA00FFEAD400FFF4
      E000FFF4EA00FFF4F400FFFFF400FF00FF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002D2D0A0A0A0A
      0A0A0A0A0A0A0A0A0A2D2D2D112722211E181612101010130A2D2D2D11270909
      09090909090909120A2D2D2D14290D0D0D0D0D0D0D0D0D120A2D2D2D14290D0D
      0D0D0D0D0D0D0D100A2D2D2D142C090909090909090909120A2D2D2D1A2E0D0D
      0D0D0D0D0D0D0D0D0A2D2D2D1A2E0D0D0D0D0D0D0D0D0D0D0A2D2D2D1A2E0909
      090909090909091E0A2D2D2D192E0D0D0D0D0D0D0D0D0D1E0A2D2D2D1A2E0D0D
      0D0D0D0D0D0D0D170A2D2D2D1B2E09090909092A260F0E0B0A2D2D2D1B2E0D0D
      0D0D0D0D23020400012D2D2D202E0D0D0D0D0D0D240705032D2D2D2D1B2B2A2A
      2A2A2A2A23070C2D2D2D2D2D1B1D1D1D1D1B1B1D19062D2D2D2D}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    OnClick = btnDespesasAduaneirasClick
  end
  object edtAFRMM: TEditFocus [30]
    Tag = 99
    Left = 360
    Top = 150
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ReadOnly = True
    TabOrder = 15
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtTotDes: TEditFocus [31]
    Tag = 99
    Left = 360
    Top = 174
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 7
    ReadOnly = True
    TabOrder = 16
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object btnHlpImp: TBitBtnLocked [32]
    Left = 424
    Top = 174
    Width = 23
    Height = 22
    Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000010000000800000010000000100000
      0008000000010000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
      0B60000000070000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
      27EA0000000E0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
      30EC0000000D0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
      1A51000000050000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000010000000600000011000000140000
      000A000000020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000670503AA999532EFF4528
      187A000000070000000100000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
      4AF724150D490000000800000002000000000000000000000000000000000000
      0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
      9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
      000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
      AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
      00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
      76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
      000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
      70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
      000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
      C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
      0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
      77E570533B9A17100A2500000002000000000000000000000000000000000000
      0000000000000000000000000000000000010000000100000002000000030000
      0002000000020000000100000000000000000000000000000000}
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = btnHlpImpClick
  end
  object edtFreImp: TEditFocus [33]
    Tag = 99
    Left = 168
    Top = 33
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ReadOnly = True
    TabOrder = 18
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtSegImp: TEditFocus [34]
    Tag = 99
    Left = 168
    Top = 56
    Width = 62
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Color = 16768952
    ReadOnly = True
    TabOrder = 19
    NormalColor = 16768952
    FocusColor = 16768952
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 47
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
  end
end
