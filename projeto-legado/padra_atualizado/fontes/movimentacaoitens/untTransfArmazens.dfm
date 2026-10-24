inherited frmTransfArmazens: TfrmTransfArmazens
  Width = 1024
  Height = 766
  BorderStyle = bsSizeable
  Caption = 'Transfer'#234'ncia entre Armaz'#233'ns'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 766
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 685
    Width = 1008
    TabOrder = 3
    ExplicitTop = 685
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      inherited btnConfirma: TBitBtnLocked
        Width = 115
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        ModalResult = 0
        ExplicitWidth = 115
      end
      object shpLiberado: TShape
        AlignWithMargins = True
        Left = 115
        Top = 2
        Width = 9
        Height = 18
        Margins.Left = 0
        Margins.Top = 2
        Margins.Right = 4
        Margins.Bottom = 2
        Align = alLeft
      end
      object btnExcluir: TBitBtnLocked
        Left = 128
        Top = 0
        Width = 115
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
      Left = 929
      Top = 2
      Anchors = [akTop, akRight]
      ExplicitLeft = 929
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 711
    Width = 1008
    TabOrder = 4
    ExplicitTop = 711
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
  object pnlCabec: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 75
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object lblDigita: TLabel
      Left = 74
      Top = 9
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
    end
    object lblObserv: TLabel
      Left = 56
      Top = 30
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblInfoLimparFiltros: TLabel
      Left = 677
      Top = 30
      Width = 255
      Height = 42
      Caption = 
        'Quando "Limpar filtros ap'#243's consulta" estiver desmarcado, produt' +
        'os iguais com armaz'#233'ns iguais ter'#227'o suas quantidades somadas.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 121
      Top = 3
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 176
      Top = 3
      Width = 264
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse01: TEditFocus
      Tag = 99
      Left = 121
      Top = 27
      Width = 519
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtObse02: TEditFocus
      Tag = 99
      Left = 121
      Top = 50
      Width = 519
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 305
    Width = 1008
    Height = 364
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 2
    OnEnter = cxgItensEnter
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = cxgItensViewCellClick
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      OnFocusedRecordChanged = cxgItensViewFocusedRecordChanged
      DataController.DataSource = dtsGrid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 49
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 479
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Origem'
        DataBinding.FieldName = 'ARMORI'
        Width = 80
      end
      object cxgItensViewColumn8: TcxGridDBColumn
        Caption = 'Desc. Armaz. Ori.'
        DataBinding.FieldName = 'DESAMZORI'
        Width = 100
      end
      object cxgItensViewColumn9: TcxGridDBColumn
        Caption = 'Desc. Loc. Ori.'
        DataBinding.FieldName = 'DESLOCORI'
        Width = 100
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Destino'
        DataBinding.FieldName = 'ARMDES'
        Width = 80
      end
      object cxgItensViewColumn10: TcxGridDBColumn
        Caption = 'Desc. Armaz. Des.'
        DataBinding.FieldName = 'DESAMZDES'
        Width = 100
      end
      object cxgItensViewColumn11: TcxGridDBColumn
        Caption = 'Desc. Loc. Des.'
        DataBinding.FieldName = 'DESLOCDES'
        Width = 100
      end
      object cxgItensViewTAQtdItem: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensViewColumn6: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'DESMAR'
        Width = 156
      end
      object cxgItensViewColumn7: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Width = 56
      end
      object cxgItensViewTAQtdMaxDes: TcxGridDBColumn
        DataBinding.FieldName = 'MAXDES'
        Visible = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlItem: TPanel [4]
    Left = 0
    Top = 75
    Width = 1008
    Height = 230
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    OnEnter = pnlItemEnter
    OnExit = pnlItemExit
    object Label1: TLabel
      Left = 63
      Top = 6
      Width = 56
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object lblOrigem: TLabel
      Left = 26
      Top = 52
      Width = 93
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Armaz'#233'm origem:'
    end
    object lblDestino: TLabel
      Left = 355
      Top = 54
      Width = 91
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Armaz'#233'm destino:'
    end
    object Label4: TLabel
      Left = 23
      Top = 78
      Width = 96
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade:'
    end
    object lblSaldo: TLabel
      Left = 194
      Top = 76
      Width = 96
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Saldo total:'
    end
    object btnCadRapLotWMS: TSpeedButton
      Left = 190
      Top = 49
      Width = 22
      Height = 22
      Hint = '[F8] Cadastro R'#225'pido de Lotes'
      Flat = True
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000C30E0000C30E00000001000000000000006B00000073
        0000007B000000940000009C0000086B0800087B08000884080008A5080008AD
        080008B5080010731000107B10001084100010A5100010AD100010B510001873
        1800187B180018841800188C1800189C180018A5180018AD180018B51800217B
        2100218C210021942100219C210021AD210021B5210029942900299C29003194
        3100319C3100399C390039A5390039AD3900429C420042A5420042AD42004AA5
        4A004AAD4A0052A5520052AD52005AAD5A0063AD630063B563006BB56B0073BD
        73007BB57B007BBD7B0084B5840084C684008CBD8C008CC68C009CCE9C00A5D6
        A500B5DEB500FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3C3C3C3C3C
        3C3C3C3C3C3C3C3C3C3B3C340B11111112120C0C06060201323C3C0D1A1F2121
        1F201C16160E0803003C3C141F23232324393C1D17100904023C3C1B23272927
        273C3C3C1E180F08063C3C1F26292B2927283C3C3C180F0E073C3C22292B2B29
        2927253C3C3C17160D3C3C262B3C3C3C3C3C3C3C3C3C3C1C133C3C272D3C3C3C
        3C3C3C3C3C3C3C1C193C3C2B2E2E2D2B2926233C3C3C201F193C3C2B30302D2B
        29263C3C3C1F1F1F193C3C2D33312E2D2B3C3C3C22222121193C3C303733302F
        2E3A3C2929272321193C3C3138373331302F2E2D2C292721113C3C3A312F2D2B
        2B2929272623211A363C3B3C3C3C3C3C3C3C3C3C3C3C3C3C3C3B}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCadRapLotWMSClick
    end
    object Label2: TLabel
      Left = 63
      Top = 31
      Width = 56
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Marca:'
    end
    object Label3: TLabel
      Left = 526
      Top = 31
      Width = 56
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Unidade:'
    end
    object dbtAmzOri: TDBText
      Left = 213
      Top = 53
      Width = 143
      Height = 17
      DataField = 'DESAMZLOCORI'
      DataSource = dtsItens
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbtAmzDes: TDBText
      Left = 519
      Top = 53
      Width = 143
      Height = 17
      DataField = 'DESAMZLOCDES'
      DataSource = dtsItens
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 121
      Top = 3
      Width = 139
      Height = 22
      DataField = 'CODITE'
      DataSource = dtsItens
      TabOrder = 0
      OnExit = dbeCodIteExit
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesIte: TDBEditFocus
      Left = 260
      Top = 3
      Width = 380
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'DESITE'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeArmOri: TDBEditFocus
      Tag = 99
      Left = 121
      Top = 49
      Width = 67
      Height = 22
      DataField = 'ARMORI'
      DataSource = dtsItens
      TabOrder = 1
      OnKeyPress = dbeArmOriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeArmDes: TDBEditFocus
      Tag = 99
      Left = 448
      Top = 49
      Width = 67
      Height = 22
      DataField = 'ARMDES'
      DataSource = dtsItens
      TabOrder = 2
      OnKeyPress = dbeArmDesKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSaldos: TDBEditFocus
      Left = 292
      Top = 72
      Width = 95
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'SALDOS'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object grbOrigem: TGroupBox
      Left = 26
      Top = 98
      Width = 652
      Height = 62
      Caption = 'Armaz'#233'm origem:'
      TabOrder = 8
      object lblSalOri: TLabel
        Left = 19
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Saldo:'
      end
      object lblMaxOri: TLabel
        Left = 395
        Top = 16
        Width = 60
        Height = 14
        Caption = 'Capacidade:'
      end
      object lblRepOri: TLabel
        Left = 521
        Top = 16
        Width = 96
        Height = 14
        Caption = 'Ponto de reposi'#231#227'o:'
      end
      object Label7: TLabel
        Left = 149
        Top = 16
        Width = 89
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Saldo Reservado:'
      end
      object Label8: TLabel
        Left = 276
        Top = 16
        Width = 82
        Height = 14
        AutoSize = False
        Caption = 'Saldo Dispon'#237'vel:'
      end
      object dbeSalOri: TDBEditFocus
        Left = 19
        Top = 31
        Width = 110
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'SALORI'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMaxOri: TDBEditFocus
        Left = 395
        Top = 31
        Width = 111
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'MAXORI'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeRepOri: TDBEditFocus
        Left = 521
        Top = 31
        Width = 107
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'REPORI'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSalOriRes: TDBEditFocus
        Left = 149
        Top = 31
        Width = 103
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'SALORIRES'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSalOriDis: TDBEditFocus
        Left = 275
        Top = 31
        Width = 103
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'SALORIDIS'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object grbDestino: TGroupBox
      Left = 26
      Top = 160
      Width = 652
      Height = 62
      Caption = 'Armaz'#233'm destino:'
      TabOrder = 9
      object lblSalDes: TLabel
        Left = 19
        Top = 17
        Width = 30
        Height = 14
        Caption = 'Saldo:'
      end
      object lblMaxDes: TLabel
        Left = 395
        Top = 17
        Width = 60
        Height = 14
        Caption = 'Capacidade:'
      end
      object lblRepDes: TLabel
        Left = 521
        Top = 17
        Width = 96
        Height = 14
        Caption = 'Ponto de reposi'#231#227'o:'
      end
      object Label10: TLabel
        Left = 150
        Top = 17
        Width = 89
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Saldo Reservado:'
      end
      object Label11: TLabel
        Left = 276
        Top = 17
        Width = 82
        Height = 14
        AutoSize = False
        Caption = 'Saldo Dispon'#237'vel:'
      end
      object dbeSalDes: TDBEditFocus
        Left = 19
        Top = 32
        Width = 110
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'SALDES'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeMaxDes: TDBEditFocus
        Left = 395
        Top = 32
        Width = 111
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'MAXDES'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeRepDes: TDBEditFocus
        Left = 521
        Top = 32
        Width = 107
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'REPDES'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSalDesRes: TDBEditFocus
        Left = 149
        Top = 32
        Width = 103
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'SALDESRES'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSalDesDis: TDBEditFocus
        Left = 275
        Top = 32
        Width = 103
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'SALDESDIS'
        DataSource = dtsItens
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object btnAdicionar: TBitBtnLocked
      Left = 396
      Top = 72
      Width = 81
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 6
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 479
      Top = 72
      Width = 81
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 7
      OnClick = btnCancelaItemClick
    end
    object dbeQtdIte: TDBEditFocus
      Tag = 99
      Left = 121
      Top = 72
      Width = 95
      Height = 22
      DataField = 'QTDITE'
      DataSource = dtsItens
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesMar: TDBEditFocus
      Left = 175
      Top = 26
      Width = 345
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'DESMAR'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMar: TDBEditFocus
      Left = 121
      Top = 26
      Width = 54
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'CODMAR'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSigUni: TDBEditFocus
      Left = 586
      Top = 26
      Width = 54
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'SIGUNI'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnImportar: TBitBtnLocked
      Left = 596
      Top = 72
      Width = 81
      Height = 22
      Caption = '&Importar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 13
      OnClick = btnImportarClick
    end
    object chkLimparFiltros: TCheckBox
      Left = 677
      Top = 53
      Width = 154
      Height = 17
      TabStop = False
      Caption = 'Limpar filtros ap'#243's consulta'
      Checked = True
      State = cbChecked
      TabOrder = 14
      OnClick = chkLimparFiltrosClick
    end
  end
  object prgProgresso: TProgressBar [5]
    Left = 0
    Top = 669
    Width = 1008
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 200
    Top = 312
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 168
    Top = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 40
    Top = 0
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 8
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 192
    Top = 392
    object cdsItensCODITE: TStringField
      DisplayWidth = 20
      FieldName = 'CODITE'
    end
    object cdsItensARMORI: TStringField
      FieldName = 'ARMORI'
      Size = 30
    end
    object cdsItensARMDES: TStringField
      FieldName = 'ARMDES'
      Size = 30
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsItensSALORI: TFloatField
      FieldName = 'SALORI'
    end
    object cdsItensSALDES: TFloatField
      FieldName = 'SALDES'
    end
    object cdsItensMAXORI: TFloatField
      FieldName = 'MAXORI'
    end
    object cdsItensMAXDES: TFloatField
      FieldName = 'MAXDES'
    end
    object cdsItensREPORI: TFloatField
      FieldName = 'REPORI'
    end
    object cdsItensREPDES: TFloatField
      FieldName = 'REPDES'
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensSALDOS: TFloatField
      FieldName = 'SALDOS'
    end
    object cdsItensPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsItensLOCORI: TStringField
      FieldName = 'LOCORI'
    end
    object cdsItensLOCDES: TStringField
      FieldName = 'LOCDES'
    end
    object cdsItensDESLFO: TStringField
      FieldName = 'DESLFO'
      Size = 50
    end
    object cdsItensDESLFD: TStringField
      FieldName = 'DESLFD'
      Size = 50
    end
    object cdsItensCODMAR: TStringField
      FieldName = 'CODMAR'
      Size = 6
    end
    object cdsItensDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 30
    end
    object cdsItensSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsItensSALORIRES: TFloatField
      FieldName = 'SALORIRES'
    end
    object cdsItensSALORIDIS: TFloatField
      FieldName = 'SALORIDIS'
    end
    object cdsItensSALDESRES: TFloatField
      FieldName = 'SALDESRES'
    end
    object cdsItensSALDESDIS: TFloatField
      FieldName = 'SALDESDIS'
    end
    object cdsItensDESAMZLOCORI: TStringField
      FieldName = 'DESAMZLOCORI'
      Size = 150
    end
    object cdsItensDESAMZLOCDES: TStringField
      FieldName = 'DESAMZLOCDES'
      Size = 150
    end
    object cdsItensDESAMZORI: TStringField
      FieldName = 'DESAMZORI'
    end
    object cdsItensDESAMZDES: TStringField
      FieldName = 'DESAMZDES'
    end
    object cdsItensDESLOCORI: TStringField
      FieldName = 'DESLOCORI'
      Size = 50
    end
    object cdsItensDESLOCDES: TStringField
      FieldName = 'DESLOCDES'
      Size = 50
    end
    object cdsItensTOTCUS: TAggregateField
      FieldName = 'TOTCUS'
      Active = True
      DisplayName = ''
      Expression = 'SUM(PRECUS * QTDITE)'
    end
  end
  object dtsGrid: TDataSource
    DataSet = cdsItens
    Left = 224
    Top = 392
  end
end
