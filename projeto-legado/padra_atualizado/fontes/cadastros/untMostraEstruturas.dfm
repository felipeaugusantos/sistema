inherited frmMostraEstruturas: TfrmMostraEstruturas
  Width = 1125
  Height = 400
  BorderIcons = [biSystemMenu]
  Caption = 'Estruturas'
  Position = poMainFormCenter
  ExplicitWidth = 1125
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 298
    Width = 1119
    ExplicitTop = 298
    ExplicitWidth = 1119
    inherited FlwBotoes: TFlowPanel
      Width = 1115
      ExplicitWidth = 1115
    end
  end
  inherited pnlStatus: TPanel
    Top = 355
    Width = 1119
    ExplicitTop = 355
    ExplicitWidth = 1119
    inherited pnlNomeForm: TPanel
      Left = 948
      ExplicitLeft = 948
    end
    inherited pnlInfo: TPanel
      Width = 948
      ExplicitWidth = 948
    end
  end
  inherited pgcDados: TPageControl
    Left = 792
    Top = 467
    Width = 73
    Height = 33
    Align = alNone
    ExplicitLeft = 792
    ExplicitTop = 467
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 323
    Width = 1119
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    DesignSize = (
      1119
      32)
    object lblCodIte: TLabel
      Left = 5
      Top = 8
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object lblQtdEstrutura: TLabel
      Left = 524
      Top = 9
      Width = 270
      Height = 14
      Caption = 'Quantidade de estruturas dispon'#237'veis com o saldo atual:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object lblTotEstrutura: TLabel
      Left = 799
      Top = 6
      Width = 66
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSimilares: TBitBtnLocked
      Left = 976
      Top = 4
      Width = 142
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Similares [F11]'
      Enabled = False
      TabOrder = 0
      OnClick = btnSimilaresClick
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 27
      Top = 4
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  object cxDBTreeEstru: TcxDBTreeList [4]
    Left = 0
    Top = 0
    Width = 1119
    Height = 298
    Align = alClient
    Bands = <
      item
        Caption.Text = 'ESTRUTURA'
      end>
    DataController.DataSource = dtsItens
    DataController.ParentField = 'CODPAI'
    DataController.KeyField = 'CODITE'
    Navigator.Buttons.CustomButtons = <>
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsView.Footer = True
    OptionsView.GroupFooters = tlgfVisibleWhenExpanded
    RootValue = -1
    Styles.ContentEven = cxStyle1
    TabOrder = 4
    object CODITE: TcxDBTreeListColumn
      Caption.Text = 'C'#243'digo'
      DataBinding.FieldName = 'CODITE'
      Width = 70
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object DESITE: TcxDBTreeListColumn
      BestFitMaxWidth = 185
      Caption.Text = 'Descri'#231#227'o'
      DataBinding.FieldName = 'DESITE'
      Width = 100
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object CODFAB: TcxDBTreeListColumn
      BestFitMaxWidth = 82
      Caption.Text = 'C'#243'd. F'#225'brica'
      DataBinding.FieldName = 'CODFAB'
      Width = 82
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object SIMILI: TcxDBTreeListColumn
      BestFitMaxWidth = 58
      Caption.AlignHorz = taCenter
      Caption.GlyphAlignHorz = taCenter
      Caption.Text = 'Similar'
      DataBinding.FieldName = 'SIMILI'
      Options.Sizing = False
      Width = 58
      Position.ColIndex = 3
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object QTDITE: TcxDBTreeListColumn
      BestFitMaxWidth = 80
      Caption.AlignHorz = taRightJustify
      Caption.Text = 'Quantidade'
      DataBinding.FieldName = 'QTDITE'
      Width = 80
      Position.ColIndex = 4
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
      Summary.GroupFooterSummaryItems = <
        item
          AlignHorz = taRightJustify
          Format = '0.00'
          Kind = skSum
          AlignHorzAssigned = True
        end>
    end
    object PRECUS: TcxDBTreeListColumn
      Caption.Text = 'Custo'
      DataBinding.FieldName = 'PRECUS'
      Width = 100
      Position.ColIndex = 5
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object TOTCUS: TcxDBTreeListColumn
      Caption.Text = 'Total Custo'
      DataBinding.FieldName = 'TOTCUS'
      Width = 100
      Position.ColIndex = 7
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
      Summary.GroupFooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
    end
    object CUSREA: TcxDBTreeListColumn
      Caption.Text = 'Custo Real'
      DataBinding.FieldName = 'CUSREA'
      Width = 100
      Position.ColIndex = 8
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object TOTCUR: TcxDBTreeListColumn
      Caption.Text = 'Total Custo Real'
      DataBinding.FieldName = 'TOTCUR'
      Width = 100
      Position.ColIndex = 9
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
      Summary.GroupFooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
    end
    object SALITE: TcxDBTreeListColumn
      Caption.Text = 'Saldo Estoque'
      DataBinding.FieldName = 'SALITE'
      Width = 100
      Position.ColIndex = 10
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
      Summary.GroupFooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
    end
    object SALDIS: TcxDBTreeListColumn
      Caption.Text = 'Saldo Dispon'#237'vel'
      DataBinding.FieldName = 'SALDIS'
      Width = 100
      Position.ColIndex = 11
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
      Summary.GroupFooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
    end
    object CUSUTI: TcxDBTreeListColumn
      Caption.Text = 'Custo Utilizado'
      DataBinding.FieldName = 'CUSUTI'
      Width = 100
      Position.ColIndex = 6
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
      Summary.GroupFooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Format = '0.00'
          Kind = skSum
        end>
    end
    object CODMAR: TcxDBTreeListColumn
      Caption.Text = 'Marca'
      DataBinding.FieldName = 'CODMAR'
      Options.Editing = False
      Width = 100
      Position.ColIndex = 12
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object DESMAR: TcxDBTreeListColumn
      Caption.Text = 'Desc. Marca'
      DataBinding.FieldName = 'DESMAR'
      Options.Editing = False
      Width = 100
      Position.ColIndex = 13
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object pnlLegendaCustoUti: TPanel [5]
    Left = 0
    Top = 298
    Width = 1119
    Height = 25
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 48
  end
  object dtsItens: TDataSource
    AutoEdit = False
    OnDataChange = dtsItensDataChange
    Left = 352
    Top = 152
  end
  object StyleRepository: TcxStyleRepository
    Left = 280
    Top = 152
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clMoneyGreen
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Style = []
      TextColor = clBlack
    end
    object TreeListStyleSheetDevExpress: TcxTreeListStyleSheet
      Caption = 'DevExpress'
      Styles.ContentEven = cxStyle1
      BuiltIn = True
    end
  end
end
