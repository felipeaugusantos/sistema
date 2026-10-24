inherited frmConfOrdProdFiltros: TfrmConfOrdProdFiltros
  Width = 425
  Height = 321
  BorderIcons = [biSystemMenu]
  Caption = 'Confer'#234'ncia de Ordem de Produ'#231#227'o - Filtros'
  Position = poMainFormCenter
  ExplicitWidth = 425
  ExplicitHeight = 321
  PixelsPerInch = 96
  TextHeight = 14
  object lblCodBar: TLabel [0]
    Left = 8
    Top = 8
    Width = 198
    Height = 14
    Caption = 'C'#243'digo de Barras da Ordem de Produ'#231#227'o'
  end
  object lblDtaCad: TLabel [1]
    Left = 8
    Top = 56
    Width = 84
    Height = 14
    Caption = 'Data de Cadastro'
  end
  object lblCodIte: TLabel [2]
    Left = 8
    Top = 104
    Width = 73
    Height = 14
    Caption = 'C'#243'digo do Item '
  end
  object lblCodCor: TLabel [3]
    Left = 8
    Top = 152
    Width = 71
    Height = 14
    Caption = 'C'#243'digo da Cor '
  end
  object lblPedRes: TLabel [4]
    Left = 8
    Top = 200
    Width = 158
    Height = 14
    Caption = 'Pedido da Reserva Mat'#233'ria Prima'
  end
  inherited pnlBotoes: TPanel
    Top = 249
    Width = 419
    TabOrder = 7
    ExplicitTop = 249
    ExplicitWidth = 419
    inherited btnSair: TBitBtnLocked
      Left = 336
      TabOrder = 1
      ExplicitLeft = 336
    end
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 84
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Confirma'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000002000000070000000C0000001000000012000000110000
        000E000000080000000200000000000000000000000000000000000000000000
        000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
        3AD20F2F21840001011500000005000000010000000000000000000000000000
        0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
        80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
        0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
        96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
        3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
        99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
        66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
        A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
        8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
        A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
        A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
        4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
        B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
        8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
        BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
        E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
        B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
        76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
        7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
        7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
        46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
        C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
        0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
        DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
        0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
        C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
        000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
        56B00E3226560000000600000002000000000000000000000000}
      TabOrder = 0
      OnClick = btnSairClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 277
    Width = 419
    TabOrder = 8
    ExplicitTop = 277
    ExplicitWidth = 419
    inherited pnlNomeForm: TPanel
      Left = 248
      ExplicitLeft = 248
    end
    inherited pnlInfo: TPanel
      Width = 248
      ExplicitWidth = 248
      object shpMultSel: TShape
        Left = 230
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 232
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object edtCodBar: TEditFocus [8]
    Left = 8
    Top = 24
    Width = 121
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 13
    TabOrder = 0
    OnExit = edtCodBarExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 13
    TipoTexto = ttNumerico
  end
  object mskDtaCad: TMaskEditFocus [9]
    Left = 8
    Top = 72
    Width = 121
    Height = 22
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtCodCor: TEditFocus [10]
    Tag = 99
    Left = 8
    Top = 168
    Width = 64
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 4
    TabOrder = 4
    OnExit = edtCodCorExit
    OnKeyPress = edtCodCorKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 4
    TipoTexto = ttNumerico
  end
  object edtDesCor: TEditFocus [11]
    Left = 73
    Top = 168
    Width = 340
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ReadOnly = True
    TabOrder = 5
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodIte: TEditFocus [12]
    Tag = 99
    Left = 7
    Top = 120
    Width = 65
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    ParentFont = False
    TabOrder = 2
    OnExit = edtCodIteExit
    OnKeyPress = edtCodIteKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesIte: TEditFocus [13]
    Left = 73
    Top = 120
    Width = 340
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtPedRes: TEditFocus [14]
    Tag = 99
    Left = 8
    Top = 216
    Width = 121
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 12
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 12
    TipoTexto = ttNumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 784
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 736
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 664
    Top = 152
  end
end
