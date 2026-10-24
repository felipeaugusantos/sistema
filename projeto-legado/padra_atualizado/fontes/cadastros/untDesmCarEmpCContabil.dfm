inherited frmDesmCarEmpCContabil: TfrmDesmCarEmpCContabil
  Width = 561
  Height = 425
  Caption = 'Desmembramento'
  ExplicitWidth = 561
  ExplicitHeight = 425
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 355
    Width = 555
    Height = 25
    ExplicitTop = 355
    ExplicitWidth = 555
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 551
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 551
      inherited btnIncluir: TBitBtnLocked
        Width = 78
        ExplicitWidth = 78
      end
      inherited btnGravar: TBitBtnLocked
        Left = 78
        Width = 78
        ExplicitLeft = 78
        ExplicitWidth = 78
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 156
        Width = 78
        ExplicitLeft = 156
        ExplicitWidth = 78
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 234
        Width = 78
        ExplicitLeft = 234
        ExplicitWidth = 78
      end
      inherited btnCancela: TBitBtnLocked
        Left = 312
        Width = 78
        ExplicitLeft = 312
        ExplicitWidth = 78
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 390
        Width = 78
        Visible = False
        ExplicitLeft = 390
        ExplicitWidth = 78
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 470
      Width = 75
      Height = 20
      ExplicitLeft = 470
      ExplicitWidth = 75
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
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
    Width = 555
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
      DataField = 'CCC_CODEMP'
      DataSource = dtsEmpCar
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
      DataField = 'CCC_CONCON'
      DataSource = dtsEmpCar
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 135
      Top = 11
      Width = 316
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
  object dbgCarEmp: TDBGridCitel [4]
    Left = 0
    Top = 65
    Width = 555
    Height = 290
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
    OnKeyPress = dbgCarEmpKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CCC_CODEMP'
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
        FieldName = 'CCC_CONCON'
        Title.Caption = 'Conta Cont'#225'bil'
        Width = 135
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 380
    Width = 555
    ExplicitTop = 380
    ExplicitWidth = 555
    inherited pnlNomeForm: TPanel
      Left = 384
      Width = 171
      ExplicitLeft = 384
      ExplicitWidth = 171
    end
    inherited pnlInfo: TPanel
      Width = 384
      ExplicitWidth = 208
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 123
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 93
  end
  object dtsEmpCar: TDataSource
    Left = 466
    Top = 9
  end
  object dtsAux: TDataSource
    DataSet = cdsAux
    Left = 399
    Top = 147
  end
  object cdsAux: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 148
    object cdsAuxCCC_CODEMP: TStringField
      FieldName = 'CCC_CODEMP'
    end
    object cdsAuxEMP_NOMEMP: TStringField
      FieldName = 'EMP_NOMEMP'
      Size = 100
    end
    object cdsAuxCCC_CONCON: TStringField
      FieldName = 'CCC_CONCON'
    end
    object cdsAuxAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
end
