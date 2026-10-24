inherited frmFatConfDocumentos: TfrmFatConfDocumentos
  Left = 170
  Top = 98
  Width = 887
  Height = 724
  BorderIcons = [biSystemMenu]
  Caption = 'Confirma'#231#227'o de Documentos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitTop = -107
  ExplicitWidth = 887
  ExplicitHeight = 661
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 615
    Width = 881
    ExplicitTop = 552
    ExplicitWidth = 881
    DesignSize = (
      881
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 877
      ExplicitWidth = 877
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 679
    Width = 881
    ExplicitTop = 616
    ExplicitWidth = 881
    inherited pnlNomeForm: TPanel
      Left = 696
      Width = 185
      ExplicitLeft = 696
      ExplicitWidth = 185
    end
    inherited pnlInfo: TPanel
      Width = 696
      ExplicitWidth = 696
    end
  end
  inherited pgcDados: TPageControl
    Left = 621
    Top = 99
    Width = 260
    Height = 516
    Visible = False
    ExplicitLeft = 621
    ExplicitTop = 99
    ExplicitWidth = 260
    ExplicitHeight = 453
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 252
      ExplicitHeight = 421
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 881
    Height = 99
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    OnExit = pnlCabecalhoExit
    object Label1: TLabel
      Left = 74
      Top = 9
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 46
      Top = 53
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo Cliente:'
    end
    object Label15: TLabel
      Left = 302
      Top = 31
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 52
      Top = 31
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label19: TLabel
      Left = 196
      Top = 31
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label20: TLabel
      Left = 426
      Top = 31
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #225
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCliSeg: TLabel
      Left = 519
      Top = 31
      Width = 96
      Height = 14
      Caption = 'Cliente assegurado:'
      Visible = False
    end
    object lblEnderecoEntrega: TLabel
      Left = 5
      Top = 75
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o de Entrega:'
    end
    object lblSituacaoFinanceira: TLabel
      Left = 651
      Top = 75
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o Financeira:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 113
      Top = 5
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 194
      Top = 5
      Width = 652
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCliFat: TEditFocus
      Tag = 99
      Left = 113
      Top = 49
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 6
      OnKeyPress = edtCliFatKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCliFat: TEditFocus
      Left = 194
      Top = 49
      Width = 652
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 346
      Top = 27
      Width = 72
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 113
      Top = 27
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 241
      Top = 27
      Width = 31
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 2
      OnEnter = edtEspDocEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 438
      Top = 27
      Width = 72
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCliSeg: TEditFocus
      Tag = 99
      Left = 615
      Top = 27
      Width = 231
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbClienteEnderecos: TComboBoxFocus
      Left = 113
      Top = 72
      Width = 502
      Height = 22
      Style = csDropDownList
      TabOrder = 7
      OnSelect = cmbClienteEnderecosSelect
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbSituacaoFinanceira: TComboBoxFocus
      Left = 752
      Top = 72
      Width = 94
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 8
      Text = 'Todos'
      OnSelect = cmbClienteEnderecosSelect
      Items.Strings = (
        'Todos'
        'Quitado'
        'Em Aberto')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 99
    Width = 621
    Height = 516
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    object dbgDocumentos: TDBGridCitel
      Left = 0
      Top = 0
      Width = 621
      Height = 425
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDocumentosDrawColumnCell
      OnDblClick = dbgDocumentosDblClick
      OnKeyDown = dbgDocumentosKeyDown
      OnMouseLeave = dbgDocumentosMouseLeave
      OnMouseUp = dbgDocumentosMouseUp
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_DTAENT'
          Title.Caption = 'Dta. Emiss'#227'o'
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TMP_CONPAG'
          Title.Caption = 'Cnd. Pgto.'
          Width = 65
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CODVEN'
          Title.Alignment = taCenter
          Title.Caption = 'Ven.'
          Width = 26
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_NUMDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Documento'
          Width = 102
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_ESPDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Esp.'
          Width = 26
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CODEMP'
          Title.Alignment = taCenter
          Title.Caption = 'Emp.'
          Width = 26
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_ENTRET'
          Title.Alignment = taCenter
          Title.Caption = 'Ent/Ret'
          Width = 38
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CLAFIS'
          Title.Alignment = taCenter
          Title.Caption = 'CFOP'
          Width = 30
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_VLRCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Total'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_DUPREC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Dup. Pagas'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_ITEDOC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Itens'
          Width = 29
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_TPOPER'
          Title.Alignment = taCenter
          Title.Caption = 'Tp. Ope.'
          Width = 60
          Visible = True
        end>
    end
    object pnlCliSeg: TPanel
      Left = 0
      Top = 480
      Width = 621
      Height = 36
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      object Label25: TLabel
        Left = 4
        Top = 11
        Width = 96
        Height = 14
        Caption = 'Cliente assegurado:'
      end
      object dbeCliSeg: TDBEdit
        Left = 102
        Top = 7
        Width = 427
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'TMP_NOMCON'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
      end
    end
    object pnlMsg: TPanel
      Left = 0
      Top = 433
      Width = 621
      Height = 47
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      ExplicitTop = 372
      object lblMensagem: TLabel
        Left = 15
        Top = 6
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Mensagem:'
      end
      object dbeMen001: TDBEdit
        Left = 74
        Top = 2
        Width = 541
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'TMP_MEN001'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
      end
      object dbeMen002: TDBEdit
        Left = 74
        Top = 25
        Width = 541
        Height = 22
        TabStop = False
        Color = 16768952
        DataField = 'TMP_MEN002'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
      end
    end
    object splMsg: TcxSplitter
      Left = 0
      Top = 425
      Width = 621
      Height = 8
      Hint = 'Retrair Mensagens'
      HotZoneClassName = 'TcxSimpleStyle'
      AlignSplitter = salTop
      Control = pnlMsg
      OnAfterOpen = splMsgAfterOpen
      OnAfterClose = splMsgAfterClose
      ShowHint = True
      ParentShowHint = False
      ExplicitTop = 16
    end
  end
  object pnlAux1: TPanel [5]
    Left = 621
    Top = 99
    Width = 260
    Height = 516
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 5
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 260
      Height = 162
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label4: TLabel
        Left = 2
        Top = 2
        Width = 256
        Height = 18
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'TOTAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 244
      end
      object Label3: TLabel
        Left = 17
        Top = 24
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label7: TLabel
        Left = 58
        Top = 47
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object Label9: TLabel
        Left = 24
        Top = 70
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Duplicatas Pagas:'
      end
      object Label11: TLabel
        Left = 48
        Top = 136
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total L'#237'quido:'
      end
      object Label23: TLabel
        Left = 61
        Top = 93
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto:'
      end
      object Label24: TLabel
        Left = 80
        Top = 116
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Juros:'
      end
      object edtQtdDoc: TEditFocus
        Left = 114
        Top = 20
        Width = 72
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
      object edtTotGer: TEditFocus
        Left = 114
        Top = 43
        Width = 72
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
      object edtDupPag: TEditFocus
        Left = 114
        Top = 66
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object edtTotLiq: TEditFocus
        Left = 114
        Top = 135
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesSuj: TEditFocus
        Left = 114
        Top = 89
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtJurSuj: TEditFocus
        Left = 114
        Top = 112
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlInformativos: TPanel
      Left = 0
      Top = 162
      Width = 260
      Height = 354
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label16: TLabel
        Left = 2
        Top = 2
        Width = 256
        Height = 18
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'SELECIONADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 246
      end
      object Label6: TLabel
        Left = 18
        Top = 24
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label12: TLabel
        Left = 58
        Top = 47
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object Label14: TLabel
        Left = 24
        Top = 70
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Duplicatas Pagas:'
      end
      object Label17: TLabel
        Left = 48
        Top = 139
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total L'#237'quido:'
      end
      object Label21: TLabel
        Left = 61
        Top = 93
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto:'
      end
      object Label22: TLabel
        Left = 80
        Top = 116
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Juros:'
      end
      object edtQtdDocSel: TEditFocus
        Left = 114
        Top = 20
        Width = 72
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
      object edtTotGerSel: TEditFocus
        Left = 114
        Top = 43
        Width = 72
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
      object edtDupPagSel: TEditFocus
        Left = 114
        Top = 66
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object edtTotLiqSel: TEditFocus
        Left = 114
        Top = 135
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object GroupBox1: TGroupBox
        Left = 6
        Top = 157
        Width = 242
        Height = 129
        Caption = 'Legenda de cores'
        TabOrder = 4
        object Shape1: TShape
          Left = 5
          Top = 14
          Width = 14
          Height = 13
          Brush.Color = clRed
          Pen.Color = clRed
        end
        object Label5: TLabel
          Left = 23
          Top = 14
          Width = 159
          Height = 14
          Caption = 'Documentos baixados totalmente'
        end
        object Shape2: TShape
          Left = 5
          Top = 42
          Width = 14
          Height = 13
          Brush.Color = clGreen
          Pen.Color = clGreen
        end
        object Label8: TLabel
          Left = 23
          Top = 42
          Width = 115
          Height = 14
          Caption = 'Documentos agrupados'
        end
        object Shape3: TShape
          Left = 5
          Top = 56
          Width = 14
          Height = 13
          Brush.Color = clBlue
          Pen.Color = clBlue
        end
        object Label10: TLabel
          Left = 23
          Top = 56
          Width = 127
          Height = 14
          Caption = 'Documentos selecionados'
        end
        object Shape4: TShape
          Left = 5
          Top = 70
          Width = 14
          Height = 13
          Brush.Color = clBlack
        end
        object Label13: TLabel
          Left = 23
          Top = 70
          Width = 148
          Height = 14
          Caption = 'Documentos n'#227'o selecionados'
        end
        object Label26: TLabel
          Left = 23
          Top = 84
          Width = 208
          Height = 14
          Caption = 'Doc. que n'#227'o possui financeiro cadastrado'
        end
        object Shape5: TShape
          Left = 5
          Top = 84
          Width = 14
          Height = 13
          Brush.Color = clPurple
        end
        object shpNaoSint: TShape
          Left = 5
          Top = 98
          Width = 14
          Height = 13
          Hint = 
            'Clique com o bot'#227'o direito do mouse sobre a devolu'#231#227'o'#13#10'para visu' +
            'alizar os documentos de faturamento associados.'
          Brush.Color = 33023
          ParentShowHint = False
          ShowHint = True
        end
        object lblNaoSint: TLabel
          Left = 23
          Top = 98
          Width = 195
          Height = 14
          Caption = 'Docs. que n'#227'o puderam ser sintetizados'
          ParentShowHint = False
          ShowHint = True
        end
        object shpFFBol: TShape
          Left = 5
          Top = 112
          Width = 14
          Height = 13
          Brush.Color = clOlive
          Visible = False
        end
        object lblFFBol: TLabel
          Left = 23
          Top = 112
          Width = 104
          Height = 14
          Caption = 'FF Com boleto emitido'
          ParentShowHint = False
          ShowHint = True
          Visible = False
        end
        object Shape6: TShape
          Left = 5
          Top = 28
          Width = 14
          Height = 13
          Brush.Color = clMaroon
          Pen.Color = clMaroon
        end
        object Label27: TLabel
          Left = 23
          Top = 28
          Width = 171
          Height = 14
          Caption = 'Documentos baixados parcialmente'
        end
      end
      object edtDesSujSel: TEditFocus
        Left = 114
        Top = 89
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtJurSujSel: TEditFocus
        Left = 114
        Top = 112
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gbTipoOper: TGroupBox
        Left = 6
        Top = 287
        Width = 243
        Height = 61
        Caption = ' Legenda Tipo da Opera'#231#227'o '
        TabOrder = 7
        object Label28: TLabel
          Left = 8
          Top = 17
          Width = 84
          Height = 14
          Caption = 'U - Uso/Consumo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label29: TLabel
          Left = 8
          Top = 31
          Width = 60
          Height = 14
          Caption = 'R - Revenda'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label30: TLabel
          Left = 8
          Top = 45
          Width = 87
          Height = 14
          Caption = 'I - Industrializa'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object pnlBotoesBaixa: TPanel [6]
    Left = 0
    Top = 630
    Width = 881
    Height = 49
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    DesignSize = (
      881
      49)
    object FlwPnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 877
      Height = 45
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnItensDoc: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F5 ] Itens do Documento'
        TabOrder = 0
        OnClick = btnItensDocClick
      end
      object btnDupPagas: TBitBtnLocked
        Left = 130
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F6 ] Duplicatas Pagas'
        TabOrder = 1
        OnClick = btnDupPagasClick
      end
      object btnMarca: TBitBtnLocked
        Left = 260
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F7 ] Marca Tudo'
        TabOrder = 2
        OnClick = btnMarcaClick
      end
      object btnPopMenuMarca: TBitBtnLocked
        Left = 370
        Top = 0
        Width = 22
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Enabled = False
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000C3
          C3C3EBEBEB000000000000000000000000000000000000000000000000000000
          0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
          00000000000000000000000000000000000000000000000000000000C3C3C3EB
          EBEBEBEBEBEBEBEB000000000000000000000000000000000000000000000000
          0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
          00000000000000000000000000000000000000000000000000C3C3C3EBEBEBEB
          EBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000000000000000
          0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
          00000000000000000000000000000000000000000000C3C3C3EBEBEBEBEBEBEB
          EBEBEBEBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000000000
          0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
          1E000000000000000000000000000000000000C3C3C3EBEBEBEBEBEBEBEBEBEB
          EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000
          1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C1E1E1E000000000000000000000000C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Margin = 0
        NumGlyphs = 2
        Spacing = 0
        TabOrder = 3
        TabStop = False
        OnClick = btnPopMenuMarcaClick
      end
      object btnDesmarca: TBitBtnLocked
        Left = 392
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F8 ] Desmarca Tudo'
        TabOrder = 4
        OnClick = btnDesmarcaClick
      end
      object btnPopMenuDesMarca: TBitBtnLocked
        Left = 502
        Top = 0
        Width = 22
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Enabled = False
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000C3
          C3C3EBEBEB000000000000000000000000000000000000000000000000000000
          0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
          00000000000000000000000000000000000000000000000000000000C3C3C3EB
          EBEBEBEBEBEBEBEB000000000000000000000000000000000000000000000000
          0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
          00000000000000000000000000000000000000000000000000C3C3C3EBEBEBEB
          EBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000000000000000
          0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
          00000000000000000000000000000000000000000000C3C3C3EBEBEBEBEBEBEB
          EBEBEBEBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000000000
          0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
          1E000000000000000000000000000000000000C3C3C3EBEBEBEBEBEBEBEBEBEB
          EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000
          1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C1E1E1E000000000000000000000000C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Margin = 0
        NumGlyphs = 2
        Spacing = 0
        TabOrder = 5
        TabStop = False
        OnClick = btnPopMenuDesMarcaClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 524
        Top = 0
        Width = 125
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 6
        OnClick = btnConfirmaClick
      end
      object btnBaiDoc: TBitBtnLocked
        Left = 649
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F4 ] Baixar Documentos'
        TabOrder = 7
        OnClick = btnBaiDocClick
      end
      object btnCancelarBaixaDocumento: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 201
        Height = 22
        Caption = '[F11] Cancelar Baixa Documentos'
        TabOrder = 8
        OnClick = btnCancelarBaixaDocumentoClick
      end
      object chkEditaEmail: TCheckBox
        Left = 201
        Top = 22
        Width = 298
        Height = 19
        Caption = 'Editar e-mail antes do envio'
        Enabled = False
        TabOrder = 9
        WordWrap = True
      end
    end
    object btnSairConf: TBitBtnLocked
      Left = 798
      Top = 2
      Width = 80
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairConfClick
    end
  end
  object prbProgresso: TProgressBar [7]
    Left = 0
    Top = 615
    Width = 881
    Height = 15
    Align = alBottom
    TabOrder = 7
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 744
    Top = 152
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaNone
    HintStyle.AnimationDelay = 1000
    HintStyle.CallOutPosition = cxbpTopLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Arial'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -12
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    Left = 744
    Top = 186
  end
  object popMarca: TPopupMenu
    Left = 464
    Top = 376
    object popEnt: TMenuItem
      Caption = '&Entrega'
      OnClick = popEntClick
    end
    object popRet: TMenuItem
      Caption = '&Retira'
      OnClick = popRetClick
    end
  end
  object HintAlerta: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaNone
    HintStyle.AnimationDelay = 1000
    HintStyle.CallOutPosition = cxbpTopLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Arial'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -12
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    Left = 504
    Top = 186
  end
  object TimerAlerta: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimerAlertaTimer
    Left = 504
    Top = 239
  end
end
