inherited frmCadCotacaoMoeda: TfrmCadCotacaoMoeda
  Left = 320
  Top = 343
  Width = 525
  Height = 275
  Caption = 'Cadastro de Cota'#231#245'es de Moedas'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 525
  ExplicitHeight = 275
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 205
    Width = 519
    Height = 25
    ExplicitTop = 205
    ExplicitWidth = 519
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 515
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 515
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 448
      Width = 68
      Height = 20
      ExplicitLeft = 448
      ExplicitWidth = 68
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 205
    ExplicitWidth = 519
    ExplicitHeight = 202
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 170
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 205
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 202
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 515
      Height = 45
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 15
        Top = 19
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data:'
      end
      object dbeDtaMoe: TDBEditFocus
        Tag = 99
        Left = 49
        Top = 12
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_DTAMOE'
        DataSource = dtsCadMoe
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 47
      Width = 515
      Height = 156
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      ExplicitHeight = 153
      object Label4: TLabel
        Left = 15
        Top = 45
        Width = 20
        Height = 14
        Caption = 'US$'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblMoeda: TLabel
        Left = 15
        Top = 71
        Width = 13
        Height = 14
        Caption = 'R$'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 15
        Top = 124
        Width = 12
        Height = 14
        Caption = 'P$'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 15
        Top = 97
        Width = 12
        Height = 14
        Caption = 'E$'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 15
        Top = 12
        Width = 39
        Height = 14
        Caption = 'MOEDA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 100
        Top = 12
        Width = 48
        Height = 14
        Caption = 'COMPRA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 216
        Top = 12
        Width = 36
        Height = 14
        Caption = 'VENDA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbeDolCom: TDBEditFocus
        Tag = 99
        Left = 100
        Top = 39
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_DOLCOM'
        DataSource = dtsCadMoe
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeDolVen: TDBEditFocus
        Tag = 99
        Left = 216
        Top = 39
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_DOLVEN'
        DataSource = dtsCadMoe
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeReaCom: TDBEditFocus
        Tag = 99
        Left = 100
        Top = 65
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_REACOM'
        DataSource = dtsCadMoe
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeReaVen: TDBEditFocus
        Tag = 99
        Left = 216
        Top = 65
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_REAVEN'
        DataSource = dtsCadMoe
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeParCom: TDBEditFocus
        Tag = 99
        Left = 100
        Top = 118
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_PARCOM'
        DataSource = dtsCadMoe
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeParVen: TDBEditFocus
        Tag = 99
        Left = 216
        Top = 118
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_PARVEN'
        DataSource = dtsCadMoe
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeEurVen: TDBEditFocus
        Tag = 99
        Left = 216
        Top = 91
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_EURVEN'
        DataSource = dtsCadMoe
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeEurCom: TDBEditFocus
        Tag = 99
        Left = 100
        Top = 91
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MOE_EURCOM'
        DataSource = dtsCadMoe
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object Panel3: TPanel
        Left = 0
        Top = 29
        Width = 512
        Height = 2
        Color = 16770261
        TabOrder = 8
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 230
    Width = 519
    ExplicitTop = 230
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 328
      Width = 191
      ExplicitLeft = 328
      ExplicitWidth = 191
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 172
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 8
  end
  object dtsCadMoe: TDataSource
    Left = 384
    Top = 88
  end
end
