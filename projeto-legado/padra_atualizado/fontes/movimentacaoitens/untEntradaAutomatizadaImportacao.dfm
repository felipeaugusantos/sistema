inherited frmEntradaAutomatizadaImportacao: TfrmEntradaAutomatizadaImportacao
  Width = 939
  Height = 512
  Caption = 'Entrada Automatizada Nota de Importa'#231#227'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 939
  ExplicitHeight = 512
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 439
    Width = 933
    ExplicitTop = 439
    ExplicitWidth = 933
    inherited FlwBotoes: TFlowPanel
      Width = 929
      ExplicitTop = 2
      ExplicitWidth = 929
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '[F10] Confirma'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 853
      ExplicitLeft = 853
    end
  end
  inherited pnlStatus: TPanel
    Top = 467
    Width = 933
    ExplicitTop = 467
    ExplicitWidth = 933
    inherited pnlNomeForm: TPanel
      Left = 762
      ExplicitLeft = 762
    end
    inherited pnlInfo: TPanel
      Width = 762
      ExplicitWidth = 762
    end
  end
  object cxgNotas: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 933
    Height = 418
    Align = alClient
    TabOrder = 3
    object cxNotas: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxNotasCustomDrawCell
      DataController.DataSource = dtsNotas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxNotaCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'GER_CODEMP'
        MinWidth = 64
        Options.AutoWidthSizable = False
      end
      object cxNotasNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
        Options.AutoWidthSizable = False
      end
      object cxNotasESPDOC: TcxGridDBColumn
        Caption = 'Especie'
        DataBinding.FieldName = 'GER_ESPDOC'
        MinWidth = 47
        Options.AutoWidthSizable = False
        Width = 47
      end
      object cxNotasSERIE_: TcxGridDBColumn
        Caption = 'Serie'
        DataBinding.FieldName = 'GER_SERIE_'
        MinWidth = 40
        Options.AutoWidthSizable = False
        Width = 40
      end
      object cxNotasCODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. Fornec.'
        DataBinding.FieldName = 'GER_CODFOR'
        Options.AutoWidthSizable = False
        Width = 72
      end
      object cxNotasNUMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Options.AutoWidthSizable = False
        Width = 219
      end
      object cxNotasDTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'GER_DTAENT'
        Options.AutoWidthSizable = False
      end
      object cxNotasSITNOT: TcxGridDBColumn
        Caption = 'Situa'#231#227'o NFe'
        DataBinding.FieldName = 'SITNOT'
        Width = 103
      end
      object cxNotasSITPRE: TcxGridDBColumn
        Caption = 'Situa'#231#227'o Pr'#233'-Nota'
        DataBinding.FieldName = 'SITPRE'
        Width = 110
      end
      object cxNotasCONFER: TcxGridDBColumn
        Caption = 'Confer'#234'ncia'
        DataBinding.FieldName = 'CONFER'
      end
    end
    object cxLNotas: TcxGridLevel
      GridView = cxNotas
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 418
    Width = 933
    Height = 21
    Align = alBottom
    ParentColor = True
    TabOrder = 4
    object Shape1: TShape
      Left = 2
      Top = 3
      Width = 14
      Height = 14
      Brush.Color = clGreen
    end
    object Label1: TLabel
      Left = 22
      Top = 3
      Width = 137
      Height = 14
      Caption = 'Pronto para fazer a entrada.'
    end
    object Shape2: TShape
      Left = 178
      Top = 3
      Width = 14
      Height = 14
      Brush.Color = clRed
    end
    object Label2: TLabel
      Left = 198
      Top = 3
      Width = 139
      Height = 14
      Caption = 'XML ainda n'#227'o foi importado.'
    end
    object shpPreNota: TShape
      Left = 406
      Top = 3
      Width = 14
      Height = 14
      Brush.Color = clFuchsia
    end
    object lblLegendaPrenota: TLabel
      Left = 426
      Top = 3
      Width = 151
      Height = 14
      Caption = 'Pr'#233'-Nota ainda n'#227'o foi definida.'
    end
    object Shape3: TShape
      Left = 590
      Top = 3
      Width = 14
      Height = 14
      Brush.Color = clMaroon
    end
    object Label3: TLabel
      Left = 610
      Top = 3
      Width = 142
      Height = 14
      Caption = 'Confer'#234'ncia n'#227'o foi realizada'
    end
  end
  object dtsNotas: TDataSource
    Left = 336
    Top = 244
  end
end
