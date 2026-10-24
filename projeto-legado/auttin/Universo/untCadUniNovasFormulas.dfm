inherited frmCadUniNovasFormulas: TfrmCadUniNovasFormulas
  Left = 276
  Top = 237
  Width = 693
  Height = 264
  Caption = 'Cadastro de Novas F'#243'rmulas - Universo'
  ExplicitWidth = 693
  ExplicitHeight = 264
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 192
    Width = 687
    TabOrder = 2
    ExplicitTop = 192
    ExplicitWidth = 687
    DesignSize = (
      687
      28)
    inherited btnSair: TBitBtnLocked
      Left = 610
      ExplicitLeft = 610
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    Width = 687
    Height = 192
    TabOrder = 0
    ExplicitWidth = 687
    ExplicitHeight = 192
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 679
      ExplicitHeight = 160
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 687
    Height = 192
    Align = alClient
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Label3: TLabel
      Left = 32
      Top = 113
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object Label4: TLabel
      Left = 18
      Top = 91
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label5: TLabel
      Left = 395
      Top = 36
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label6: TLabel
      Left = 530
      Top = 36
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label9: TLabel
      Left = 395
      Top = 84
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label8: TLabel
      Left = 530
      Top = 60
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label7: TLabel
      Left = 395
      Top = 60
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label16: TLabel
      Left = 530
      Top = 156
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label15: TLabel
      Left = 395
      Top = 156
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label14: TLabel
      Left = 530
      Top = 132
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label13: TLabel
      Left = 395
      Top = 132
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label12: TLabel
      Left = 530
      Top = 108
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label11: TLabel
      Left = 395
      Top = 108
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Colorante:'
    end
    object Label10: TLabel
      Left = 530
      Top = 84
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label17: TLabel
      Left = 24
      Top = 68
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblInformacao: TLabel
      Left = 472
      Top = 176
      Width = 193
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cadastrar F'#243'rmulas para 810 ml (Shots)'
    end
    object lblDescri: TLabel
      Left = 8
      Top = 134
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblProdut: TLabel
      Left = 108
      Top = 113
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label28: TLabel
      Left = 183
      Top = 68
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object dbeBase1: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 109
      Width = 41
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODBAS'
      TabOrder = 2
      OnKeyPress = dbeBase1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnidade: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 87
      Width = 73
      Height = 20
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_CODUNI'
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm01: TDBEditFocus
      Tag = 99
      Left = 448
      Top = 32
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODC01'
      TabOrder = 5
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtd01: TDBEditFocus
      Tag = 99
      Left = 592
      Top = 32
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_QTDC01'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtd03: TDBEditFocus
      Tag = 99
      Left = 592
      Top = 80
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_QTDC03'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm03: TDBEditFocus
      Tag = 99
      Left = 448
      Top = 80
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODC03'
      TabOrder = 9
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtd02: TDBEditFocus
      Tag = 99
      Left = 592
      Top = 56
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_QTDC02'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm02: TDBEditFocus
      Tag = 99
      Left = 448
      Top = 56
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODC02'
      TabOrder = 7
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtd06: TDBEditFocus
      Tag = 99
      Left = 592
      Top = 152
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_QTDC06'
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm06: TDBEditFocus
      Tag = 99
      Left = 448
      Top = 152
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODC06'
      TabOrder = 15
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtd05: TDBEditFocus
      Tag = 99
      Left = 592
      Top = 128
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_QTDC05'
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm05: TDBEditFocus
      Tag = 99
      Left = 448
      Top = 128
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODC05'
      TabOrder = 13
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtd04: TDBEditFocus
      Tag = 99
      Left = 592
      Top = 104
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_QTDC04'
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeForm04: TDBEditFocus
      Tag = 99
      Left = 448
      Top = 104
      Width = 73
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODC04'
      TabOrder = 11
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 64
      Width = 73
      Height = 20
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 133
      Width = 281
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_DESCOR'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeProdut: TDBEditFocus
      Tag = 99
      Left = 152
      Top = 109
      Width = 193
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_PRODUT'
      TabOrder = 3
      OnKeyPress = dbeBase1KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 685
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Universo'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 17
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 260
      Top = 64
      Width = 85
      Height = 20
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 18
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 220
    Width = 687
    TabOrder = 3
    ExplicitTop = 220
    ExplicitWidth = 687
    inherited pnlNomeForm: TPanel
      Left = 340
      TabOrder = 1
      ExplicitLeft = 340
    end
    inherited pnlInfo: TPanel
      Width = 340
      TabOrder = 0
      ExplicitWidth = 340
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 128
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 192
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 136
  end
end
