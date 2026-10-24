inherited frmCadManutInvFator: TfrmCadManutInvFator
  Left = 312
  Top = 467
  Width = 379
  Height = 423
  Caption = 'Reajuste de valores'
  Position = poMainFormCenter
  ExplicitWidth = 379
  ExplicitHeight = 423
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 162
    Top = 281
    Width = 75
    Height = 14
    Caption = 'Fator de ajuste:'
  end
  object Label2: TLabel [1]
    Left = 120
    Top = 329
    Width = 116
    Height = 14
    Caption = 'Valor total do Invent'#225'rio:'
  end
  object lbl1: TLabel [2]
    Left = 6
    Top = 122
    Width = 109
    Height = 14
    Caption = 'Linha / Grupo a Excluir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [3]
    Left = 45
    Top = 305
    Width = 192
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor do Invent'#225'rio com os filtros acima:'
  end
  object Label4: TLabel [4]
    Left = 6
    Top = 160
    Width = 87
    Height = 14
    Caption = 'Abrevia'#231#227'o Fiscal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 350
    Width = 373
    TabOrder = 11
    ExplicitTop = 350
    ExplicitWidth = 373
    DesignSize = (
      373
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 369
      TabOrder = 3
      ExplicitWidth = 369
    end
    inherited btnSair: TBitBtnLocked
      Left = 287
      Width = 82
      TabOrder = 2
      ExplicitLeft = 287
      ExplicitWidth = 82
    end
    object btnAlterar: TBitBtnLocked
      Left = 89
      Top = 4
      Width = 90
      Height = 20
      Caption = '[F10] &Alterar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
        CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
        A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
        820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
        860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
        C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
        D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
        9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnCalcular: TBitBtnLocked
      Left = 5
      Top = 4
      Width = 82
      Height = 20
      Caption = '[ F3 ] Calcular'
      TabOrder = 0
      OnClick = btnCalcularClick
    end
  end
  object rdgStatus: TRadioGroup [7]
    Left = 6
    Top = 68
    Width = 355
    Height = 54
    Caption = 'Status'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      'Ativo'
      'Inativo'
      'Todos')
    TabOrder = 1
    OnClick = rdgStatusClick
  end
  object rdgInfo: TRadioGroup [8]
    Left = 6
    Top = 1
    Width = 355
    Height = 67
    Caption = 'Informa'#231#227'o a alterar'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Pre'#231'o de Custo'
      'Saldo de Estoque'
      'Ambos')
    TabOrder = 0
    WordWrap = True
    OnClick = rdgInfoClick
  end
  object edtFator: TEditFocus [9]
    Tag = 99
    Left = 241
    Top = 273
    Width = 100
    Height = 22
    Alignment = taRightJustify
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.000000'
  end
  object edtTotInv: TEditFocus [10]
    Left = 241
    Top = 321
    Width = 100
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 10
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskLinGru: TMaskEditFocus [11]
    Left = 6
    Top = 137
    Width = 55
    Height = 22
    EditMask = '999.999;0;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 7
    ParentFont = False
    TabOrder = 2
    Text = ''
    OnChange = mskLinGruChange
    OnExit = mskLinGruExit
    OnKeyPress = mskLinGruKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtDesGru: TEditFocus [12]
    Left = 65
    Top = 137
    Width = 296
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object rdgSaldos: TRadioGroup [13]
    Left = 6
    Top = 196
    Width = 355
    Height = 49
    Caption = 'Saldo'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      'Positivo'
      'Negativo'
      'Todos')
    TabOrder = 6
    OnClick = rdgStatusClick
  end
  object edtParInv: TEditFocus [14]
    Left = 241
    Top = 297
    Width = 100
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 9
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 378
    Width = 373
    TabOrder = 12
    ExplicitTop = 378
    ExplicitWidth = 373
    inherited pnlNomeForm: TPanel
      Left = 202
      ExplicitLeft = 202
    end
    inherited pnlInfo: TPanel
      Width = 202
      ExplicitWidth = 202
      object shpMultSel: TShape
        Left = 184
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 182
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object chkArrendondarSaldo: TCheckBox [16]
    Left = 4
    Top = 247
    Width = 363
    Height = 26
    Caption = 
      'Arredondar quantidade considerando Item Fracionado do Cad.Unidad' +
      'es'
    Checked = True
    State = cbChecked
    TabOrder = 7
    Visible = False
    WordWrap = True
  end
  object edtDesAbf: TEditFocus [17]
    Left = 65
    Top = 175
    Width = 296
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    TabOrder = 5
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodAbf: TEditFocus [18]
    Tag = 99
    Left = 6
    Top = 175
    Width = 55
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 4
    OnKeyPress = edtCodAbfKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object btnCalcFator: TBitBtnLocked [19]
    Left = 341
    Top = 272
    Width = 22
    Height = 22
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0001000000040000000700000005000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000020000
      00063D29238F714C43FF311F1A8F000000070000000200000001000000060000
      00090000000A0000000A0000000A0000000A0000000A0D09072C2016135C2519
      156B715045F3C2B0A7FF5E3F35F3231713671D1310570B070625704A3EBD9A66
      56FF9A6654FF9A6554FF996554FF996453FFBD9C90FF8B6D62FF987F76FF8467
      5DFFBFAEA4FFE2D9D2FFC6B7B1FF7D5F56FF896D63FF472F28B9B78877FFF8F2
      EEFFF7EFE9FFF6EFE9FFF7EEE9FFF6EEE9FFFBF7F4FFBAA8A2FFA48A80FFECE7
      E3FFBDA69CFF9E7E70FFC3AFA6FFEAE2DEFF997C72FF38282479B88979FFF8F3
      EFFFC2917FFFC0917EFFF7EFEAFFBF8F7DFFDFC7BEFFD5BDB4FF8D6C5EFFEAE4
      E0FF8B6B5FFFB79D93FF8B6B60FFE7DFD9FF765549FC00000008B88A7AFFF9F3
      EFFFCBA190FFC79A89FFF6EFEAFFCB9F8EFFE3CCC3FFC8B6AFFFAC9388FFEFEA
      E6FFB19E98FF755349FFAC978FFFE9E1DCFFA1887EFF3A2A257ABA8C7CFFF9F4
      F1FFF7EFEBFFF7F0EBFFF7EFEAFFF7EFEAFFFBF7F5FFAF978BFFB1998EFFA487
      7AFFD9CDC7FFF6F3F1FFD4C5BEFFA4877AFFB1998EFF675045B6BA8D7DFFF9F5
      F2FFC79B8DFFC79B8CFFF7F0EBFFC69A8AFFDABDB4FFEDE5E2FFDBCDC8FFD1C4
      BEFFA28274FFE2D8D2FF9B796CFF3127225D30252151120E0C21BC8D7EFFFAF5
      F2FFD1AB9CFFCDA496FFF7F1ECFFD1A89BFFD0A89BFFF8F2EEFFF8F2EFFFEDE9
      E8FFCDB9B0FFA28273FFBCA095FF0000000E0000000000000000BC8F80FFFAF6
      F3FFF7F1ECFFF7F1EDFFF7F0EDFFF7F0ECFFF8F0ECFFF7F0ECFFF7F0ECFFFBF8
      F5FFFCF8F5FFDCC5BCFF00000006000000000000000000000000BE9081FFFAF6
      F4FFD29857FFE4BC87FFE3BB85FFE3BB85FFE3BA84FFE3B984FFE2B982FFCF92
      52FFF8F1ECFFB98B7BFF00000006000000000000000000000000BF9182FFFAF7
      F4FFE0B277FFF0D4ABFFF2D9B3FFF2DAB4FFF2DAB3FFF2D9B1FFEED2A9FFDEAD
      71FFF7F1ECFFBA8C7BFF00000005000000000000000000000000BF9283FFFAF7
      F5FFE2B071FFE2B071FFE2B070FFE0B070FFE0AF70FFE0AF6EFFE0AF6EFFE0AC
      6CFFF8F1EDFFBB8D7DFF00000005000000000000000000000000C09485FFFCF8
      F6FFFCF8F6FFFBF7F6FFFBF7F5FFFAF7F5FFFBF7F4FFFBF7F4FFFAF7F4FFFAF7
      F4FFFBF7F4FFBC8E7EFF000000040000000000000000000000009B8175BFD1AE
      9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE
      9EFFD1AE9EFF9B8175BF00000002000000000000000000000000}
    TabOrder = 14
    TabStop = False
    OnClick = btnCalcFatorClick
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 206
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
  end
end
