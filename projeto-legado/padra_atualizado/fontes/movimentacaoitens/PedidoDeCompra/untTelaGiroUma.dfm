object frmTelaGiroUma: TfrmTelaGiroUma
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmTelaGiroUma'
  ClientHeight = 282
  ClientWidth = 1280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLegenda: TPanel
    Left = 0
    Top = 254
    Width = 1280
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Shape1: TShape
      Left = 12
      Top = 6
      Width = 14
      Height = 14
      Brush.Color = clRed
    end
    object Label1: TLabel
      Left = 29
      Top = 6
      Width = 189
      Height = 13
      Caption = 'Meses utilizados para m'#233'dia e sugest'#227'o'
    end
    object lblListaMesesGiro: TLabel
      Left = 232
      Top = 6
      Width = 159
      Height = 14
      Cursor = crHandPoint
      Caption = 'An'#225'lise de promo'#231#227'o do giro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = lblListaMesesGiroClick
    end
    object Label2: TLabel
      Left = 464
      Top = 7
      Width = 171
      Height = 13
      Caption = '(*) M'#234's com venda(s) em Promo'#231#227'o'
      Visible = False
    end
  end
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 1280
    Height = 254
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object cxvGridGiro1: TcxVerticalGrid
      Left = 0
      Top = 0
      Width = 169
      Height = 254
      BorderStyle = cxcbsNone
      Align = alLeft
      OptionsView.ScrollBars = ssNone
      OptionsView.RowHeaderWidth = 77
      OptionsData.Editing = False
      Styles.Header = cxsColFix
      TabOrder = 0
      Version = 1
      object cxcMesGir1: TcxCategoryRow
        Properties.Caption = 'Meses de Giro'
        Properties.HeaderAlignmentHorz = taCenter
        Styles.Header = cxsColFix
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxgItensVENMES: TcxEditorRow
        Properties.Caption = 'M'#234's Atual'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsVenMes
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxgItensQ_V_01: TcxEditorRow
        Properties.Caption = 'M'#234's 1'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes1
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxgItensQ_V_02: TcxEditorRow
        Properties.Caption = 'M'#234's 2'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes2
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxgItensQ_V_03: TcxEditorRow
        Properties.Caption = 'M'#234's 3'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes3
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxgItensQ_V_04: TcxEditorRow
        Properties.Caption = 'M'#234's 4'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes4
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxgItensQ_V_05: TcxEditorRow
        Properties.Caption = 'M'#234's 5'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes5
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxgItensQ_V_06: TcxEditorRow
        Properties.Caption = 'M'#234's 6'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes6
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
    end
    object cxvGridGiro2: TcxVerticalGrid
      Left = 169
      Top = 0
      Width = 169
      Height = 254
      BorderStyle = cxcbsNone
      Align = alLeft
      OptionsView.ScrollBars = ssNone
      OptionsView.RowHeaderWidth = 71
      OptionsData.Editing = False
      Styles.Header = cxsColFix
      TabOrder = 1
      Version = 1
      object cxcMesGir2: TcxCategoryRow
        Properties.Caption = 'Meses de Giro'
        Properties.HeaderAlignmentHorz = taCenter
        Styles.Header = cxsColFix
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxgItensBranco: TcxEditorRow
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxgItensQ_V_07: TcxEditorRow
        Properties.Caption = 'M'#234's 7'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes7
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxgItensQ_V_08: TcxEditorRow
        Properties.Caption = 'M'#234's 8'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes8
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxgItensQ_V_09: TcxEditorRow
        Properties.Caption = 'M'#234's 9'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes9
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxgItensQ_V_10: TcxEditorRow
        Properties.Caption = 'M'#234's 10'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes10
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxgItensQ_V_11: TcxEditorRow
        Properties.Caption = 'M'#234's 11'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes11
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxgItensQ_V_12: TcxEditorRow
        Properties.Caption = 'M'#234's 12'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsMes12
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
    end
    object cxvSugest: TcxVerticalGrid
      Left = 338
      Top = 0
      Width = 215
      Height = 254
      BorderStyle = cxcbsNone
      Align = alLeft
      OptionsView.ScrollBars = ssNone
      OptionsView.RowHeaderWidth = 123
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.GoToNextCellOnTab = True
      Styles.Header = cxsColFix
      TabOrder = 2
      OnKeyPress = cxvSugestKeyPress
      Version = 1
      object cxcSugest: TcxCategoryRow
        Properties.Caption = 'Sugest'#227'o'
        Properties.HeaderAlignmentHorz = taCenter
        Styles.Header = cxsColFix
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxgItensMEDIA_: TcxEditorRow
        Properties.Caption = 'M'#233'dia de Vendas'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxgItensMEDIXX: TcxEditorRow
        Properties.Caption = 'M'#233'dia XX'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxgItensMEDAJU: TcxEditorRow
        Properties.Caption = 'M'#233'dia XX Ajustada '
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxgItensSALCOT: TcxEditorRow
        Properties.Caption = 'Saldo Cota'#231#227'o'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        Styles.Content = cxsDestaque
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxgItensSALBAS: TcxEditorRow
        Properties.Caption = 'Sal. Base Compra'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        Styles.Header = cxsBold
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxgItensSUGEST: TcxEditorRow
        Properties.Caption = 'Sugest'#227'o Compra'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        Styles.Header = cxsBold
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxgItensESTMAX: TcxEditorRow
        Properties.Caption = 'Estoque M'#225'ximo'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.EditProperties.OnValidate = cxgItensESTMAXEditPropertiesValidate
        Properties.DataBinding.ValueType = 'Float'
        Properties.Value = Null
        Styles.Content = cxsEdicao
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object cxgItensESTMIN: TcxEditorRow
        Properties.Caption = 'Estoque M'#237'nimo'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.EditProperties.OnValidate = cxgItensESTMINEditPropertiesValidate
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsEdicao
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
      object cxgItensESIMDG: TcxEditorRow
        Properties.Caption = 'Opc. Estoq. M'#237'nimo'
        Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
        Properties.EditProperties.Alignment.Horz = taCenter
        Properties.EditProperties.DropDownListStyle = lsFixedList
        Properties.EditProperties.ImmediatePost = True
        Properties.EditProperties.Items.Strings = (
          'Gerado'
          'Digitado')
        Properties.EditProperties.OnValidate = cxgItensESIMDGEditPropertiesValidate
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsEdicao
        ID = 9
        ParentID = -1
        Index = 9
        Version = 1
      end
      object cxgItensPONPED: TcxEditorRow
        Properties.Caption = 'Ponto Pedido'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 10
        ParentID = -1
        Index = 10
        Version = 1
      end
      object cxgItensMLTCOM: TcxEditorRow
        Properties.Caption = 'M'#250'ltiplo de Compra'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 11
        ParentID = -1
        Index = 11
        Version = 1
      end
      object cxgItensQTDEMB: TcxEditorRow
        Properties.Caption = 'Embalagem'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 12
        ParentID = -1
        Index = 12
        Version = 1
      end
    end
    object cxvSaldos: TcxVerticalGrid
      Left = 553
      Top = 0
      Width = 239
      Height = 254
      BorderStyle = cxcbsNone
      Align = alLeft
      OptionsView.ScrollBars = ssNone
      OptionsView.RowHeaderWidth = 140
      OptionsData.Editing = False
      Styles.Header = cxsColFix
      TabOrder = 3
      Version = 1
      object cxcSaldos: TcxCategoryRow
        Properties.Caption = 'Saldos'
        Properties.HeaderAlignmentHorz = taCenter
        Styles.Header = cxsColFix
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxgItensSALFIS: TcxEditorRow
        Properties.Caption = 'Saldo F'#237'sico'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxgItensSALGAR: TcxEditorRow
        Properties.Caption = 'Reservado Garantia'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxgItensSALRES: TcxEditorRow
        Properties.Caption = 'Reservado Pedido Venda'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxgItensSALEND: TcxEditorRow
        Properties.Caption = 'Reserv. Endere'#231'amento'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxgItensORDPRO: TcxEditorRow
        Properties.Caption = 'Ordem de Produ'#231#227'o'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxgItensFUTPRE: TcxEditorRow
        Properties.Caption = 'Entr. Futura Previs'#227'o'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxgItensFUTFAL: TcxEditorRow
        Properties.Caption = 'Entr. Futura Falta'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object cxgItensFUTAGU: TcxEditorRow
        Properties.Caption = 'Entr. Fut. Aguar. Cliente'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
      object cxgItensSALEXT: TcxEditorRow
        Properties.Caption = 'Reservado Externo '
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.EditProperties.UseLeftAlignmentOnEditing = False
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        ID = 9
        ParentID = -1
        Index = 9
        Version = 1
      end
      object cxgItensSALDIS: TcxEditorRow
        Properties.Caption = 'Saldo Dispon'#237'vel'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.EditProperties.UseLeftAlignmentOnEditing = False
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Header = cxsBold
        ID = 10
        ParentID = -1
        Index = 10
        Version = 1
      end
      object cxgItensQTDPEN: TcxEditorRow
        Properties.Caption = 'Pedido Compra Pendente'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        Styles.Content = cxsDestaque
        ID = 11
        ParentID = -1
        Index = 11
        Version = 1
      end
      object cxvSaldosSALTRA: TcxEditorRow
        Properties.Caption = 'Transf. Estoq. - Ag. Fat.'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = Null
        ID = 12
        ParentID = -1
        Index = 12
        Version = 1
      end
      object cxgItensVENPER: TcxEditorRow
        Properties.Caption = 'Vendas Perdidas'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DecimalPlaces = 3
        Properties.EditProperties.DisplayFormat = '#,##0.000;-#,##0.000'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = Null
        ID = 14
        ParentID = -1
        Index = 13
        Version = 1
      end
    end
    object Panel2: TPanel
      Left = 792
      Top = 0
      Width = 488
      Height = 254
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 4
      object pnlOutrasTop: TPanel
        Left = 0
        Top = 0
        Width = 488
        Height = 54
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object cxVerticalGrid2: TcxVerticalGrid
          Left = 256
          Top = 0
          Width = 233
          Height = 54
          BorderStyle = cxcbsNone
          Align = alLeft
          OptionsView.ScrollBars = ssNone
          OptionsView.RowHeaderWidth = 119
          OptionsData.Editing = False
          Styles.Header = cxsColFix
          TabOrder = 0
          Version = 1
          object cxcOutras2: TcxCategoryRow
            Styles.Header = cxsColFix
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxgItensCODBAR: TcxEditorRow
            Properties.Caption = 'C'#243'digo de Barras'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
        end
        object cxVerticalGrid4: TcxVerticalGrid
          Left = 0
          Top = 0
          Width = 256
          Height = 54
          BorderStyle = cxcbsNone
          Align = alLeft
          OptionsView.ScrollBars = ssNone
          OptionsView.RowHeaderWidth = 164
          OptionsData.Editing = False
          Styles.Header = cxsColFix
          TabOrder = 1
          Version = 1
          object cxcOutras1: TcxCategoryRow
            Properties.Caption = 'Outras Informa'#231#245'es'
            Properties.HeaderAlignmentHorz = taCenter
            Styles.Header = cxsColFix
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxgItensNVLGIR: TcxEditorRow
            Properties.Caption = 'N'#237'vel Giro e Critic.'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            Properties.OnGetDisplayText = cxgItensNVLGIR2PropertiesGetDisplayText
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxgItensLOCFIS: TcxEditorRow
            Properties.Caption = 'Localiza'#231#227'o F'#237'sica'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 54
        Width = 488
        Height = 200
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        object cxVerticalGrid5: TcxVerticalGrid
          Left = 0
          Top = 0
          Width = 488
          Height = 18
          BorderStyle = cxcbsNone
          Align = alTop
          OptionsView.ScrollBars = ssNone
          OptionsView.RowHeaderWidth = 164
          OptionsData.Editing = False
          Styles.Header = cxsColFix
          TabOrder = 0
          Version = 1
          object cxgitensNOMFOR: TcxEditorRow
            Properties.Caption = 'Fornecedor da '#218'ltima Compra'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
        end
        object cxVerticalGrid8: TcxVerticalGrid
          Left = 0
          Top = 18
          Width = 256
          Height = 182
          BorderStyle = cxcbsNone
          Align = alLeft
          OptionsView.ScrollBars = ssNone
          OptionsView.RowHeaderWidth = 164
          OptionsData.Editing = False
          Styles.Header = cxsColFix
          TabOrder = 1
          Version = 1
          object cxgItennDIAUCO: TcxEditorRow
            Properties.Caption = #218'ltima Compra (Dias)'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.EditProperties.DecimalPlaces = 0
            Properties.EditProperties.DisplayFormat = '#,##0;-#,##0'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxgItensDTAULT: TcxEditorRow
            Properties.Caption = 'Data da '#218'ltima Compra'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxgItensPREULT: TcxEditorRow
            Properties.Caption = 'Pre'#231'o de '#218'ltima Compra'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxgItensIMPULT: TcxEditorRow
            Properties.Caption = 'Pre'#231'o de '#218'ltima Compra + Imp'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxgItensQTDUCO: TcxEditorRow
            Properties.Caption = 'Quantidade '#218'ltima Compra'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxgItensDIAEST: TcxEditorRow
            Properties.Caption = 'Dias de Estoque'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.EditProperties.DecimalPlaces = 0
            Properties.EditProperties.DisplayFormat = '#,##0;-#,##0'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            Properties.OnGetDisplayText = cxgItensDIAESTPropertiesGetDisplayText
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object cxgItensDIASUG: TcxEditorRow
            Properties.Caption = 'Dias Est. Qtd. Comprada'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.EditProperties.DecimalPlaces = 0
            Properties.EditProperties.DisplayFormat = '#,##0;-#,##0'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            Properties.OnGetDisplayText = cxgItensDIASUGPropertiesGetDisplayText
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object cxgItensPMED_V: TcxEditorRow
            Properties.Caption = 'Pre'#231'o M'#233'dio Venda'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = ''
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object cxgItensPESOIT: TcxEditorRow
            Properties.Caption = 'Peso Total'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object cxItensPONEXP: TcxEditorRow
            Properties.Caption = 'Ponto Exposi'#231#227'o Total'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
        end
        object cxvUltimaVenda: TcxVerticalGrid
          Left = 256
          Top = 18
          Width = 233
          Height = 182
          BorderStyle = cxcbsNone
          Align = alLeft
          OptionsView.ScrollBars = ssNone
          OptionsView.RowHeaderWidth = 120
          OptionsData.Editing = False
          Styles.Header = cxsColFix
          TabOrder = 2
          Version = 1
          object cxgItensDIAUVE: TcxEditorRow
            Properties.Caption = #218'ltima Venda (Dias)'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.EditProperties.DecimalPlaces = 0
            Properties.EditProperties.DisplayFormat = '#,##0;-#,##0'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxgItensDTAUVE: TcxEditorRow
            Properties.Caption = 'Data '#218'ltima Venda'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxgItensMADTSA: TcxEditorRow
            Properties.Caption = 'Data Maior Venda'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxgItensMAQTSA: TcxEditorRow
            Properties.Caption = 'Quant. Maior Venda'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taRightJustify
            Properties.EditProperties.DisplayFormat = '#,##0.00;-#,##0.00'
            Properties.DataBinding.ValueType = 'String'
            Properties.Value = Null
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
        end
      end
    end
    object Panel1: TPanel
      Left = -2
      Top = 147
      Width = 173
      Height = 38
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 5
      object lblSalbas: TLabel
        Left = 6
        Top = 0
        Width = 145
        Height = 14
        Cursor = crHandPoint
        Caption = 'Demo. Saldo Base Compra'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = lblSalbasClick
      end
    end
  end
  object cxsGrid: TcxStyleRepository
    Left = 272
    Top = 64
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
    object cxsBold: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxsDestaque: TcxStyle
      AssignedValues = [svColor]
      Color = clAqua
    end
    object cxsEdicao: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
end
