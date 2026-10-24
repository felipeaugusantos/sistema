inherited frmApuracaoLucroRealLalurLacsCompensacaoMult: TfrmApuracaoLucroRealLalurLacsCompensacaoMult
  Width = 818
  Height = 355
  Caption = 'Compensa'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 818
  ExplicitHeight = 355
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 284
    Width = 812
    TabOrder = 1
    ExplicitTop = 284
    ExplicitWidth = 812
    inherited FlwBotoes: TFlowPanel
      Width = 808
      ExplicitWidth = 808
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 732
      ExplicitLeft = 732
    end
  end
  inherited pnlStatus: TPanel
    Top = 310
    Width = 812
    TabOrder = 2
    ExplicitTop = 310
    ExplicitWidth = 812
    inherited pnlNomeForm: TPanel
      Left = 641
      ExplicitLeft = 641
    end
    inherited pnlInfo: TPanel
      Width = 641
      ExplicitWidth = 641
    end
  end
  object GridCitel: TcxGridCitel [2]
    Left = 0
    Top = 60
    Width = 812
    Height = 224
    Align = alClient
    TabOrder = 0
    object GridCitelTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnFocusedItemChanged = GridCitelTableViewFocusedItemChanged
      DataController.DataSource = dsCompensacao
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'CTA_VLACOM'
          Column = GridCitelTableViewCTA_VLACOM
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object GridCitelTableViewCTA_CODCON: TcxGridDBColumn
        DataBinding.FieldName = 'CTA_CODCON'
        Visible = False
        VisibleForCustomization = False
      end
      object GridCitelTableViewCTA_DESCRI: TcxGridDBColumn
        Caption = 'Apura'#231#245'es Dispon'#237'veis para Compensa'#231#227'o'
        DataBinding.FieldName = 'CTA_DESCRI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        Width = 360
      end
      object GridCitelTableViewCTA_VLDISP: TcxGridDBColumn
        Caption = 'Valor Dispon'#237'vel'
        DataBinding.FieldName = 'CTA_VLDISP'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Properties.ReadOnly = True
        Width = 139
      end
      object GridCitelTableViewCTA_VLACOM: TcxGridDBColumn
        Caption = 'Valor a Compensar'
        DataBinding.FieldName = 'CTA_VLACOM'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Properties.OnEditValueChanged = GridCitelTableViewCTA_VLACOMPropertiesEditValueChanged
        Width = 137
      end
      object GridCitelTableViewCTA_VLRSAL: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'CTA_VLRSAL'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Properties.ReadOnly = True
        Width = 137
      end
    end
    object GridCitelLevel1: TcxGridLevel
      GridView = GridCitelTableView
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 812
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object cxLabel1: TcxLabel
      Left = 2
      Top = 4
      Caption = 
        'Selecione de Qual Apura'#231#227'o Efetuaremos a Compensa'#231#227'o, e os Valor' +
        'es a Compensar'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object lbDescricaoACompensar: TcxLabel
      Left = 2
      Top = 33
      Caption = 'lbDescricaoACompensar'
      Transparent = True
    end
    object edtDescricaoACompensar: TCurrencyEditFocus
      Left = 266
      Top = 30
      TabStop = False
      Enabled = False
      ParentFont = False
      Properties.DisplayFormat = ' ,0.00;- ,0.00'
      Properties.ReadOnly = True
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 145
    end
    object cxLabel2: TcxLabel
      Left = 512
      Top = 33
      Caption = 'Valor Restante:'
      Transparent = True
    end
    object edtValorRestante: TCurrencyEditFocus
      Left = 591
      Top = 30
      TabStop = False
      Enabled = False
      ParentFont = False
      Properties.DisplayFormat = ' ,0.00;- ,0.00'
      Properties.ReadOnly = True
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      StyleFocused.Color = clInfoBk
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 145
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 32
  end
  object dsCompensacao: TDataSource
    Left = 312
    Top = 128
  end
end
