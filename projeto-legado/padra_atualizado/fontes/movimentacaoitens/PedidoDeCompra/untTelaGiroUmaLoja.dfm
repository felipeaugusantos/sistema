object frmTelaGiroUmaLoja: TfrmTelaGiroUmaLoja
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frmTelaGiroUmaLoja'
  ClientHeight = 191
  ClientWidth = 1280
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 163
    Width = 1280
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    ExplicitTop = 162
    object shpMesMed: TShape
      Left = 12
      Top = 6
      Width = 14
      Height = 14
      Brush.Color = clRed
    end
    object lblMesMed: TLabel
      Left = 29
      Top = 6
      Width = 189
      Height = 13
      Caption = 'Meses utilizados para m'#233'dia e sugest'#227'o'
    end
  end
  object pnlRodapeItem: TPanel
    Left = 0
    Top = 0
    Width = 1280
    Height = 163
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 162
    object cxvGridGiro1: TcxDBVerticalGrid
      Left = 0
      Top = 0
      Width = 169
      Height = 163
      BorderStyle = cxcbsNone
      Align = alLeft
      LookAndFeel.Kind = lfStandard
      OptionsView.ScrollBars = ssNone
      OptionsView.GridLineColor = clSilver
      OptionsView.RowHeaderWidth = 84
      OptionsView.ShowButtons = False
      OptionsData.Editing = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.Prior.Visible = False
      Navigator.Buttons.Next.Visible = False
      Styles.Header = cxsColFix
      TabOrder = 0
      DataController.DataSource = dtsItens
      ExplicitHeight = 162
      Version = 1
      object cxcMesGir1: TcxCategoryRow
        Options.CanMovedToCustomizationForm = False
        Options.CanResized = False
        Options.Moving = False
        Options.ShowExpandButton = False
        Options.ShowInCustomizationForm = False
        Properties.Caption = 'Meses do Giro'
        Properties.HeaderAlignmentHorz = taCenter
        Styles.Header = cxStyle1
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxgItensVENMES: TcxDBEditorRow
        Properties.Caption = 'Mes Atual'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_VENMES'
        Styles.Content = cxsVenMes
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxgItensQ_V_01: TcxDBEditorRow
        Properties.Caption = 'Mes 1'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_01'
        Styles.Content = cxsMes1
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxgItensQ_V_02: TcxDBEditorRow
        Properties.Caption = 'Mes 2'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_02'
        Styles.Content = cxsMes2
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxgItensQ_V_03: TcxDBEditorRow
        Properties.Caption = 'Mes 3'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_03'
        Styles.Content = cxsMes3
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxgItensQ_V_04: TcxDBEditorRow
        Properties.Caption = 'Mes 4'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_04'
        Styles.Content = cxsMes4
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxgItensQ_V_05: TcxDBEditorRow
        Properties.Caption = 'Mes 5'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_05'
        Styles.Content = cxsMes5
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxgItensQ_V_06: TcxDBEditorRow
        Properties.Caption = 'Mes 6'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_06'
        Styles.Content = cxsMes6
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
    end
    object cxvGridGiro2: TcxDBVerticalGrid
      Left = 169
      Top = 0
      Width = 169
      Height = 163
      BorderStyle = cxcbsNone
      Align = alLeft
      LookAndFeel.Kind = lfStandard
      OptionsView.ScrollBars = ssNone
      OptionsView.GridLineColor = clSilver
      OptionsView.RowHeaderWidth = 84
      OptionsData.Editing = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      Styles.Header = cxsColFix
      TabOrder = 1
      DataController.DataSource = dtsItens
      ExplicitHeight = 162
      Version = 1
      object cxcMesGir2: TcxCategoryRow
        Options.CanMovedToCustomizationForm = False
        Options.CanResized = False
        Options.Moving = False
        Options.ShowExpandButton = False
        Options.ShowInCustomizationForm = False
        Properties.Caption = 'Meses do Giro'
        Properties.HeaderAlignmentHorz = taCenter
        Styles.Header = cxStyle1
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxvGridGiro2CategoryRow1: TcxCategoryRow
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxgItensQ_V_07: TcxDBEditorRow
        Properties.Caption = 'Mes 7'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_07'
        Styles.Content = cxsMes7
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxgItensQ_V_08: TcxDBEditorRow
        Properties.Caption = 'Mes 8'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_08'
        Styles.Content = cxsMes8
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxgItensQ_V_09: TcxDBEditorRow
        Properties.Caption = 'Mes 9'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_09'
        Styles.Content = cxsMes9
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxgItensQ_V_10: TcxDBEditorRow
        Properties.Caption = 'Mes 10'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_10'
        Styles.Content = cxsMes10
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxgItensQ_V_11: TcxDBEditorRow
        Properties.Caption = 'Mes 11'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_11'
        Styles.Content = cxsMes11
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxgItensQ_V_12: TcxDBEditorRow
        Properties.Caption = 'Mes 12'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_Q_V_12'
        Styles.Content = cxsMes12
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
    end
    object cxDBVerticalGrid1: TcxDBVerticalGrid
      Left = 338
      Top = 0
      Width = 200
      Height = 163
      BorderStyle = cxcbsNone
      Align = alLeft
      LookAndFeel.Kind = lfStandard
      OptionsView.ScrollBars = ssNone
      OptionsView.GridLineColor = clSilver
      OptionsView.RowHeaderWidth = 119
      OptionsData.Editing = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      Styles.Header = cxsColFix
      TabOrder = 2
      DataController.DataSource = dtsItens
      ExplicitHeight = 162
      Version = 1
      object cxcSugest: TcxCategoryRow
        Options.CanMovedToCustomizationForm = False
        Options.CanResized = False
        Options.Moving = False
        Options.ShowExpandButton = False
        Options.ShowInCustomizationForm = False
        Properties.Caption = 'Sugest'#227'o...'
        Properties.HeaderAlignmentHorz = taCenter
        Styles.Header = cxStyle1
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxgItensMEDIA_: TcxDBEditorRow
        Properties.Caption = 'M'#233'dia de Vendas'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_MEDIA_'
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxgItensMEDIXX: TcxDBEditorRow
        Properties.Caption = 'M'#233'dia XX'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_MEDIXX'
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxgItensSUGEST: TcxDBEditorRow
        Properties.Caption = 'Sugest'#227'o'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_SUGEST'
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxDBEditorRow5: TcxDBEditorRow
        Properties.Caption = 'Estoque M'#225'ximo'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_ESTMAX'
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxDBEditorRow6: TcxDBEditorRow
        Properties.Caption = 'Estoque M'#237'nimo'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_ESTMIN'
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxDBEditorRow7: TcxDBEditorRow
        Properties.Caption = 'M'#250'ltiplo de Compra'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_MLTCOM'
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow
        Properties.Caption = 'Peso Total'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_PESOIT'
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object cxgItens2NVLGIR: TcxDBEditorRow
        Properties.Caption = 'N'#237'vel de Giro'
        Properties.DataBinding.FieldName = 'ITE_NVLGIR'
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
    end
    object cxDBVerticalGrid4: TcxDBVerticalGrid
      Left = 538
      Top = 0
      Width = 239
      Height = 163
      BorderStyle = cxcbsNone
      Align = alLeft
      LookAndFeel.Kind = lfStandard
      OptionsView.ScrollBars = ssNone
      OptionsView.GridLineColor = clSilver
      OptionsView.RowHeaderWidth = 150
      OptionsData.Editing = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      Styles.Header = cxsColFix
      TabOrder = 3
      DataController.DataSource = dtsItens
      ExplicitHeight = 162
      Version = 1
      object cxcSaldos: TcxCategoryRow
        Options.CanMovedToCustomizationForm = False
        Options.CanResized = False
        Options.Moving = False
        Options.ShowExpandButton = False
        Options.ShowInCustomizationForm = False
        Properties.Caption = 'Saldos'
        Properties.HeaderAlignmentHorz = taCenter
        Styles.Header = cxStyle1
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxDBEditorRow8: TcxDBEditorRow
        Properties.Caption = 'Saldo de Estoque'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_SALDOS'
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxDBVerticalGrid4DBEditorRow1: TcxDBEditorRow
        Properties.Caption = 'Saldo Dispon'#237'vel'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_SALDIS'
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxDBEditorRow9: TcxDBEditorRow
        Properties.Caption = 'Saldo Reservado Garantia'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_SALGAR'
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxDBEditorRow10: TcxDBEditorRow
        Properties.Caption = 'Saldo Res. Pedido Venda'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_SALRES'
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxDBEditorRow11: TcxDBEditorRow
        Properties.Caption = 'Pedido Compra Pendente'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_QTDPEN'
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxDBEditorRow12: TcxDBEditorRow
        Properties.Caption = 'Entrega Futura Pendente'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_QTDFUT'
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxgItensDIAEST: TcxDBEditorRow
        Properties.Caption = 'Dias de Estoque'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DIAEST'
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object cxgItensDIASUG: TcxDBEditorRow
        Properties.Caption = 'Dias Estoq. com Sugest'#227'o'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.FieldName = 'ITE_DIASUG'
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
    end
    object Panel1: TPanel
      Left = 777
      Top = 0
      Width = 503
      Height = 163
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 4
      ExplicitHeight = 162
      object cxDBVerticalGrid2: TcxDBVerticalGrid
        Left = 0
        Top = 54
        Width = 503
        Height = 18
        BorderStyle = cxcbsNone
        Align = alTop
        LookAndFeel.Kind = lfStandard
        OptionsView.ScrollBars = ssNone
        OptionsView.GridLineColor = clSilver
        OptionsView.RowHeaderWidth = 171
        OptionsData.Editing = False
        OptionsData.Appending = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        Navigator.Buttons.CustomButtons = <>
        Styles.Header = cxsColFix
        TabOrder = 0
        DataController.DataSource = dtsItens
        Version = 1
        object cxDBEditorRow17: TcxDBEditorRow
          Properties.Caption = 'Fornecedor da '#218'ltima Compra'
          Properties.DataBinding.FieldName = 'ITE_NOMFOR'
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 72
        Width = 503
        Height = 91
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        ExplicitHeight = 90
        object cxvUltimaVenda: TcxDBVerticalGrid
          Left = 257
          Top = 0
          Width = 257
          Height = 91
          BorderStyle = cxcbsNone
          Align = alLeft
          LookAndFeel.Kind = lfStandard
          OptionsView.ScrollBars = ssNone
          OptionsView.GridLineColor = clSilver
          OptionsView.RowHeaderWidth = 171
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          Styles.Header = cxsColFix
          TabOrder = 0
          DataController.DataSource = dtsItens
          ExplicitHeight = 90
          Version = 1
          object cxDBEditorRow27: TcxDBEditorRow
            Properties.Caption = #218'ltima Venda (Dias)'
            Properties.DataBinding.FieldName = 'ITE_DIAUVE'
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBEditorRow23: TcxDBEditorRow
            Properties.Caption = 'Data da '#218'ltima Venda'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = '0.00;-0.00'
            Properties.DataBinding.FieldName = 'ITE_DTAUVE'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxgItensMADTSA: TcxDBEditorRow
            Properties.Caption = 'Data da Maior Venda'
            Properties.DataBinding.FieldName = 'ITE_MADTSA'
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxgItensMAQTSA: TcxDBEditorRow
            Properties.Caption = 'Quantidade Maior Venda'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = '0.00;-0.00'
            Properties.DataBinding.FieldName = 'ITE_MAQTSA'
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxgItens2LOCFIS: TcxDBEditorRow
            Properties.Caption = 'Localiza'#231#227'o F'#237'sica'
            Properties.DataBinding.FieldName = 'ITE_LOCFIS'
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxgItens2CODBAR: TcxDBEditorRow
            Properties.Caption = 'C'#243'digo de Barras'
            Properties.DataBinding.FieldName = 'ITE_CODBAR'
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
        end
        object cxDBVerticalGrid6: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 257
          Height = 91
          BorderStyle = cxcbsNone
          Align = alLeft
          LookAndFeel.Kind = lfStandard
          OptionsView.ScrollBars = ssNone
          OptionsView.GridLineColor = clSilver
          OptionsView.RowHeaderWidth = 171
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          Styles.Header = cxsColFix
          TabOrder = 1
          DataController.DataSource = dtsItens
          ExplicitHeight = 90
          Version = 1
          object cxDBEditorRow18: TcxDBEditorRow
            Expanded = False
            Properties.Caption = #218'ltima Compra (Dias)'
            Properties.DataBinding.FieldName = 'ITE_DIAUCO'
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBVerticalGrid6DBEditorRow1: TcxDBEditorRow
            Properties.Caption = 'Data da '#218'ltima Compra'
            Properties.DataBinding.FieldName = 'ITE_DTAULT'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxDBEditorRow4: TcxDBEditorRow
            Properties.Caption = 'Pre'#231'o de '#218'ltima Compra'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = '0.00;-0.00'
            Properties.DataBinding.FieldName = 'ITE_PREULT'
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxDBEditorRow2: TcxDBEditorRow
            Properties.Caption = 'Quantidade '#218'ltima Compra'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.DisplayFormat = '0.00;-0.00'
            Properties.DataBinding.FieldName = 'ITE_QTDUCO'
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
        end
      end
      object pnlOutrasTop: TPanel
        Left = 0
        Top = 0
        Width = 503
        Height = 54
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object cxDBVerticalGrid7: TcxDBVerticalGrid
          Left = 256
          Top = 0
          Width = 256
          Height = 54
          BorderStyle = cxcbsNone
          Align = alLeft
          LookAndFeel.Kind = lfStandard
          OptionsView.ScrollBars = ssNone
          OptionsView.GridLineColor = clSilver
          OptionsView.RowHeaderWidth = 104
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          Styles.Header = cxsColFix
          TabOrder = 0
          DataController.DataSource = dtsItens
          Version = 1
          object cxcOutras2: TcxCategoryRow
            Options.CanMovedToCustomizationForm = False
            Options.CanResized = False
            Options.Moving = False
            Options.ShowExpandButton = False
            Options.ShowInCustomizationForm = False
            Properties.HeaderAlignmentHorz = taCenter
            Styles.Header = cxStyle1
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxgItensCODBAR: TcxDBEditorRow
            Properties.Caption = 'C'#243'digo de Barras'
            Properties.DataBinding.FieldName = 'ITE_CODBAR'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
        end
        object cxDBVerticalGrid8: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 256
          Height = 54
          BorderStyle = cxcbsNone
          Align = alLeft
          LookAndFeel.Kind = lfStandard
          OptionsView.ScrollBars = ssNone
          OptionsView.GridLineColor = clSilver
          OptionsView.RowHeaderWidth = 170
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          Styles.Header = cxsColFix
          TabOrder = 1
          DataController.DataSource = dtsItens
          Version = 1
          object cxcOutras1: TcxCategoryRow
            Options.CanMovedToCustomizationForm = False
            Options.CanResized = False
            Options.Moving = False
            Options.ShowExpandButton = False
            Options.ShowInCustomizationForm = False
            Properties.Caption = 'Outras Informa'#231#245'es'
            Properties.HeaderAlignmentHorz = taCenter
            Styles.Header = cxStyle1
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxgItensNVLGIR: TcxDBEditorRow
            Properties.Caption = 'N'#237'vel de Giro'
            Properties.DataBinding.FieldName = 'ITE_NVLGIR'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxgItensLOCFIS: TcxDBEditorRow
            Properties.Caption = 'Localiza'#231#227'o F'#237'sica'
            Properties.DataBinding.FieldName = 'ITE_LOCFIS'
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
        end
      end
    end
  end
  object dtsItens: TDataSource
    Left = 280
    Top = 88
  end
  object cxsGrid: TcxStyleRepository
    Left = 280
    Top = 40
    PixelsPerInch = 96
    object cxsColFix: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxsMes1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxsMes2: TcxStyle
    end
    object cxsMes3: TcxStyle
    end
    object cxsMes4: TcxStyle
    end
    object cxsMes5: TcxStyle
    end
    object cxsMes6: TcxStyle
    end
    object cxsMes7: TcxStyle
    end
    object cxsMes8: TcxStyle
    end
    object cxsMes9: TcxStyle
    end
    object cxsMes10: TcxStyle
    end
    object cxsMes11: TcxStyle
    end
    object cxsMes12: TcxStyle
    end
    object cxsVenMes: TcxStyle
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
