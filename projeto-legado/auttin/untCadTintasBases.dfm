inherited frmCadTintasBases: TfrmCadTintasBases
  Left = 367
  Top = 386
  Width = 536
  Height = 213
  Caption = 'frmCadTintasBases'
  Position = poScreenCenter
  ExplicitWidth = 536
  ExplicitHeight = 213
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 141
    Width = 530
    TabOrder = 2
    ExplicitTop = 141
    ExplicitWidth = 530
    DesignSize = (
      530
      28)
    inherited btnSair: TBitBtnLocked
      Left = 453
      ExplicitLeft = 453
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 169
    Width = 530
    TabOrder = 3
    ExplicitTop = 169
    ExplicitWidth = 530
    inherited pnlNomeForm: TPanel
      Left = 183
      TabOrder = 1
      ExplicitLeft = 183
    end
    inherited pnlInfo: TPanel
      Width = 183
      TabOrder = 0
      ExplicitWidth = 183
    end
  end
  inherited pgcDados: TPageControl
    Width = 530
    Height = 141
    TabOrder = 0
    ExplicitWidth = 530
    ExplicitHeight = 141
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 522
      ExplicitHeight = 109
    end
  end
  inherited pnlCampos: TPanel
    Width = 530
    Height = 141
    TabOrder = 1
    ExplicitWidth = 530
    ExplicitHeight = 141
    object lblCodigo: TLabel
      Left = 32
      Top = 20
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblBase: TLabel
      Left = 176
      Top = 20
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object lblDescricao: TLabel
      Left = 16
      Top = 62
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblItemBase: TLabel
      Left = 46
      Top = 86
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object lblCodUni: TLabel
      Left = 26
      Top = 42
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object lblPrecoCusto: TLabel
      Left = 37
      Top = 108
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Custo:'
    end
    object lblPrecoVenda: TLabel
      Left = 345
      Top = 108
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Venda:'
    end
    object lblMargem: TLabel
      Left = 183
      Top = 108
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem:'
    end
    object btnRestPreco: TSpeedButton
      Left = 502
      Top = 86
      Width = 23
      Height = 20
      Hint = 'Restaura dados do produto'
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
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnRestPrecoClick
    end
    object lblEmbalagem: TLabel
      Left = 314
      Top = 20
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
      Visible = False
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 208
      Top = 16
      Width = 97
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 1
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 16
      Width = 97
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 0
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 60
      Width = 409
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 5
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeItemBase: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 82
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 6
      OnEnter = dbeEnterFocus
      OnExit = dbeItemBaseExit
      OnKeyPress = dbeItemBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCodUni: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 38
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 2
      OnEnter = dbeEnterFocus
      OnExit = dbeItemBaseExit
      OnKeyPress = dbeCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePrecoCusto: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 104
      Width = 97
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 8
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePrecoVenda: TDBEditFocus
      Tag = 99
      Left = 384
      Top = 104
      Width = 97
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 10
      OnEnter = dbeEnterFocus
      OnExit = dbePrecoVendaExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMargem: TDBEditFocus
      Tag = 99
      Left = 228
      Top = 104
      Width = 97
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 9
      OnEnter = dbeEnterFocus
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesItemBase: TEditFocus
      Left = 121
      Top = 82
      Width = 360
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesUni: TEditFocus
      Left = 121
      Top = 38
      Width = 320
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSigUni: TEditFocus
      Left = 432
      Top = 38
      Width = 49
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbala: TDBEditFocus
      Tag = 99
      Left = 373
      Top = 16
      Width = 108
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 11
      OnEnter = dbeEnterFocus
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 503
    Top = 84
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 65532
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 88
  end
end
