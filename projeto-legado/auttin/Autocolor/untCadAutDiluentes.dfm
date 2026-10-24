inherited frmCadAutDiluentes: TfrmCadAutDiluentes
  Left = 281
  Top = 220
  Width = 550
  Height = 153
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Diluentes - Autocolor Automotiva'
  OnDestroy = FormDestroy
  ExplicitWidth = 550
  ExplicitHeight = 153
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 85
    Width = 544
    ExplicitTop = 85
    ExplicitWidth = 544
    inherited btnSair: TBitBtnLocked
      Left = 467
      ExplicitLeft = 467
    end
  end
  inherited pnlStatus: TPanel
    Top = 113
    Width = 544
    ExplicitTop = 113
    ExplicitWidth = 544
    inherited pnlNomeForm: TPanel
      Left = 197
      ExplicitLeft = 197
    end
    inherited pnlInfo: TPanel
      Width = 197
      ExplicitWidth = 197
    end
  end
  inherited pgcDados: TPageControl
    Width = 544
    Height = 85
    ExplicitWidth = 544
    ExplicitHeight = 85
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 536
      ExplicitHeight = 53
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 544
    Height = 85
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 28
      Top = 36
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha:'
    end
    object Label2: TLabel
      Left = 160
      Top = 36
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Diluente:'
    end
    object Label3: TLabel
      Left = 292
      Top = 36
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Min%:'
    end
    object Label4: TLabel
      Left = 416
      Top = 36
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Max%:'
    end
    object Label5: TLabel
      Left = 5
      Top = 60
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeSistemas: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 32
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 0
      OnKeyPress = dbeSistemasKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDiluente: TDBEditFocus
      Tag = 99
      Left = 208
      Top = 32
      Width = 81
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyPress = dbeDiluenteKeyPress
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
      Width = 544
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Diluentes - Autocolor Automotiva'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object dbeMin: TDBEditFocus
      Tag = 99
      Left = 328
      Top = 31
      Width = 81
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMax: TDBEditFocus
      Tag = 99
      Left = 456
      Top = 31
      Width = 81
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 4
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
      Top = 56
      Width = 473
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 208
  end
end
