inherited frmFatAltDataPrevisaoPD: TfrmFatAltDataPrevisaoPD
  Height = 436
  Caption = 'Altera'#231#227'o da Data de Previs'#227'o do Pedido de Venda'
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 355
    Height = 26
    TabOrder = 2
    TabStop = True
    ExplicitTop = 355
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 636
      Height = 22
      ExplicitTop = 2
      inherited btnPesquisar: TBitBtnLocked
        Width = 118
        ExplicitWidth = 118
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 638
      Top = 2
      Align = alRight
      Caption = '&Sair'
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
      ExplicitLeft = 637
    end
  end
  inherited pnlHeader: TPanel
    Height = 62
    TabOrder = 0
    ExplicitHeight = 62
    object Label2: TLabel
      Left = 11
      Top = 38
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
    end
    object lbl1: TLabel
      Left = 179
      Top = 38
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
    end
    object lbl6: TLabel
      Left = 326
      Top = 10
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 341
      Top = 40
      Width = 35
      Height = 14
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 69
      Top = 35
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 232
      Top = 35
      Width = 66
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 382
      Top = 7
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodVenExit
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesVen: TEditFocus
      Left = 442
      Top = 7
      Width = 275
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 382
      Top = 37
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 5
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 442
      Top = 37
      Width = 275
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgDatas: TRadioGroup
      Left = 11
      Top = -4
      Width = 287
      Height = 33
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        '(DATA DE ENTRADA)'
        '(DATA DE PREVIS'#195'O)')
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited pnlTail: TPanel
    Top = 307
    TabOrder = 4
    ExplicitTop = 305
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 102
    Height = 205
    TabStop = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    Columns = <
      item
        Expanded = False
        FieldName = 'FGO_DTAENT'
        ReadOnly = True
        Title.Caption = 'Entrada'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_NUMDOC'
        ReadOnly = True
        Title.Caption = 'Documento'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_ESPDOC'
        ReadOnly = True
        Title.Caption = 'Esp.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_CODEMP'
        ReadOnly = True
        Title.Caption = 'Emp.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_CODCLI'
        ReadOnly = True
        Title.Caption = 'C'#243'd.Cliente'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_NOMCLI'
        ReadOnly = True
        Title.Caption = 'Cliente'
        Width = 204
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_CODVEN'
        ReadOnly = True
        Title.Caption = 'Vend.'
        Width = 30
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'FGO_VLRCON'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FGO_PREVIS'
        Title.Caption = 'Previs'#227'o'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 62
    TabOrder = 1
    ExplicitTop = 62
  end
  inherited pnlStatus: TPanel
    Top = 381
    TabOrder = 5
    ExplicitTop = 381
    inherited pnlInfo: TPanel
      object shpMultSel: TShape
        Left = 528
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas desta tela possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
    Top = 224
  end
  inherited qryConsulta: TUniQuery
    Left = 568
    Top = 224
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 600
    Top = 224
  end
  inherited cdsConsulta: TUniClientDataSet
    BeforePost = cdsConsultaBeforePost
    AfterPost = cdsConsultaAfterPost
    Left = 632
    Top = 224
  end
  inherited dtsConsulta: TDataSource
    Left = 664
    Top = 224
  end
end
