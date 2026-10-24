inherited frmSolicitacaoLojas: TfrmSolicitacaoLojas
  Left = 235
  Top = 332
  Width = 1024
  Height = 544
  BorderStyle = bsDialog
  Caption = 'Informe as Lojas que fornecer'#227'o os itens'
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 473
    Width = 1018
    Height = 26
    ExplicitTop = 473
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 291
      Width = 648
      Height = 22
      TabOrder = 3
      ExplicitLeft = 291
      ExplicitWidth = 648
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Align = alRight
      ModalResult = 2
      TabOrder = 2
      ExplicitLeft = 939
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 85
      Height = 22
      Align = alLeft
      Caption = '[F10] Confirma'
      ModalResult = 1
      TabOrder = 0
    end
    object btnAltEmp: TBitBtnLocked
      Left = 87
      Top = 2
      Width = 204
      Height = 22
      Align = alLeft
      Caption = '[ F7 ] Alterar empresa dos itens (Geral)'
      TabOrder = 1
      OnClick = btnAltEmpClick
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
  object pnlIteSld: TPanel [2]
    Left = 0
    Top = 455
    Width = 1018
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object shpSemSaldo: TShape
      Left = 530
      Top = 1
      Width = 16
      Height = 14
      Brush.Color = clRed
    end
    object lblSemSaldo: TLabel
      Left = 551
      Top = 1
      Width = 101
      Height = 14
      Caption = 'Sem saldo dispon'#237'vel'
    end
    object shpComSaldo: TShape
      Left = 666
      Top = 1
      Width = 16
      Height = 14
      Brush.Color = clBlue
    end
    object lblComSaldo: TLabel
      Left = 688
      Top = 1
      Width = 101
      Height = 14
      Caption = 'Com saldo dispon'#237'vel'
    end
    object lblEmNegritoSubProdutos: TLabel
      Left = 884
      Top = 1
      Width = 128
      Height = 14
      Caption = 'Sub-produtos da estrutura'
    end
    object lblEmNegrito: TLabel
      Left = 802
      Top = -1
      Width = 78
      Height = 16
      Caption = '[Em Negrito]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
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
  object dbgItensLoja: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 255
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgItensLojaDBTableViewCitel: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgItensLojaDBTableViewCitelCustomDrawCell
      OnEditKeyPress = dbgItensLojaDBTableViewCitelEditKeyPress
      DataController.DataSource = dtsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object CODITE: TcxGridDBColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 50
      end
      object CODGRU: TcxGridDBColumn
        Caption = 'Grupo'
        DataBinding.FieldName = 'CODGRU'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 40
      end
      object DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 273
      end
      object NUMLOT: TcxGridDBColumn
        Caption = 'Lote do Produto'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 198
      end
      object QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 74
      end
      object CODEMP: TcxGridDBColumn
        Caption = 'Loja Abast.'
        DataBinding.FieldName = 'CODEMP'
        Options.AutoWidthSizable = False
        Width = 60
      end
      object LOTABA: TcxGridDBColumn
        Caption = 'Lote Abast.'
        DataBinding.FieldName = 'LOTABA'
        Options.AutoWidthSizable = False
        Width = 182
      end
      object SALLOC: TcxGridDBColumn
        Caption = 'Saldo est. local'
        DataBinding.FieldName = 'SALLOC'
        Options.Editing = False
        Width = 80
      end
      object SALOUT: TcxGridDBColumn
        Caption = 'Est. outras lojas'
        DataBinding.FieldName = 'SALOUT'
        Options.Editing = False
        Width = 80
      end
      object TEMSLD: TcxGridDBColumn
        DataBinding.FieldName = 'TEMSLD'
        Visible = False
      end
      object ITESUB: TcxGridDBColumn
        DataBinding.FieldName = 'ITESUB'
        Visible = False
      end
    end
    object dbgItensLojaLevel1: TcxGridLevel
      GridView = dbgItensLojaDBTableViewCitel
    end
  end
  object dbgEstoque: TcxGridCitel [4]
    Left = 0
    Top = 255
    Width = 1018
    Height = 200
    Align = alBottom
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
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
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
  object dtsItens: TDataSource
    Left = 248
    Top = 80
  end
  object dtsUsado: TDataSource
    Left = 256
    Top = 128
  end
  object dtsEstoque: TDataSource
    Left = 344
    Top = 256
  end
end
