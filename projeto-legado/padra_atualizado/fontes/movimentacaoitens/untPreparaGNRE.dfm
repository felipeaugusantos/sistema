inherited frmPreparaGNRE: TfrmPreparaGNRE
  Width = 1024
  Height = 554
  BorderStyle = bsSingle
  Caption = 'Prepara GNRE'
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 483
    Width = 1018
    ExplicitTop = 483
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      ExplicitLeft = 938
    end
  end
  inherited pnlStatus: TPanel
    Top = 509
    Width = 1018
    ExplicitTop = 509
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
  object cxItens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 483
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = -136
    ExplicitTop = -480
    object cxItensDB: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          FieldName = 'VALGNR'
          Column = cxItensDBVALGNR
        end
        item
          Kind = skSum
          FieldName = 'VSTCAL'
          Column = cxItensDBColumn6
        end
        item
          Kind = skSum
          FieldName = 'VSTXML'
          Column = cxItensDBColumn7
        end
        item
          Kind = skSum
          FieldName = 'PROXML'
          Column = cxItensDBColumn9
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxItensDBColumn1: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'CODITE'
        MinWidth = 64
        Options.Editing = False
      end
      object cxItensDBColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 196
      end
      object cxItensDBColumn8: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Width = 130
      end
      object cxItensDBColumn3: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Width = 130
      end
      object cxItensDBColumn4: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Width = 48
      end
      object cxItensDBColumn5: TcxGridDBColumn
        Caption = 'CST'
        DataBinding.FieldName = 'CODSIT'
        Options.Editing = False
        Width = 30
      end
      object cxItensDBColumn6: TcxGridDBColumn
        Caption = 'Vr. Subst. Sistema'
        DataBinding.FieldName = 'VSTCAL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object cxItensDBCALVFCPST: TcxGridDBColumn
        Caption = 'Vr. ST FCP Sistema'
        DataBinding.FieldName = 'CAL_VFCPST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 111
      end
      object cxItensDBColumn7: TcxGridDBColumn
        Caption = 'Vr. Subst. Xml'
        DataBinding.FieldName = 'VSTXML'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 85
      end
      object cxItensDBVSTFCP: TcxGridDBColumn
        Caption = 'Vr. ST FCP Xml'
        DataBinding.FieldName = 'VSTFCP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 89
      end
      object cxItensDBColumn9: TcxGridDBColumn
        Caption = 'Vr. Prod. XML'
        DataBinding.FieldName = 'PROXML'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 94
      end
      object cxItensDBVALGNR: TcxGridDBColumn
        Caption = 'Vr. GNRE'
        DataBinding.FieldName = 'VALGNR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.OnValidate = cxItensDBVALGNRPropertiesValidate
        HeaderAlignmentHorz = taRightJustify
        HeaderHint = 
          'Valor GNRE = Vr. GNRE = (Vr. Subst. Sistema - Vr. Subst XML)+ (V' +
          'r. ST FCP Sistema - Vr. ST FCP XML)'
        Styles.Content = cxStyle1
        Width = 80
      end
    end
    object cxItensLvl: TcxGridLevel
      GridView = cxItensDB
    end
  end
  object dtsDados: TDataSource
    Left = 48
    Top = 64
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
end
