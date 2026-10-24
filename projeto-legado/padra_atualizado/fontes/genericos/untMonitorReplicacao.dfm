inherited frmMonitorReplicacao: TfrmMonitorReplicacao
  Width = 1093
  Height = 442
  Caption = 'Monitor Replica'#231#227'o'
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 1093
  ExplicitHeight = 442
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 369
    Width = 1087
    Color = clSilver
    ExplicitTop = 369
    ExplicitWidth = 1087
    object Label1: TLabel [0]
      Left = 8
      Top = 8
      Width = 173
      Height = 15
      Caption = 'Tempo para atualiza'#231#227'o (seg.):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel [1]
      Left = 398
      Top = 7
      Width = 52
      Height = 14
      Caption = 'Conectado'
    end
    object Shape4: TShape [2]
      Left = 382
      Top = 5
      Width = 15
      Height = 15
      Brush.Color = clGreen
    end
    object Label3: TLabel [3]
      Left = 291
      Top = 7
      Width = 66
      Height = 14
      Caption = 'Sem conex'#227'o'
    end
    object Shape3: TShape [4]
      Left = 275
      Top = 5
      Width = 15
      Height = 15
      Brush.Color = clGray
    end
    object shp1: TShape [5]
      Left = 558
      Top = 7
      Width = 15
      Height = 15
      Brush.Color = clYellow
    end
    object lbl1: TLabel [6]
      Left = 574
      Top = 8
      Width = 150
      Height = 14
      Caption = 'Executa / Gera / Envia parados'
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1006
    end
    inherited btnSair: TBitBtnLocked
      Left = 1008
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 1004
    end
    object edtTmpAtu: TcxSpinEdit
      Left = 188
      Top = 2
      Properties.MaxValue = 9999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 1
      Value = 5
      OnExit = edtTmpAtuExit
      OnKeyDown = edtTmpAtuKeyDown
      Width = 66
    end
  end
  object dbgEmpresas: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1087
    Height = 369
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgEmpresasDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsEmpresas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object EMP_CODEMP: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'EMP_CODEMP'
        Width = 53
      end
      object EMP_NOMEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMP_NOMEMP'
        Width = 198
      end
      object EMP_STAEXE: TcxGridDBColumn
        Caption = 'Executa'
        DataBinding.FieldName = 'EMP_STAEXE'
        OnCustomDrawCell = EMP_STAEXECustomDrawCell
        Width = 54
      end
      object EMP_STAGER: TcxGridDBColumn
        Caption = 'Gera'
        DataBinding.FieldName = 'EMP_STAGER'
        OnCustomDrawCell = EMP_STAEXECustomDrawCell
        Width = 53
      end
      object EMP_STAENV: TcxGridDBColumn
        Caption = 'Envia'
        DataBinding.FieldName = 'EMP_STAENV'
        OnCustomDrawCell = EMP_STAEXECustomDrawCell
        Width = 54
      end
      object EMP_STACON: TcxGridDBColumn
        Caption = 'Conex'#227'o'
        DataBinding.FieldName = 'EMP_STACON'
        OnCustomDrawCell = EMP_STACONCustomDrawCell
        Width = 54
      end
      object EMP_QTDREP: TcxGridDBColumn
        Caption = 'Qtd. LogRep'
        DataBinding.FieldName = 'EMP_QTDREP'
        Width = 74
      end
      object EMP_QTDEXE: TcxGridDBColumn
        Caption = 'Qtd. LogExe'
        DataBinding.FieldName = 'EMP_QTDEXE'
        Width = 67
      end
      object dbgEmpresasDBTableView1Column1: TcxGridDBColumn
        Caption = 'Erro de Conex'#227'o'
        DataBinding.FieldName = 'EMP_MOTCON'
        Width = 478
      end
    end
    object dbgEmpresasLevel1: TcxGridLevel
      GridView = dbgEmpresasDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 397
    Width = 1087
    ExplicitTop = 397
    ExplicitWidth = 1087
    inherited pnlNomeForm: TPanel
      Left = 916
      ExplicitLeft = 916
    end
    inherited pnlInfo: TPanel
      Width = 916
      ExplicitWidth = 916
    end
  end
  object cdsEmpresas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 192
    object cdsEmpresasEMP_CODEMP: TStringField
      FieldName = 'EMP_CODEMP'
      Size = 3
    end
    object cdsEmpresasEMP_NOMEMP: TStringField
      FieldName = 'EMP_NOMEMP'
      Size = 50
    end
    object cdsEmpresasEMP_NUM_IP: TStringField
      FieldName = 'EMP_NUM_IP'
      Size = 50
    end
    object cdsEmpresasEMP_STAEXE: TIntegerField
      FieldName = 'EMP_STAEXE'
    end
    object cdsEmpresasEMP_STAGER: TIntegerField
      FieldName = 'EMP_STAGER'
    end
    object cdsEmpresasEMP_STAENV: TIntegerField
      FieldName = 'EMP_STAENV'
    end
    object cdsEmpresasEMP_STACON: TIntegerField
      FieldName = 'EMP_STACON'
    end
    object cdsEmpresasEMP_QTDREP: TIntegerField
      FieldName = 'EMP_QTDREP'
    end
    object cdsEmpresasEMP_QTDEXE: TIntegerField
      FieldName = 'EMP_QTDEXE'
    end
    object strngfldEmpresasEMP_MOTCON: TStringField
      DisplayWidth = 100
      FieldName = 'EMP_MOTCON'
      Size = 100
    end
    object cdsEmpresasEMP_NUMPOR: TIntegerField
      FieldName = 'EMP_NUMPOR'
    end
  end
  object dtsEmpresas: TDataSource
    DataSet = cdsEmpresas
    Left = 128
    Top = 192
  end
  object tmrAtualizaTela: TTimer
    Enabled = False
    OnTimer = tmrAtualizaTelaTimer
    Left = 184
    Top = 192
  end
  object cxEditRepository1: TcxEditRepository
    Left = 280
    Top = 192
    PixelsPerInch = 96
  end
end
