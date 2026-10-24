inherited frmDigFinanceira: TfrmDigFinanceira
  Width = 601
  Height = 448
  Caption = 'Selecione a Financeira'
  ExplicitWidth = 601
  ExplicitHeight = 448
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 595
    ExplicitTop = 377
    ExplicitWidth = 595
    inherited FlwBotoes: TFlowPanel
      Width = 514
      TabOrder = 0
      ExplicitWidth = 591
      ExplicitHeight = 22
      inherited btnConfirma: TBitBtnLocked
        Width = 121
        Caption = '[ F10 ] Confirma'
        ExplicitWidth = 121
      end
      object btnExcluir: TBitBtnLocked
        Left = 121
        Top = 0
        Width = 72
        Height = 22
        Caption = '&Excluir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 516
      Top = 2
      Align = alRight
      TabOrder = 1
      ExplicitLeft = 512
      ExplicitTop = 1
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 41
    Width = 595
    Height = 113
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 48
      Top = 41
      Width = 53
      Height = 14
      Caption = 'Financeira:'
    end
    object Label2: TLabel
      Left = 247
      Top = 65
      Width = 45
      Height = 14
      Caption = 'Parcelas:'
    end
    object Label3: TLabel
      Left = 7
      Top = 89
      Width = 94
      Height = 14
      Caption = 'Valor da Opera'#231#227'o:'
    end
    object Label4: TLabel
      Left = 209
      Top = 89
      Width = 82
      Height = 14
      Caption = 'Valor da Parcela:'
    end
    object Label8: TLabel
      Left = 18
      Top = 65
      Width = 83
      Height = 14
      Caption = 'Valor Financiado:'
    end
    object lblValAdt: TLabel
      Left = 5
      Top = 14
      Width = 96
      Height = 14
      Caption = 'Valor Adiantamento:'
    end
    object edtCodFin: TEditFocus
      Tag = 99
      Left = 103
      Top = 33
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 1
      OnKeyPress = edtCodFinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesFin: TEditFocus
      Left = 194
      Top = 33
      Width = 329
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbxQtdPar: TComboBoxFocus
      Tag = 99
      Left = 294
      Top = 57
      Width = 90
      Height = 22
      Style = csDropDownList
      TabOrder = 4
      OnChange = cbxQtdParChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtValOpe: TEditFocus
      Left = 103
      Top = 81
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValPar: TEditFocus
      Left = 294
      Top = 81
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValFin: TEditFocus
      Tag = 99
      Left = 103
      Top = 57
      Width = 90
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object btnGravar: TBitBtnLocked
      Left = 462
      Top = 58
      Width = 60
      Height = 20
      Caption = '&Gravar'
      TabOrder = 6
      OnClick = btnGravarClick
    end
    object btnCartoes: TBitBtnLocked
      Left = 390
      Top = 58
      Width = 60
      Height = 20
      Caption = '&Cart'#245'es'
      TabOrder = 5
      OnClick = btnCartoesClick
    end
    object edtValAdt: TEditFocus
      Tag = 99
      Left = 103
      Top = 9
      Width = 90
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 595
    Height = 41
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 3
    object Label7: TLabel
      Left = 60
      Top = 17
      Width = 40
      Height = 14
      Caption = 'Entrada:'
    end
    object Label5: TLabel
      Left = 349
      Top = 17
      Width = 80
      Height = 14
      Caption = 'Total Financiado:'
    end
    object edtEntrada: TEditFocus
      Left = 103
      Top = 9
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtTotFin: TEditFocus
      Left = 433
      Top = 9
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgFinan: TcxGrid [4]
    Left = 0
    Top = 154
    Width = 595
    Height = 223
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgFinanView: TcxGridDBTableView
      OnKeyDown = cxgFinanViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = dtsFinanc
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'FIN_VALFIN'
          Column = cxgFinanViewColumn1
          DisplayText = 'Total'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'FIN_VALOPE'
          Column = cxgFinanViewColumn4
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxgFinanViewColumn2: TcxGridDBColumn
        Caption = 'Financeira'
        DataBinding.FieldName = 'FIN_CODFIN'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'FIN_CODIGO'
        Properties.ListColumns = <
          item
            FieldName = 'FIN_DESCRI'
          end>
        Properties.ListSource = dtsLisFin
        Width = 168
      end
      object cxgFinanViewColumn1: TcxGridDBColumn
        Caption = 'Valor Financiado'
        DataBinding.FieldName = 'FIN_VALFIN'
        HeaderAlignmentHorz = taRightJustify
        Width = 91
      end
      object cxgFinanViewColumn3: TcxGridDBColumn
        Caption = 'Qtd. Parcelas'
        DataBinding.FieldName = 'FIN_QTDPAR'
        HeaderAlignmentHorz = taRightJustify
        Width = 74
      end
      object cxgFinanViewColumn4: TcxGridDBColumn
        Caption = 'Valor da Opera'#231#227'o'
        DataBinding.FieldName = 'FIN_VALOPE'
        HeaderAlignmentHorz = taRightJustify
        Width = 101
      end
      object cxgFinanViewColumn5: TcxGridDBColumn
        Caption = 'Valor da Parcela'
        DataBinding.FieldName = 'FIN_VALPAR'
        HeaderAlignmentHorz = taRightJustify
        Width = 88
      end
      object cxgFinanViewColumn6: TcxGridDBColumn
        Caption = 'Cart'#245'es'
        DataBinding.FieldName = 'FIN_DIGCAR'
        HeaderAlignmentHorz = taCenter
        Width = 52
      end
    end
    object cxgFinanLevel1: TcxGridLevel
      GridView = cxgFinanView
    end
  end
  inherited pnlStatus: TPanel
    Top = 403
    Width = 595
    ExplicitTop = 403
    ExplicitWidth = 595
    inherited pnlNomeForm: TPanel
      Left = 424
      ExplicitLeft = 424
    end
    inherited pnlInfo: TPanel
      Width = 424
      ExplicitWidth = 424
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 208
  end
  object dtsFinanc: TDataSource
    DataSet = cdsSelFin
    Left = 360
    Top = 208
  end
  object cdsSelFin: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    IndexFieldNames = 'FIN_CODFIN'
    Params = <>
    AfterPost = cdsSelFinAfterPost
    Left = 328
    Top = 208
    object cdsSelFinFIN_TOTFIN: TAggregateField
      FieldName = 'FIN_TOTFIN'
      Active = True
      DisplayName = ''
      Expression = 'SUM(FIN_VALFIN)'
    end
    object cdsSelFinFIN_TOTOPE: TAggregateField
      FieldName = 'FIN_TOTOPE'
      Active = True
      DisplayName = ''
      Expression = 'SUM(FIN_VALOPE)'
    end
    object cdsSelFinFIN_TOTADT: TAggregateField
      FieldName = 'FIN_TOTADT'
      Active = True
      DisplayName = ''
      Expression = 'SUM(FIN_VALADT)'
    end
  end
  object dtsLisFin: TDataSource
    Left = 408
    Top = 208
  end
end
