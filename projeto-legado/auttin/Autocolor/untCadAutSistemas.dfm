inherited frmCadAutSistemas: TfrmCadAutSistemas
  Left = 281
  Top = 220
  Width = 539
  Height = 128
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Sistemas - Autocolor Automotiva'
  ExplicitWidth = 539
  ExplicitHeight = 128
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 60
    Width = 533
    ExplicitTop = 60
    ExplicitWidth = 533
    inherited btnSair: TBitBtnLocked
      Left = 456
      ExplicitLeft = 456
    end
  end
  inherited pnlStatus: TPanel
    Top = 88
    Width = 533
    ExplicitTop = 88
    ExplicitWidth = 533
    inherited pnlNomeForm: TPanel
      Left = 186
      ExplicitLeft = 186
    end
    inherited pnlInfo: TPanel
      Width = 186
      ExplicitWidth = 186
    end
  end
  inherited pgcDados: TPageControl
    Width = 533
    Height = 60
    ExplicitWidth = 533
    ExplicitHeight = 60
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 525
      ExplicitHeight = 28
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 533
    Height = 60
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 36
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sistema:'
    end
    object Label2: TLabel
      Left = 161
      Top = 36
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Material:'
    end
    object Label3: TLabel
      Left = 298
      Top = 36
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object dbeSistemas: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 32
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinhas: TDBEditFocus
      Tag = 99
      Left = 208
      Top = 32
      Width = 81
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
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 533
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Sistemas - Autocolor Automotiva'
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
    object dbeTipo: TDBEditFocus
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
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 208
  end
end
