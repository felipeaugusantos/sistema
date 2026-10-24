inherited frmCadFarMontadoras: TfrmCadFarMontadoras
  Left = 364
  Top = 236
  Width = 544
  Height = 156
  Caption = 'Cadastro de Montadoras - Farben Automotiva'
  ExplicitWidth = 544
  ExplicitHeight = 156
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl [0]
    Width = 538
    Height = 84
    MultiLine = True
    ExplicitWidth = 538
    ExplicitHeight = 84
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 530
      ExplicitHeight = 52
    end
  end
  inherited pnlBotoes: TPanel [1]
    Top = 84
    Width = 538
    ExplicitTop = 84
    ExplicitWidth = 538
    inherited btnSair: TBitBtnLocked
      Left = 461
      ExplicitLeft = 461
    end
    inherited btnPesquisa: TBitBtnLocked
      Width = 77
      ExplicitWidth = 77
    end
  end
  inherited pnlStatus: TPanel [2]
    Top = 112
    Width = 538
    ExplicitTop = 112
    ExplicitWidth = 538
    inherited pnlNomeForm: TPanel
      Left = 191
      ExplicitLeft = 191
    end
    inherited pnlInfo: TPanel
      Width = 191
      ExplicitWidth = 191
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 538
    Height = 84
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 26
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 8
      Top = 60
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Montadora:'
    end
    object dbeDescri: TDBEditFocus
      Left = 72
      Top = 56
      Width = 281
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMon: TDBEditFocus
      Left = 72
      Top = 32
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 4
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 538
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Montadoras - Farben Automotiva'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 304
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
  end
end
