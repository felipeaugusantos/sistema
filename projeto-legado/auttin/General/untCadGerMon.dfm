inherited frmCadGerMon: TfrmCadGerMon
  Left = 276
  Top = 343
  Width = 534
  Height = 138
  Caption = 'Cadastro de Montadoras - General'
  ExplicitWidth = 534
  ExplicitHeight = 138
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 66
    Width = 528
    ExplicitTop = 66
    ExplicitWidth = 528
    DesignSize = (
      528
      28)
    inherited btnSair: TBitBtnLocked
      Left = 451
      ExplicitLeft = 451
    end
  end
  inherited pnlStatus: TPanel
    Top = 94
    Width = 528
    ExplicitTop = 94
    ExplicitWidth = 528
    inherited pnlNomeForm: TPanel
      Left = 181
      ExplicitLeft = 181
    end
    inherited pnlInfo: TPanel
      Width = 181
      ExplicitWidth = 181
    end
  end
  inherited pgcDados: TPageControl
    Width = 528
    Height = 66
    ExplicitWidth = 528
    ExplicitHeight = 66
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 520
      ExplicitHeight = 34
    end
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 528
    Height = 66
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    object Label2: TLabel
      Left = 12
      Top = 35
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label1: TLabel
      Left = 124
      Top = 35
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 528
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Montadoras - General'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object dbeCodigo: TDBEditFocus
      Left = 56
      Top = 32
      Width = 57
      Height = 20
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Left = 184
      Top = 32
      Width = 337
      Height = 20
      CharCase = ecUpperCase
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
    Left = 376
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 24
  end
end
