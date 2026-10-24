inherited frmConfirmaImportacaoLocFisica: TfrmConfirmaImportacaoLocFisica
  Width = 1250
  Height = 555
  Caption = 'Importa'#231#227'o das Localiza'#231#245'es F'#237'sicas - Confirma'#231#227'o '
  ExplicitWidth = 1250
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 484
    Width = 1244
    ExplicitTop = 484
    ExplicitWidth = 1244
    inherited FlwBotoes: TFlowPanel
      Width = 1240
      ExplicitWidth = 1240
      inherited btnConfirma: TBitBtnLocked
        Width = 113
        Caption = '[F10] &Confirma'
        ExplicitWidth = 113
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1161
      ExplicitLeft = 1161
    end
  end
  inherited pnlStatus: TPanel
    Top = 510
    Width = 1244
    ExplicitTop = 510
    ExplicitWidth = 1244
    inherited pnlNomeForm: TPanel
      Left = 1073
      ExplicitLeft = 1073
    end
    inherited pnlInfo: TPanel
      Width = 1073
      ExplicitWidth = 1073
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1244
    Height = 33
    Align = alTop
    TabOrder = 2
    DesignSize = (
      1244
      33)
    object rdgOpcoesPesquisa: TRadioGroup
      Left = 0
      Top = -8
      Width = 1244
      Height = 40
      Anchors = [akLeft, akTop, akRight]
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Exibir todos os Locais'
        'Exibir apenas os Locais com inconsist'#234'ncia')
      TabOrder = 0
      OnClick = rdgOpcoesPesquisaClick
    end
  end
  object pnlBottom: TPanel [3]
    Left = 0
    Top = 352
    Width = 1244
    Height = 132
    Align = alBottom
    TabOrder = 3
    object grpLegenda: TGroupBox
      Left = 1
      Top = 1
      Width = 1242
      Height = 130
      Align = alClient
      Caption = 'Legenda'
      TabOrder = 0
      object shpLocalComInconsistencia: TShape
        Left = 11
        Top = 24
        Width = 17
        Height = 15
        Brush.Color = 7124735
      end
      object lblProdutoComInconsistencia: TLabel
        Left = 34
        Top = 24
        Width = 153
        Height = 14
        Caption = 'Localiza'#231#227'o com inconsist'#234'ncia'
      end
      object shpLocalOK: TShape
        Left = 208
        Top = 24
        Width = 17
        Height = 15
      end
      object lblProdutoOk: TLabel
        Left = 231
        Top = 24
        Width = 153
        Height = 14
        Caption = 'Localiza'#231#227'o sem inconsist'#234'ncia'
      end
      object lblTipInc: TLabel
        Left = 11
        Top = 46
        Width = 107
        Height = 14
        Caption = 'Tipo de Inconsist'#234'ncia'
      end
      object mmoMotivo: TDBMemo
        Left = 2
        Top = 66
        Width = 1238
        Height = 62
        Align = alBottom
        DataField = 'MOTIVO'
        DataSource = dtsLocais
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object cxGLocFisica: TcxGridCitel [4]
    Left = 0
    Top = 33
    Width = 1244
    Height = 319
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGLocFisicaDBTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGLocFisicaDBTableViewCustomDrawCell
      DataController.DataSource = dtsLocais
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGLocFisicaCODFIM: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODFIM'
        Options.Editing = False
        Width = 115
      end
      object cxGLocFisicaDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Width = 267
      end
      object cxGLocFisicaATIVO_: TcxGridDBColumn
        Caption = 'Ativo'
        DataBinding.FieldName = 'ATIVO_'
        Options.Editing = False
      end
      object cxGLocFisicaCODAMZ: TcxGridDBColumn
        Caption = 'Armaz'#233'm'
        DataBinding.FieldName = 'CODAMZ'
        Options.Editing = False
      end
      object cxGLocFisicaCRITIC: TcxGridDBColumn
        Caption = 'Localiz. Cr'#237'tica'
        DataBinding.FieldName = 'CRITIC'
        Options.Editing = False
        Width = 79
      end
      object cxGLocFisicaTRANSI: TcxGridDBColumn
        Caption = 'Transit'#243'ria'
        DataBinding.FieldName = 'TRANSI'
        Options.Editing = False
        Width = 65
      end
      object cxGLocFisicaBALCAO: TcxGridDBColumn
        Caption = 'Balc'#227'o'
        DataBinding.FieldName = 'BALCAO'
        Options.Editing = False
        Width = 42
      end
      object cxGLocFisicaCAPACI: TcxGridDBColumn
        Caption = 'Capacidade M'#225'xima'
        DataBinding.FieldName = 'CAPACI'
        Options.Editing = False
      end
      object cxGLocFisicaPONREP: TcxGridDBColumn
        Caption = 'Ponto de Reposi'#231#227'o'
        DataBinding.FieldName = 'PONREP'
        Options.Editing = False
        Width = 105
      end
      object cxGLocFisicaCODLSE: TcxGridDBColumn
        Caption = 'Local de Separa'#231#227'o'
        DataBinding.FieldName = 'CODLSE'
        Options.Editing = False
        Width = 109
      end
      object cxGLocFisicaTIPLOC: TcxGridDBColumn
        Caption = 'Tipo de Localiza'#231#227'o'
        DataBinding.FieldName = 'TIPLOC'
        Options.Editing = False
        Width = 121
      end
      object cxGLocFisicaENDER_: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'ENDER_'
        Options.Editing = False
        Width = 128
      end
      object cxGLocFisicaIMPORT: TcxGridDBColumn
        DataBinding.FieldName = 'IMPORT'
        Visible = False
        Options.Editing = False
      end
      object cxGLocFisicaMOTIVO: TcxGridDBColumn
        DataBinding.FieldName = 'MOTIVO'
        Visible = False
        Options.Editing = False
      end
      object cxGLocFisicaPDERPD: TcxGridDBColumn
        Caption = 'Rec. Prod. Diferente'
        DataBinding.FieldName = 'PDERPD'
        Options.Editing = False
        Width = 110
      end
      object cxGLocFisicaTXOMAX: TcxGridDBColumn
        Caption = 'Taxa de Ocup. M'#225'x.'
        DataBinding.FieldName = 'TXOMAX'
        Options.Editing = False
        Width = 105
      end
      object cxGLocFisicaPESMAX: TcxGridDBColumn
        Caption = 'Peso M'#225'x.'
        DataBinding.FieldName = 'PESMAX'
        Options.Editing = False
        Width = 70
      end
      object cxGLocFisicaLARGUR: TcxGridDBColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'LARGUR'
        Options.Editing = False
        Width = 70
      end
      object cxGLocFisicaALTURA: TcxGridDBColumn
        Caption = 'Altura'
        DataBinding.FieldName = 'ALTURA'
        Options.Editing = False
        Width = 70
      end
      object cxGLocFisicaPROFUN: TcxGridDBColumn
        Caption = 'Profundidade'
        DataBinding.FieldName = 'PROFUN'
        Options.Editing = False
        Width = 70
      end
      object cxGLocFisicaITEPIC: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'ITEPIC'
        Options.Editing = False
        Width = 53
      end
      object cxGLocFisicaOBSERV: TcxGridDBColumn
        Caption = 'Observa'#231#227'o'
        DataBinding.FieldName = 'OBSERV'
        Options.Editing = False
        Width = 200
      end
    end
    object cxGLocFisicaLevel1: TcxGridLevel
      GridView = cxGLocFisicaDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 72
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 88
    Top = 160
  end
  object dtsLocais: TDataSource
    Left = 56
    Top = 48
  end
end
