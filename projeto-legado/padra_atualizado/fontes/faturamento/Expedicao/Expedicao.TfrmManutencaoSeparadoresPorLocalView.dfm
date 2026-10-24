inherited TfrmManutencaoSeparadoresPorLocalView: TTfrmManutencaoSeparadoresPorLocalView
  Width = 834
  Height = 550
  Caption = 'Manuten'#231#227'o de Separadores por Local de Separa'#231#227'o'
  ExplicitWidth = 834
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 479
    Width = 828
    TabOrder = 1
    ExplicitTop = 479
    ExplicitWidth = 828
    inherited FlwBotoes: TFlowPanel
      Width = 824
      ExplicitTop = 2
      ExplicitWidth = 824
      object btnAlterar: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 166
        Height = 22
        Caption = '[ F2 ] Alterar Separador'
        TabOrder = 1
        OnClick = btnAlterarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 748
      ExplicitLeft = 748
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 828
    TabOrder = 2
    ExplicitTop = 505
    ExplicitWidth = 828
    inherited pnlNomeForm: TPanel
      Left = 657
      ExplicitLeft = 657
    end
    inherited pnlInfo: TPanel
      Width = 657
      ExplicitWidth = 657
    end
  end
  object cxgLocaisSeparacao: TcxGridCitel [3]
    Left = 0
    Top = 40
    Width = 828
    Height = 412
    Align = alClient
    TabOrder = 0
    object cxgLocaisSeparacaoTBV: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgLocaisSeparacaoTBVCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'CODIGO_LOCAL_SEPARACAO'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgLocaisSeparacaoLOCAL_SEPARACAO: TcxGridDBColumn
        Caption = 'Local de Separa'#231#227'o'
        Options.Editing = False
        Options.Focusing = False
        Width = 230
      end
      object cxgLocaisSeparacaoSEPARADOR_ATUAL: TcxGridDBColumn
        Caption = 'Separador Atual'
        Options.Editing = False
        Options.Focusing = False
        Width = 280
      end
      object cxgLocaisSeparacaoDESCRICAO_SEPARADOR_NOVO: TcxGridDBColumn
        Caption = 'Separador Novo'
        Options.Editing = False
        Width = 280
      end
      object cxgLocaisSeparacaoSEPARACAO_INICIADA: TcxGridDBColumn
        DataBinding.FieldName = 'SEPARACAO_INICIADA'
        Visible = False
      end
    end
    object cxgItensTBV: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DetailKeyFieldNames = 'CODIGO_LOCAL_SEPARACAO'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'CHAVE'
      DataController.MasterKeyFieldNames = 'CODIGO_LOCAL_SEPARACAO'
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
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensCODIGO_PRODUTO: TcxGridDBColumn
        Caption = 'C'#243'digo Produto'
        Options.Editing = False
        Options.Focusing = False
        Width = 98
      end
      object cxgItensDESCRICAO_PRODUTO: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Produto'
        Options.Editing = False
        Options.Focusing = False
        Width = 300
      end
      object cxgItensLOCALIZACAO_FISICA: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        Options.Editing = False
        Options.Focusing = False
        Width = 200
      end
      object cxgItensQUANTIDADE: TcxGridDBColumn
        Caption = 'Quantidade'
        Options.Editing = False
        Options.Focusing = False
        Width = 86
      end
    end
    object cxgLocaisSeparacaoLVL: TcxGridLevel
      GridView = cxgLocaisSeparacaoTBV
      object cxgItensLVL: TcxGridLevel
        GridView = cxgItensTBV
      end
    end
  end
  object pnlLegenda: TPanel [4]
    Left = 0
    Top = 452
    Width = 828
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object shpSeparacaoIniciada: TShape
      Left = 10
      Top = 4
      Width = 17
      Height = 17
      Brush.Color = 13421823
    end
    object Label3: TLabel
      Left = 33
      Top = 6
      Width = 247
      Height = 14
      Caption = 'Locais com separa'#231#227'o em andamento ou finalizada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlDados: TPanel [5]
    Left = 0
    Top = 0
    Width = 828
    Height = 40
    Align = alTop
    TabOrder = 5
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object edtPedido: TEditFocus
      Left = 49
      Top = 8
      Width = 184
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
end
