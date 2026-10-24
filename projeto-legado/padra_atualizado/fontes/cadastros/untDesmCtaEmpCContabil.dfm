inherited frmDesmCtaEmpCContabil: TfrmDesmCtaEmpCContabil
  Width = 564
  Height = 408
  Caption = 'Desmembramento'
  ExplicitWidth = 564
  ExplicitHeight = 408
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 338
    Width = 558
    Height = 25
    ExplicitTop = 338
    ExplicitWidth = 558
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 554
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 554
      inherited btnIncluir: TBitBtnLocked
        Width = 79
        ExplicitWidth = 79
      end
      inherited btnGravar: TBitBtnLocked
        Left = 79
        Width = 79
        ExplicitLeft = 79
        ExplicitWidth = 79
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 158
        Width = 79
        ExplicitLeft = 158
        ExplicitWidth = 79
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 237
        Width = 79
        ExplicitLeft = 237
        ExplicitWidth = 79
      end
      inherited btnCancela: TBitBtnLocked
        Left = 316
        Width = 79
        ExplicitLeft = 316
        ExplicitWidth = 79
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 395
        Width = 79
        Visible = False
        ExplicitLeft = 395
        ExplicitWidth = 79
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 476
      Width = 72
      Height = 20
      ExplicitLeft = 476
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alCustom
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 558
    Height = 65
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label2: TLabel
      Left = 32
      Top = 15
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label3: TLabel
      Left = 5
      Top = 38
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conta Cont'#225'bil:'
    end
    object edtCodEmp: TDBEditFocus
      Tag = 99
      Left = 81
      Top = 11
      Width = 55
      Height = 22
      DataField = 'CTC_CODEMP'
      DataSource = dtsEmpCta
      TabOrder = 0
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtConcon: TDBEditFocus
      Tag = 99
      Left = 81
      Top = 34
      Width = 370
      Height = 22
      DataField = 'CTC_CONCON'
      DataSource = dtsEmpCta
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 136
      Top = 11
      Width = 315
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgCtaEmp: TDBGridCitel [4]
    Left = 0
    Top = 65
    Width = 558
    Height = 273
    TabStop = False
    Align = alClient
    DataSource = dtsAux
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyPress = dbgCtaEmpKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CTC_CODEMP'
        Title.Caption = 'C'#243'd. Emp.'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMP_NOMEMP'
        Title.Caption = 'Empresa'
        Width = 295
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTC_CONCON'
        Title.Caption = 'Conta Cont'#225'bil'
        Width = 135
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 363
    Width = 558
    ExplicitTop = 363
    ExplicitWidth = 558
    inherited pnlNomeForm: TPanel
      Left = 322
      Width = 236
      ExplicitLeft = 322
      ExplicitWidth = 236
    end
    inherited pnlInfo: TPanel
      Width = 322
      ExplicitWidth = 211
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 705
    Top = 63
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 673
    Top = 63
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 104
  end
  object dtsAux: TDataSource
    DataSet = cdsAux
    OnStateChange = dtsAuxStateChange
    Left = 399
    Top = 147
  end
  object dtsEmpCta: TDataSource
    Left = 466
    Top = 9
  end
  object cdsAux: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 363
    Top = 147
    object cdsAuxCTC_CODEMP: TStringField
      FieldName = 'CTC_CODEMP'
    end
    object cdsAuxEMP_NOMEMP: TStringField
      FieldName = 'EMP_NOMEMP'
      Size = 100
    end
    object cdsAuxCTC_CONCON: TStringField
      FieldName = 'CTC_CONCON'
    end
    object cdsAuxAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
end
