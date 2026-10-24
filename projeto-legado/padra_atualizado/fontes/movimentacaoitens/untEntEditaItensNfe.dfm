inherited frmEntEditaItensNfe: TfrmEntEditaItensNfe
  Width = 1024
  Height = 768
  BorderStyle = bsSizeable
  Caption = 'Notas com divergencias entre itens e capa.'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 687
    Width = 1008
    ExplicitTop = 687
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 925
      ExplicitLeft = 925
    end
  end
  inherited pnlStatus: TPanel
    Top = 713
    Width = 1008
    ExplicitTop = 713
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxGrid1: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 687
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxViewPai: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsPai
      DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftCompare]
      DataController.KeyFieldNames = 'CHAVE_'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir o filtro'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      OptionsView.RowSeparatorColor = clBlue
      OptionsView.RowSeparatorWidth = 3
      object cxViewPaiChave_: TcxGridDBColumn
        Caption = 'Chave NF-e'
        DataBinding.FieldName = 'CHAVE_'
        Width = 240
      end
      object cxViewPaiTOTPRO: TcxGridDBColumn
        Caption = 'Vr. Total Prod.'
        DataBinding.FieldName = 'TOTPRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiTOTPROCustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_TOTPRO: TcxGridDBColumn
        Caption = 'DIV Total Prod.'
        DataBinding.FieldName = 'DIV_TOTPRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiBASICM: TcxGridDBColumn
        Caption = 'Base ICMS'
        DataBinding.FieldName = 'BASICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiBASICMCustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_BASICM: TcxGridDBColumn
        Caption = 'Div Base ICMS'
        DataBinding.FieldName = 'DIV_BASICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiVALICM: TcxGridDBColumn
        Caption = 'Valor. ICMS'
        DataBinding.FieldName = 'VALICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiVALICMCustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_VALICM: TcxGridDBColumn
        Caption = 'DIV ICMS'
        DataBinding.FieldName = 'DIV_VALICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiBAS_ST: TcxGridDBColumn
        Caption = 'Base ST'
        DataBinding.FieldName = 'BAS_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiBAS_STCustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_BAS_ST: TcxGridDBColumn
        Caption = 'Div Bas ST'
        DataBinding.FieldName = 'DIV_BAS_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiVAL_ST: TcxGridDBColumn
        Caption = 'Valor ST.'
        DataBinding.FieldName = 'VAL_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiVAL_STCustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_VAL_ST: TcxGridDBColumn
        Caption = 'Div Val. ST'
        DataBinding.FieldName = 'DIV_VAL_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiBASIPI: TcxGridDBColumn
        Caption = 'Base IPI'
        DataBinding.FieldName = 'BASIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiBASIPICustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_BASIPI: TcxGridDBColumn
        Caption = 'Div Bas IPI'
        DataBinding.FieldName = 'DIV_BASIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiVALIPI: TcxGridDBColumn
        Caption = 'Valor IPI'
        DataBinding.FieldName = 'VALIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiVALIPICustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_VALIPI: TcxGridDBColumn
        Caption = 'Div. IPI'
        DataBinding.FieldName = 'DIV_VALIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiVALFRE: TcxGridDBColumn
        Caption = 'Valor Frete'
        DataBinding.FieldName = 'VALFRE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiVALFRECustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_VALFRE: TcxGridDBColumn
        Caption = 'Div Frete'
        DataBinding.FieldName = 'DIV_VALFRE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiVICMSDESON: TcxGridDBColumn
        Caption = 'ICMS Deson.'
        DataBinding.FieldName = 'VICMSDESON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiVICMSDESONCustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_VICMSDESON: TcxGridDBColumn
        Caption = 'Div ICMS Deson.'
        DataBinding.FieldName = 'DIV_VICMSDESON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiVDESC: TcxGridDBColumn
        Caption = 'Desconto'
        DataBinding.FieldName = 'VDESC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        OnCustomDrawCell = cxViewPaiVDESCCustomDrawCell
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_VDESC: TcxGridDBColumn
        Caption = 'Div Desconto.'
        DataBinding.FieldName = 'DIV_VDESC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiVOUTRO: TcxGridDBColumn
        Caption = 'Outros'
        DataBinding.FieldName = 'VOUTRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_VOUTRO: TcxGridDBColumn
        Caption = 'Div Outros'
        DataBinding.FieldName = 'DIV_VOUTRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiVSEG: TcxGridDBColumn
        Caption = 'Seguro'
        DataBinding.FieldName = 'VSEG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiDIV_VSEG: TcxGridDBColumn
        Caption = 'Seguro'
        DataBinding.FieldName = 'DIV_VSEG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Visible = False
        Options.Editing = False
        Width = 75
      end
      object cxViewPaiTEM_DIVERGENCIA: TcxGridDBColumn
        Caption = 'Tem Div.'
        DataBinding.FieldName = 'TEM_DIVERGENCIA'
        Visible = False
      end
    end
    object cxViewFilho: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsFilho
      DataController.DetailKeyFieldNames = 'CHAVE_'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'ID'
      DataController.MasterKeyFieldNames = 'CHAVE_'
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          FieldName = 'TOTPRO'
          Column = cxViewFilhoTOTPRO
        end
        item
          Kind = skSum
          FieldName = 'BASICM'
          Column = cxViewFilhoBASICM
        end
        item
          Kind = skSum
          FieldName = 'VALICM'
          Column = cxViewFilhoVALICM
        end
        item
          Kind = skSum
          FieldName = 'BAS_ST'
          Column = cxViewFilhoBAS_ST
        end
        item
          Kind = skSum
          FieldName = 'VAL_ST'
          Column = cxViewFilhoVAL_ST
        end
        item
          Kind = skSum
          FieldName = 'BASIPI'
          Column = cxViewFilhoBASIPI
        end
        item
          Kind = skSum
          FieldName = 'VALIPI'
          Column = cxViewFilhoVALIPI
        end
        item
          Kind = skSum
          FieldName = 'VALFRE'
          Column = cxViewFilhoVALFRE
        end
        item
          Kind = skSum
          FieldName = 'VICMSDESON'
          Column = cxViewFilhoVICMSDESON
        end
        item
          Kind = skSum
          FieldName = 'VDESC'
          Column = cxViewFilhoVDESC
        end
        item
          Kind = skSum
          FieldName = 'VOUTRO'
          Column = cxViewFilhoVOUTRO
        end
        item
          Kind = skSum
          FieldName = 'VSEG'
          Column = cxViewFilhoVSEG
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Styles.OnGetFooterSummaryStyle = cxViewFilhoStylesGetFooterSummaryStyle
      object cxViewFilhoCHAVE_: TcxGridDBColumn
        DataBinding.FieldName = 'CHAVE_'
        Visible = False
      end
      object cxViewFilhoCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 65
      end
      object cxViewFilhoDESITE: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'DESITE'
        Width = 175
      end
      object cxViewFilhoTOTPRO: TcxGridDBColumn
        Caption = 'Vr. Total Prod.'
        DataBinding.FieldName = 'TOTPRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoBASICM: TcxGridDBColumn
        Caption = 'Base ICMS'
        DataBinding.FieldName = 'BASICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoVALICM: TcxGridDBColumn
        Caption = 'Valor. ICMS'
        DataBinding.FieldName = 'VALICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoBAS_ST: TcxGridDBColumn
        Caption = 'Base ST'
        DataBinding.FieldName = 'BAS_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoVAL_ST: TcxGridDBColumn
        Caption = 'Valor ST.'
        DataBinding.FieldName = 'VAL_ST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoBASIPI: TcxGridDBColumn
        Caption = 'Base IPI'
        DataBinding.FieldName = 'BASIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoVALIPI: TcxGridDBColumn
        Caption = 'Valor IPI'
        DataBinding.FieldName = 'VALIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoVALFRE: TcxGridDBColumn
        Caption = 'Valor Frete'
        DataBinding.FieldName = 'VALFRE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoVICMSDESON: TcxGridDBColumn
        Caption = 'ICMS Deson.'
        DataBinding.FieldName = 'VICMSDESON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoVDESC: TcxGridDBColumn
        Caption = 'Desconto'
        DataBinding.FieldName = 'VDESC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoVOUTRO: TcxGridDBColumn
        Caption = 'Outros'
        DataBinding.FieldName = 'VOUTRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
      object cxViewFilhoVSEG: TcxGridDBColumn
        Caption = 'Seguro'
        DataBinding.FieldName = 'VSEG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Width = 75
      end
    end
    object cxLvlPai: TcxGridLevel
      GridView = cxViewPai
      object cxLvlFilho: TcxGridLevel
        GridView = cxViewFilho
      end
    end
  end
  object dtsPai: TDataSource
    Left = 168
    Top = 288
  end
  object dtsFilho: TDataSource
    Left = 248
    Top = 288
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 72
    Top = 32
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clRed
    end
  end
end
