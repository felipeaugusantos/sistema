inherited frmCadastraContagemEdicao: TfrmCadastraContagemEdicao
  Width = 930
  Height = 524
  BorderStyle = bsSizeable
  Caption = 'Cadastramento de contagem de estoque'
  Position = poScreenCenter
  ExplicitWidth = 930
  ExplicitHeight = 524
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 443
    Width = 914
    TabOrder = 2
    ExplicitTop = 443
    ExplicitWidth = 914
    inherited FlwBotoes: TFlowPanel
      Width = 910
      ExplicitTop = 2
      ExplicitWidth = 910
      inherited btnConfirma: TBitBtnLocked
        Width = 119
        Caption = '[ F10 ] Confirma'
        ExplicitWidth = 119
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 833
      TabOrder = 2
      ExplicitLeft = 833
    end
    object btnExcluir: TBitBtnLocked
      Left = 375
      Top = 3
      Width = 154
      Height = 22
      Caption = '[ DEL ] Excluir contagem'
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
  inherited pnlStatus: TPanel
    Top = 469
    Width = 914
    TabOrder = 3
    ExplicitTop = 469
    ExplicitWidth = 914
    inherited pnlNomeForm: TPanel
      Left = 743
      ExplicitLeft = 743
    end
    inherited pnlInfo: TPanel
      Width = 743
      ExplicitWidth = 743
    end
  end
  object pnlTopo: TPanel [3]
    Left = 0
    Top = 0
    Width = 914
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 63
      Top = 30
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object lblLocFis: TLabel
      Left = 11
      Top = 55
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Localiza'#231#227'o F'#237'sica:'
    end
    object lbl3: TLabel
      Left = 462
      Top = 30
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Validade:'
    end
    object Label8: TLabel
      Left = 516
      Top = 53
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 105
      Top = 26
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 163
      Top = 26
      Width = 285
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 105
      Top = 49
      Width = 134
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 2
      OnExit = edtLocFisExit
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaVal: TMaskEditFocus
      Tag = 99
      Left = 548
      Top = 26
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 548
      Top = 49
      Width = 88
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.000'
    end
  end
  object cxgItens: TcxGrid [4]
    Left = 0
    Top = 89
    Width = 914
    Height = 352
    Align = alClient
    TabOrder = 1
    object cxvItens: TcxGridDBTableView
      OnKeyDown = cxvItensKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '< Nenhum item digitado >'
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxsZebra
      object cxvItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Produto'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
      end
      object cxvItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 356
      end
      object cxvItensDTAVAL: TcxGridDBColumn
        Caption = 'Validade'
        DataBinding.FieldName = 'DTAVAL'
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 71
      end
      object cxvItensLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
        Width = 149
      end
      object cxvItensQTDCON: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'DIGCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '#,##0.000;-#,##0.000'
        HeaderAlignmentHorz = taRightJustify
        Width = 105
      end
      object cxvItensNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Width = 127
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 376
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 336
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 120
    Top = 152
    PixelsPerInch = 96
    object cxsZebra: TcxStyle
      AssignedValues = [svColor]
      Color = 13882323
    end
  end
end
