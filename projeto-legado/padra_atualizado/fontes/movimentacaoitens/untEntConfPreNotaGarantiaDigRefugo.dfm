inherited frmEntConfPreNotaGarantiaDigRefugo: TfrmEntConfPreNotaGarantiaDigRefugo
  Width = 1024
  Height = 534
  Caption = 
    'Confer'#234'ncia de Entrada de Mercadorias (Pr'#233'-Nota) - Digita'#231#227'o de ' +
    'Refugo'
  OnKeyUp = FormKeyUp
  ExplicitWidth = 1024
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 278
    Width = 1018
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 8
    ExplicitTop = 176
    ExplicitWidth = 789
  end
  inherited pnlBotoes: TPanel
    Top = 463
    Width = 1018
    TabOrder = 1
    ExplicitTop = 463
    ExplicitWidth = 1018
    object Label1: TLabel [0]
      Left = 96
      Top = 8
      Width = 357
      Height = 14
      Caption = 
        'Digite a quantidade retornada de cada garantia enviada para o fo' +
        'rnecedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [1]
      Left = 519
      Top = 8
      Width = 411
      Height = 14
      Caption = 
        '[CRTL + N] Para navegar nos itens da nota   [CTRL + M] Para info' +
        'rmar as quantidades'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 937
      ExplicitTop = 2
      ExplicitWidth = 937
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Align = alRight
      ExplicitLeft = 939
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 489
    Width = 1018
    TabOrder = 2
    ExplicitTop = 489
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object cxgRefugo: TcxGridCitel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 278
    Align = alClient
    TabOrder = 0
    OnExit = cxgRefugoExit
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgRefugoTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgRefugoNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 98
      end
      object cxgRefugoSERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERIE_'
        Options.Editing = False
        Options.Focusing = False
        Width = 34
      end
      object cxgRefugoDTAENT: TcxGridDBColumn
        Caption = 'Data Emi.'
        DataBinding.FieldName = 'DTAENT'
        Options.Editing = False
        Options.Focusing = False
        Width = 68
      end
      object cxgRefugoCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 55
      end
      object cxgRefugoDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 176
      end
      object cxgRefugoCODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Options.Focusing = False
        Width = 83
      end
      object cxgRefugoREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Options.Focusing = False
        Width = 92
      end
      object cxgRefugoSIGUNI: TcxGridDBColumn
        Caption = 'UN.'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Options.Focusing = False
        Width = 28
      end
      object cxgRefugoQTDITE: TcxGridDBColumn
        Caption = 'Qtde. NF.'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 67
      end
    end
    object cxgRefugoLevel: TcxGridLevel
      GridView = cxgRefugoTableView
    end
  end
  object cxgMovGae: TcxGridCitel [5]
    Left = 0
    Top = 281
    Width = 1018
    Height = 182
    Align = alBottom
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgMovGaeTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgMovGaeTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgMovGaeNUMENV: TcxGridDBColumn
        Caption = 'Doc. Envio'
        DataBinding.FieldName = 'NUMENV'
        Options.Editing = False
        Options.Focusing = False
        Width = 110
      end
      object cxgMovGaeESPENV: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ESPENV'
        Options.Editing = False
        Options.Focusing = False
        Width = 48
      end
      object cxgMovGaeSERENV: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERENV'
        Options.Editing = False
        Options.Focusing = False
        Width = 41
      end
      object cxgMovGaeDTAENV: TcxGridDBColumn
        Caption = 'Data Env.'
        DataBinding.FieldName = 'DTAENV'
        Options.Editing = False
        Options.Focusing = False
        Width = 83
      end
      object cxgMovGaeQTDENV: TcxGridDBColumn
        Caption = 'Qtde. Env.'
        DataBinding.FieldName = 'QTDENV'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxgMovGaeNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Options.Editing = False
        Options.Focusing = False
        Width = 279
      end
      object cxgMovGaeQTDRET: TcxGridDBColumn
        Caption = 'Qtde. Retornada'
        DataBinding.FieldName = 'QTDRET'
        Options.Editing = False
        Options.Focusing = False
        Width = 95
      end
      object cxgMovGaeQTDREF: TcxGridDBColumn
        Caption = 'Qtde. Refugo'
        DataBinding.FieldName = 'QTDREF'
        Options.Editing = False
        Options.Focusing = False
        Width = 81
      end
      object cxgMovGaeRETCON: TcxGridDBColumn
        Caption = 'Retorno'
        DataBinding.FieldName = 'RETCON'
        Width = 69
      end
      object cxgMovGaeREFCON: TcxGridDBColumn
        Caption = 'Refugo'
        DataBinding.FieldName = 'REFCON'
        Width = 74
      end
    end
    object cxgMovGaeLevel1: TcxGridLevel
      GridView = cxgMovGaeTableView
    end
  end
end
