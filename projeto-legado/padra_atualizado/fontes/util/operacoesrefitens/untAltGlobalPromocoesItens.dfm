inherited frmAltGlobalPromocoesItens: TfrmAltGlobalPromocoesItens
  Width = 769
  Height = 550
  Caption = 'Itens a serem alterados na Promo'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 769
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 478
    Width = 763
    ExplicitTop = 478
    ExplicitWidth = 763
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 4
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 429
    end
  end
  object pnlBotoesEnt: TPanel [3]
    Left = 0
    Top = 478
    Width = 763
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    DesignSize = (
      763
      28)
    object btnConfirma: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnVoltar: TBitBtnLocked
      Left = 646
      Top = 3
      Width = 111
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[ Esc ] Voltar'
      TabOrder = 1
      OnClick = btnVoltarClick
    end
  end
  object cxGridItensPromocao: TcxGridCitel [4]
    Left = 0
    Top = 0
    Width = 763
    Height = 478
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridItensPromocaoTable: TcxGridDBTableViewCitel
      OnKeyDown = cxGridItensPromocaoTableKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsItensPromocao
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridItensPromocaoPRO_DESPRO: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Promo'#231#227'o'
        DataBinding.FieldName = 'PRO_DESPRO'
        Visible = False
        GroupIndex = 0
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 135
      end
      object cxGridItensPromocaoITE_CODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'ITE_CODITE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
      end
      object cxGridItensPromocaoITE_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Produto'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 173
      end
      object cxGridItensPromocaoITE_REFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ITE_REFERE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 171
      end
      object cxGridItensPromocaoUNI_SIGUNI: TcxGridDBColumn
        Caption = 'UN.'
        DataBinding.FieldName = 'UNI_SIGUNI'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 34
      end
      object cxGridItensPromocaoIPR_TABPRE: TcxGridDBColumn
        Caption = 'Tabela de Pre'#231'os'
        DataBinding.FieldName = 'IPR_TABGRI'
        Options.Editing = False
        Options.Focusing = False
        Width = 96
      end
      object cxGridItensPromocaoIPR_PRECUS_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo (Atual)'
        DataBinding.FieldName = 'IPR_PRECUS_ATU'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 127
      end
      object cxGridItensPromocaoIPR_PRECUS_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo (Novo)'
        DataBinding.FieldName = 'IPR_PRECUS_NOV'
        Options.Moving = False
        Width = 127
      end
      object cxGridItensPromocaoIPR_PREVEN_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda (Atual)'
        DataBinding.FieldName = 'IPR_PREVEN_ATU'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 122
      end
      object cxGridItensPromocaoIPR_PREVEN_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda (Novo)'
        DataBinding.FieldName = 'IPR_PREVEN_NOV'
        Options.Moving = False
        Width = 129
      end
      object cxGridItensPromocaoIPR_PERDES_ATU: TcxGridDBColumn
        Caption = '% Desconto (Atual)'
        DataBinding.FieldName = 'IPR_PERDES_ATU'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 115
      end
      object cxGridItensPromocaoIPR_PERDES_NOV: TcxGridDBColumn
        Caption = '% Desconto (Novo)'
        DataBinding.FieldName = 'IPR_PERDES_NOV'
        Options.Moving = False
        Width = 113
      end
      object cxGridItensPromocaoIPR_COMVAR_ATU: TcxGridDBColumn
        Caption = '% Comiss'#227'o Vend. Int. (Atual)'
        DataBinding.FieldName = 'IPR_COMVAR_ATU'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 157
      end
      object cxGridItensPromocaoIPR_COMVAR_NOV: TcxGridDBColumn
        Caption = '% Comiss'#227'o Vend. Int. (Novo)'
        DataBinding.FieldName = 'IPR_COMVAR_NOV'
        Options.Moving = False
        Width = 155
      end
      object cxGridItensPromocaoIPR_COMATA_ATU: TcxGridDBColumn
        Caption = '% Comiss'#227'o Vend. Ext. Loja (Atual)'
        DataBinding.FieldName = 'IPR_COMATA_ATU'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 183
      end
      object cxGridItensPromocaoIPR_COMATA_NOV: TcxGridDBColumn
        Caption = '% Comiss'#227'o Vend. Ext. Loja (Novo)'
        DataBinding.FieldName = 'IPR_COMATA_NOV'
        Options.Moving = False
        Width = 188
      end
      object cxGridItensPromocaoIPR_COMDIS_ATU: TcxGridDBColumn
        Caption = '% Comiss'#227'o Vend. Ext. Dist. (Atual)'
        DataBinding.FieldName = 'IPR_COMDIS_ATU'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 187
      end
      object cxGridItensPromocaoIPR_COMDIS_NOV: TcxGridDBColumn
        Caption = '% Comiss'#227'o Vend. Ext. Dist. (Novo)'
        DataBinding.FieldName = 'IPR_COMDIS_NOV'
        Options.Moving = False
        Width = 196
      end
    end
    object cxGridItensPromocaoLevel: TcxGridLevel
      GridView = cxGridItensPromocaoTable
    end
  end
  inherited pnlStatus: TPanel
    Top = 506
    Width = 763
    TabOrder = 3
    ExplicitTop = 506
    ExplicitWidth = 763
    inherited pnlNomeForm: TPanel
      Left = 592
      ExplicitLeft = 592
    end
    inherited pnlInfo: TPanel
      Width = 592
      ExplicitWidth = 592
    end
  end
  object dsItensPromocao: TDataSource
    Left = 544
    Top = 128
  end
end
