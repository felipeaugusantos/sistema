inherited frmSolicitacaoMultiLojas: TfrmSolicitacaoMultiLojas
  Width = 1024
  Height = 544
  Caption = 'Informe as Lojas que fornecer'#227'o os itens'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 471
    Width = 1018
    ExplicitTop = 471
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 85
        Height = 22
        Align = alLeft
        Caption = '[F10] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 499
    Width = 1018
    ExplicitTop = 499
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
  object dbgEstoque: TcxGridCitel [2]
    Left = 0
    Top = 253
    Width = 1018
    Height = 200
    Align = alBottom
    TabOrder = 2
    object dbgEstoqueDBTableViewCitel: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsEstoque
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object EMP_NOMEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMP_NOMEMP'
        Options.AutoWidthSizable = False
        Width = 332
      end
      object ITE_SALDOS: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'ITE_SALDOS'
        Options.AutoWidthSizable = False
        Width = 60
      end
      object ITE_SAL_ML: TcxGridDBColumn
        Caption = 'Saldo g/ml'
        DataBinding.FieldName = 'ITE_SAL_ML'
        Options.AutoWidthSizable = False
        Width = 69
      end
      object ITE_SALRES: TcxGridDBColumn
        Caption = 'Saldo reserv. Pedido'
        DataBinding.FieldName = 'ITE_SALRES'
        Options.AutoWidthSizable = False
        Width = 109
      end
      object ITE_SALREG: TcxGridDBColumn
        Caption = 'Saldo reserv. Garantia'
        DataBinding.FieldName = 'ITE_SALREG'
        Options.AutoWidthSizable = False
        Width = 120
      end
      object ITE_SALEXT: TcxGridDBColumn
        Caption = 'Saldo reserv. Externo'
        DataBinding.FieldName = 'ITE_SALEXT'
        Options.AutoWidthSizable = False
        Width = 110
      end
      object ITE_SALDIS: TcxGridDBColumn
        Caption = 'Saldo dispon.'
        DataBinding.FieldName = 'ITE_SALDIS'
        Options.AutoWidthSizable = False
        Width = 74
      end
      object ITE_ENTFUT: TcxGridDBColumn
        Caption = 'Ent. futuras'
        DataBinding.FieldName = 'ITE_ENTFUT'
        Options.AutoWidthSizable = False
        Width = 69
      end
    end
    object dbgEstoqueLevel1: TcxGridLevel
      GridView = dbgEstoqueDBTableViewCitel
    end
  end
  object dbgItensLoja: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 253
    Align = alClient
    TabOrder = 3
    object dbgItensLojaDBTableViewCitel: TcxGridDBBandedTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgItensLojaDBTableViewCitelCustomDrawCell
      OnEditKeyPress = dbgItensLojaDBTableViewCitelEditKeyPress
      DataController.DataSource = dtsItens
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
      Bands = <
        item
          Caption = 'Loja de abastecimento'
        end>
      Zebra = False
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
      object CODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 50
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object CODGRU: TcxGridDBBandedColumn
        Caption = 'Grupo'
        DataBinding.FieldName = 'CODGRU'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 40
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object DESCRI: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 273
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object NUMLOT: TcxGridDBBandedColumn
        Caption = 'Lote do Produto'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 198
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object SALLOC: TcxGridDBBandedColumn
        Caption = 'Saldo est. local'
        DataBinding.FieldName = 'SALLOC'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 80
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object SALOUT: TcxGridDBBandedColumn
        Caption = 'Est. outras lojas'
        DataBinding.FieldName = 'SALOUT'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 85
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object TEMSLD: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEMSLD'
        Visible = False
        Options.Editing = False
        Options.AutoWidthSizable = False
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
    end
    object dbgItensLojaLevel1: TcxGridLevel
      GridView = dbgItensLojaDBTableViewCitel
    end
  end
  object pnlIteSld: TPanel [4]
    Left = 0
    Top = 453
    Width = 1018
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object Shape1: TShape
      Left = 530
      Top = 2
      Width = 16
      Height = 14
      Brush.Color = clRed
    end
    object Label1: TLabel
      Left = 551
      Top = 2
      Width = 101
      Height = 14
      Caption = 'Sem saldo dispon'#237'vel'
    end
    object Shape2: TShape
      Left = 666
      Top = 2
      Width = 16
      Height = 14
      Brush.Color = clBlue
    end
    object Label2: TLabel
      Left = 687
      Top = 2
      Width = 101
      Height = 14
      Caption = 'Com saldo dispon'#237'vel'
    end
    object chkIteSld: TCheckBox
      Left = 8
      Top = 1
      Width = 258
      Height = 17
      Caption = 'Exibir somente produtos sem saldo dispon'#237'vel?'
      TabOrder = 0
      OnClick = chkIteSldClick
    end
  end
  object dtsEstoque: TDataSource
    Left = 368
    Top = 376
  end
  object dtsItens: TDataSource
    Left = 248
    Top = 80
  end
  object dtsUsado: TDataSource
    Left = 256
    Top = 128
  end
end
