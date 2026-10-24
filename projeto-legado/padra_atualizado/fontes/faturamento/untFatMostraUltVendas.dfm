inherited frmFatMostraUltVendas: TfrmFatMostraUltVendas
  Left = 86
  Top = 66
  Width = 1024
  Height = 453
  BorderStyle = bsSizeable
  Caption = 'Ultimas vendas do Item'
  Position = poMainFormCenter
  ExplicitWidth = 1024
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 196
    Width = 1008
    TabOrder = 5
    ExplicitTop = 196
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 398
    Width = 1008
    TabOrder = 4
    ExplicitTop = 398
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
  inherited pgcDados: TPageControl
    Width = 1008
    Height = 196
    TabOrder = 3
    ExplicitWidth = 1008
    ExplicitHeight = 196
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1000
      ExplicitHeight = 164
    end
  end
  object pnlBotoesMostra: TPanel [3]
    Left = 0
    Top = 369
    Width = 1008
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    DesignSize = (
      1008
      29)
    object btnFechar: TBitBtnLocked
      Left = 924
      Top = 4
      Width = 77
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = '&Fechar'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
  object pnlProduto: TPanel [4]
    Left = 0
    Top = 196
    Width = 1008
    Height = 31
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      1008
      31)
    object Label1: TLabel
      Left = 27
      Top = 13
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbeDescri: TDBEditFocus
      Left = 90
      Top = 5
      Width = 910
      Height = 22
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      DataField = 'DET_DESCRI'
      DataSource = dtsUltVen
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlVenPer: TPanel [5]
    Left = 0
    Top = 227
    Width = 1008
    Height = 142
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      1008
      142)
    object Label2: TLabel
      Left = 44
      Top = 43
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 67
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shp5: TShape
      Left = 257
      Top = 12
      Width = 12
      Height = 12
      Brush.Color = clYellow
    end
    object lbl5: TLabel
      Left = 274
      Top = 11
      Width = 82
      Height = 14
      Caption = 'Vendas Perdidas'
    end
    object dbeMotVpd: TDBEditFocus
      Left = 90
      Top = 35
      Width = 910
      Height = 22
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      DataField = 'MOTVPD'
      DataSource = dtsUltVen
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkExiVenPer: TCheckBox
      Left = 90
      Top = 9
      Width = 158
      Height = 17
      Caption = 'Exibir Vendas Perdidas'
      Checked = True
      Color = 16770261
      ParentColor = False
      State = cbChecked
      TabOrder = 1
      OnClick = chkExiVenPerClick
    end
    object dbeObsVpd: TDBMemoFocus
      Left = 90
      Top = 61
      Width = 910
      Height = 73
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      DataField = 'OBSVPD'
      DataSource = dtsUltVen
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object cxGrid1: TcxGrid [6]
    Left = 0
    Top = 0
    Width = 1008
    Height = 196
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGrid1DBUltVendas: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGrid1DBUltVendasCustomDrawCell
      OnEditKeyDown = cxGrid1DBUltVendasEditKeyDown
      DataController.DataSource = dtsUltVen
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'N'#227'o existe registros'
      OptionsView.GroupByBox = False
      object cxGrid1DBUltVendasDTAENT: TcxGridDBColumn
        Caption = 'Data Entrada'
        DataBinding.FieldName = 'DET_DTAENT'
        Options.Editing = False
        Options.Focusing = False
        Width = 70
      end
      object cxGrid1DBUltVendasCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'DET_CODEMP'
        Options.Editing = False
        Options.Focusing = False
        Width = 49
      end
      object cxGrid1DBUltVendasNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DET_NUMDOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 80
      end
      object cxGrid1DBUltVendasESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'DET_ESPDOC'
        Options.Editing = False
        Options.Focusing = False
        Width = 44
      end
      object cxGrid1DBUltVendasCLAFIS: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'DET_CLAFIS'
        Options.Editing = False
        Options.Focusing = False
        Width = 38
      end
      object cxGrid1DBUltVendasCODVEN: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'DET_CODVEN'
        Options.Editing = False
        Options.Focusing = False
        Width = 54
      end
      object cxGrid1DBUltVendasDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Item'
        DataBinding.FieldName = 'DET_DESCRI'
        Options.Editing = False
        Options.Focusing = False
        Width = 309
      end
      object cxGrid1DBUltVendasQTDITE: TcxGridDBColumn
        Caption = 'Qtde'
        DataBinding.FieldName = 'DET_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
        Options.Focusing = False
        Width = 50
      end
      object cxGrid1DBUltVendasUNIORI: TcxGridDBColumn
        Caption = 'Vr.Bruto'
        DataBinding.FieldName = 'DET_UNIORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxGrid1DBUltVendasDESCON: TcxGridDBColumn
        Caption = 'Desc.(%)'
        DataBinding.FieldName = 'DET_DESCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
        Options.Focusing = False
        Width = 60
      end
      object cxGrid1DBUltVendasUNILIQ: TcxGridDBColumn
        Caption = 'Vr.L'#237'quido'
        DataBinding.FieldName = 'DET_UNILIQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxGrid1DBUltVendasDET_VALIPI: TcxGridDBColumn
        Caption = 'IPI'
        DataBinding.FieldName = 'DET_VALIPI'
      end
      object cxGrid1DBUltVendasDET_VALRET: TcxGridDBColumn
        Caption = 'ST'
        DataBinding.FieldName = 'DET_VALRET'
      end
      object cxGrid1DBUltVendasDET_VFCPST: TcxGridDBColumn
        Caption = 'FCP-ST'
        DataBinding.FieldName = 'DET_VFCPST'
      end
      object cxGrid1DBUltVendasDET_TOTFRE: TcxGridDBColumn
        Caption = 'Frete'
        DataBinding.FieldName = 'DET_TOTFRE'
      end
      object cxGrid1DBUltVendasDET_VLRCON: TcxGridDBColumn
        Caption = 'Valor Cont'#225'bil'
        DataBinding.FieldName = 'DET_VLRCON'
        Width = 77
      end
      object cxGrid1DBUltVendasNOMCON: TcxGridDBColumn
        Caption = 'Consumidor'
        DataBinding.FieldName = 'NOMCON'
        Options.Editing = False
        Options.Focusing = False
        Width = 200
      end
      object cxGrid1DBUltVendasENDCON: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'ENDCON'
        Options.Editing = False
        Options.Focusing = False
        Width = 250
      end
      object cxGrid1DBUltVendasCGCCON: TcxGridDBColumn
        Caption = 'CNPJ/CPF'
        DataBinding.FieldName = 'CGCCON'
        PropertiesClassName = 'TcxMaskEditProperties'
        Options.Editing = False
        Options.Focusing = False
        Width = 105
      end
      object cxGrid1DBUltVendasNOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'NOMCID'
        Options.Editing = False
        Options.Focusing = False
        Width = 150
      end
      object cxGrid1DBUltVendasESTCON: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'ESTCON'
        Options.Editing = False
        Options.Focusing = False
        Width = 30
      end
      object cxGrid1DBUltVendasVENPER: TcxGridDBColumn
        DataBinding.FieldName = 'VENPER'
        Visible = False
      end
      object cxGrid1DBUltVendasCFG_UNIORI: TcxGridDBColumn
        Caption = 'Vr.Tabela'
        DataBinding.FieldName = 'CFG_UNIORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Visible = False
        Options.Editing = False
        Options.Focusing = False
        Width = 69
      end
      object cxGrid1DBUltVendasCFG_UNITAR: TcxGridDBColumn
        Caption = 'Vr.Praticado'
        DataBinding.FieldName = 'CFG_UNITAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Visible = False
        Options.Editing = False
        Options.Focusing = False
        Width = 73
      end
      object cxGrid1DBUltVendasCFG_DESESP: TcxGridDBColumn
        Caption = 'Desc.Especial'
        DataBinding.FieldName = 'CFG_DESESP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Visible = False
        Options.Editing = False
        Options.Focusing = False
        Width = 82
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBUltVendas
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 552
    Top = 320
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 312
  end
  object dtsUltVen: TDataSource
    Left = 488
    Top = 320
  end
end
