inherited frmItensSemLote: TfrmItensSemLote
  Width = 785
  Height = 563
  Caption = 'Itens sem lote dispon'#237'vel'
  ExplicitWidth = 785
  ExplicitHeight = 563
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 492
    Width = 779
    TabOrder = 1
    ExplicitTop = 492
    ExplicitWidth = 779
    inherited FlwBotoes: TFlowPanel
      Width = 775
      ExplicitTop = 2
      ExplicitWidth = 775
      object btnCadastroRapidoLote: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 186
        Height = 22
        Align = alLeft
        Caption = '[F1] - Cadastro R'#225'pido de Lote'
        TabOrder = 1
        OnClick = btnCadastroRapidoLoteClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 699
      ExplicitLeft = 699
    end
  end
  inherited pnlStatus: TPanel
    Top = 518
    Width = 779
    TabOrder = 2
    ExplicitTop = 518
    ExplicitWidth = 779
    inherited pnlNomeForm: TPanel
      Left = 608
      ExplicitLeft = 608
    end
    inherited pnlInfo: TPanel
      Width = 608
      ExplicitWidth = 608
    end
  end
  object cxgItensSemLote: TcxGridCitel [3]
    Left = 0
    Top = 36
    Width = 779
    Height = 456
    Align = alClient
    TabOrder = 0
    object cxgItensSemLoteTBV: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItensSemLote
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensSemLoteTBVCODIGO: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODIGO'
        Width = 86
      end
      object cxgItensSemLoteTBVDESCRICAO: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRICAO'
        Width = 450
      end
      object cxgItensSemLoteTBVNUMERO_LOTE: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMERO_LOTE'
        Width = 210
      end
    end
    object cxgItensSemLoteLVL: TcxGridLevel
      GridView = cxgItensSemLoteTBV
    end
  end
  object pnlMensagem: TPanel [4]
    Left = 0
    Top = 0
    Width = 779
    Height = 36
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object lblMensagem: TLabel
      Left = 1
      Top = 1
      Width = 777
      Height = 34
      Align = alClient
      Caption = 
        '  O itens listados abaixo, n'#227'o possuem lote dispon'#237'vel para baix' +
        'a da ordem de produ'#231#227'o!'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 499
      ExplicitHeight = 15
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 268
    Top = 56
  end
  object dtsItensSemLote: TDataSource
    Left = 380
    Top = 268
  end
end
