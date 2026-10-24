inherited frmMargemParaFranquia: TfrmMargemParaFranquia
  Width = 1024
  Height = 768
  Caption = 'Precifica'#231#227'o por Regime Tribut'#225'rio (Para Franquias)'
  Position = poMainFormCenter
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  object lblSelecionado: TLabel [0]
    Left = 0
    Top = 0
    Width = 1018
    Height = 14
    Align = alTop
    Caption = 'Produto Selecionado:'
    ExplicitWidth = 102
  end
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 113
        Height = 25
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
        OnKeyDown = btnConfirmaKeyDown
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
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
  object pnlPrecos1: TPanel [3]
    Left = 0
    Top = 14
    Width = 1018
    Height = 681
    Align = alClient
    Anchors = []
    BevelOuter = bvNone
    Padding.Left = 5
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 5
      Top = 665
      Width = 614
      Height = 16
      Align = alBottom
      Caption = 
        'Pre'#231'os de venda estimados - custos podem variar       * Valores ' +
        'ser'#227'o replicados para todas as franquias  '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object cxDados: TcxGrid
      Left = 5
      Top = 0
      Width = 1013
      Height = 665
      Align = alClient
      TabOrder = 0
      object cxvDados: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxvDadosCustomDrawCell
        OnFocusedItemChanged = cxvDadosFocusedItemChanged
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados pra Exibir>'
        OptionsView.GroupByBox = False
        object cxvEMPMAT: TcxGridDBColumn
          Caption = 'Empresa Matriz'
          DataBinding.FieldName = 'ITE_CODEMP'
          Options.Editing = False
          Width = 81
        end
        object cxvREGIME: TcxGridDBColumn
          Caption = 'Regime Tribut'#225'rio'
          DataBinding.FieldName = 'ITE_REGTRI'
          OnGetDisplayText = cxvREGIMEGetDisplayText
          Options.Editing = False
          Width = 109
        end
        object cxvIPIENT: TcxGridDBColumn
          Caption = 'IPI Entrada'
          DataBinding.FieldName = 'ITE_IPIENT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 56
        end
        object cxvICMENT: TcxGridDBColumn
          Caption = 'ICMS Entrada'
          DataBinding.FieldName = 'ITE_ICMENT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 70
        end
        object cxvSUBSTI: TcxGridDBColumn
          Caption = 'Subst. Tribut.'
          DataBinding.FieldName = 'ITE_SUBSTI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 82
        end
        object cxvICMSAI: TcxGridDBColumn
          Caption = 'ICMS Sa'#237'da'
          DataBinding.FieldName = 'ITE_ICMSAI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
        end
        object cxvIMPFED: TcxGridDBColumn
          Caption = 'Imp. Fed(+)'
          DataBinding.FieldName = 'ITE_IMPFED'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
        end
        object cxvSUBFED: TcxGridDBColumn
          Caption = 'Imp. Fed.(-)'
          DataBinding.FieldName = 'ITE_SUBFED'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 73
        end
        object cxvDESADB: TcxGridDBColumn
          Caption = 'Despesas Adc.'
          DataBinding.FieldName = 'ITE_DESADB'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 84
        end
        object cxvPRECUS: TcxGridDBColumn
          Caption = 'Custo'
          DataBinding.FieldName = 'ITE_PRECUS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
        end
        object cxvCUSREA: TcxGridDBColumn
          Caption = 'Custo Real'
          DataBinding.FieldName = 'ITE_CUSREA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
        end
        object cxvMARBR1: TcxGridDBColumn
          Tag = 1
          Caption = 'Margem Bruta(1)'
          DataBinding.FieldName = 'ITE_MARBR1'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Properties.OnValidate = cxvMARBR1PropertiesValidate
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 99
        end
        object cxvPREVE1: TcxGridDBColumn
          Tag = 11
          Caption = 'Pre'#231'o de Venda(1)'
          DataBinding.FieldName = 'ITE_PREVE1'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 97
        end
        object cxvMARBR2: TcxGridDBColumn
          Tag = 2
          Caption = 'Margem Bruta(2)'
          DataBinding.FieldName = 'ITE_MARBR2'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 99
        end
        object cxvPREVE2: TcxGridDBColumn
          Tag = 12
          Caption = 'Pre'#231'o de Venda(2)'
          DataBinding.FieldName = 'ITE_PREVE2'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 109
        end
        object cxvMARBR3: TcxGridDBColumn
          Tag = 3
          Caption = 'Margem Bruta(3)'
          DataBinding.FieldName = 'ITE_MARBR3'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 87
        end
        object cxvPREVE3: TcxGridDBColumn
          Tag = 13
          Caption = 'Pre'#231'o de Venda(3)'
          DataBinding.FieldName = 'ITE_PREVE3'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 109
        end
        object cxvMARBR4: TcxGridDBColumn
          Tag = 4
          Caption = 'Margem Bruta(4)'
          DataBinding.FieldName = 'ITE_MARBR4'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 87
        end
        object cxvPREVE4: TcxGridDBColumn
          Tag = 14
          Caption = 'Pre'#231'o de Venda(4)'
          DataBinding.FieldName = 'ITE_PREVE4'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 97
        end
        object cxvMARBR5: TcxGridDBColumn
          Tag = 5
          Caption = 'Margem Bruta(5)'
          DataBinding.FieldName = 'ITE_MARBR5'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 99
        end
        object cxvPREVE5: TcxGridDBColumn
          Tag = 15
          Caption = 'Pre'#231'o de Venda(5)'
          DataBinding.FieldName = 'ITE_PREVE5'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 109
        end
        object cxvMARBR6: TcxGridDBColumn
          Tag = 6
          Caption = 'Margem Bruta(6)'
          DataBinding.FieldName = 'ITE_MARBR6'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 87
        end
        object cxvPREVE6: TcxGridDBColumn
          Tag = 16
          Caption = 'Pre'#231'o de Venda(6)'
          DataBinding.FieldName = 'ITE_PREVE6'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 97
        end
        object cxvMARBR7: TcxGridDBColumn
          Tag = 7
          Caption = 'Margem Bruta(7)'
          DataBinding.FieldName = 'ITE_MARBR7'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 99
        end
        object cxvPREVE7: TcxGridDBColumn
          Tag = 17
          Caption = 'Pre'#231'o de Venda(7)'
          DataBinding.FieldName = 'ITE_PREVE7'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = ',0.0000'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 109
        end
        object cxvEMPRESA: TcxGridDBColumn
          DataBinding.FieldName = 'EMPRESA'
          Visible = False
          GroupIndex = 0
          IsCaptionAssigned = True
        end
      end
      object cxlDados: TcxGridLevel
        GridView = cxvDados
      end
    end
  end
end
