inherited frmFatConfPedidosItens: TfrmFatConfPedidosItens
  Left = 259
  Top = 240
  Width = 872
  Height = 496
  Caption = 'Confirma'#231#227'o de Pedidos - Itens'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnClose = FormClose
  ExplicitWidth = 872
  ExplicitHeight = 496
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 425
    Width = 866
    Height = 26
    ExplicitTop = 425
    ExplicitWidth = 866
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 260
      Width = 527
      Height = 22
      TabOrder = 3
      ExplicitLeft = 260
      ExplicitWidth = 527
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 787
      Top = 2
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 787
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 129
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnAltValUni: TBitBtnLocked
      Left = 131
      Top = 2
      Width = 129
      Height = 22
      Align = alLeft
      Caption = '[ F4 ] Altera valor unit'#225'rio'
      TabOrder = 1
      OnClick = btnAltValUniClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 451
    Width = 866
    ExplicitTop = 451
    ExplicitWidth = 866
    inherited pnlNomeForm: TPanel
      Left = 695
      ExplicitLeft = 695
    end
    inherited pnlInfo: TPanel
      Width = 695
      ExplicitWidth = 695
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 866
    Height = 59
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 45
      Top = 16
      Width = 22
      Height = 14
      Caption = 'Item:'
    end
    object Label9: TLabel
      Left = 10
      Top = 35
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object lblValUni: TLabel
      Left = 153
      Top = 35
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor unit'#225'rio:'
    end
    object lblNumLot: TLabel
      Left = 306
      Top = 35
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'Lote:'
      Visible = False
    end
    object edtDesIte: TEditFocus
      Left = 70
      Top = 6
      Width = 623
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 70
      Top = 32
      Width = 77
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object btnAdicionar: TBitBtnLocked
      Left = 470
      Top = 32
      Width = 111
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 4
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 582
      Top = 32
      Width = 111
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 5
      OnClick = btnCancelaItemClick
    end
    object edtValUni: TEditFocus
      Tag = 99
      Left = 221
      Top = 32
      Width = 77
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnEnter = edtValUniEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.0000'
    end
    object edtNumLot: TEditFocus
      Left = 334
      Top = 32
      Width = 125
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 30
      TabOrder = 3
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgItens: TDBGridCitel [3]
    Left = 0
    Top = 59
    Width = 866
    Height = 333
    Align = alClient
    DataSource = dtsDados
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnDblClick = dbgItensDblClick
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_NUMORC'
        Title.Caption = 'Pedido'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_ESPORC'
        Title.Caption = 'Esp.'
        Width = 25
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_EMPORC'
        Title.Caption = 'Emp.'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SEQIND'
        Title.Alignment = taRightJustify
        Title.Caption = 'N'#186
        Width = 21
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 215
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_NUMLOT'
        Title.Caption = 'Lote'
        Width = 92
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_SALDOS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo'
        Width = 85
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtde.'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_UNITAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Unit'#225'rio'
        Width = 85
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total'
        Width = 85
        Visible = True
      end>
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 392
    Width = 866
    Height = 33
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label32: TLabel
      Left = 680
      Top = 11
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total dos Itens:'
    end
    object lblFatCor: TLabel
      Left = 46
      Top = 11
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fator de corre'#231#227'o:'
      Visible = False
    end
    object edtFatCor: TEditFocus
      Tag = 99
      Left = 138
      Top = 5
      Width = 77
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      Visible = False
      OnEnter = edtFatCorEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object dbeTotGer: TDBEditFocus
      Left = 753
      Top = 5
      Width = 80
      Height = 22
      Color = 16768952
      DataField = 'TOT_TOTITE'
      DataSource = dtsDados
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 136
  end
  object dtsDados: TDataSource
    Left = 416
    Top = 136
  end
end
