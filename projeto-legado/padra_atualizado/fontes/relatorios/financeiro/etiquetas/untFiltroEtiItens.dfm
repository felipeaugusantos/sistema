inherited frmFiltroEtiItens: TfrmFiltroEtiItens
  Left = 389
  Top = 240
  Width = 605
  Height = 720
  BorderIcons = [biSystemMenu]
  Caption = 'Filtros - Produtos'
  ExplicitWidth = 605
  ExplicitHeight = 720
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 649
    Width = 599
    TabOrder = 6
    ExplicitTop = 649
    ExplicitWidth = 599
    inherited FlwBotoes: TFlowPanel
      Width = 595
      ExplicitWidth = 595
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 517
      ExplicitLeft = 517
    end
  end
  inherited pnlStatus: TPanel
    Top = 675
    Width = 599
    TabOrder = 7
    ExplicitTop = 675
    ExplicitWidth = 599
    inherited pnlNomeForm: TPanel
      Left = 442
      Width = 157
      ExplicitLeft = 442
      ExplicitWidth = 157
    end
    inherited pnlInfo: TPanel
      Width = 442
      ExplicitWidth = 442
      object Shape1: TShape
        Left = 349
        Top = 1
        Width = 15
        Height = 15
        Brush.Color = clBlue
      end
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 599
    Height = 332
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 31
      Top = 129
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Inicial:'
    end
    object Label2: TLabel
      Left = 350
      Top = 129
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Final:'
    end
    object lblCodMar: TLabel
      Left = 347
      Top = 198
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lblCodFor: TLabel
      Left = 53
      Top = 221
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lblLinGru: TLabel
      Left = 44
      Top = 245
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object lblRefere: TLabel
      Left = 56
      Top = 198
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object lblCodPro: TLabel
      Left = 61
      Top = 106
      Width = 51
      Height = 14
      Caption = 'Promo'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCodDep: TLabel
      Left = 349
      Top = 245
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Depto:'
    end
    object lblDesIte: TLabel
      Left = 20
      Top = 152
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Produto:'
    end
    object lblDESSIM: TLabel
      Left = 2
      Top = 175
      Width = 112
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Simplificada:'
    end
    object Label3: TLabel
      Left = 412
      Top = 108
      Width = 90
      Height = 14
      Caption = 'Promo'#231#245'es do Dia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblIteEmb: TLabel
      Left = 3
      Top = 291
      Width = 152
      Height = 14
      Alignment = taRightJustify
      Caption = 'Itens com embalagem fechada?'
    end
    object lblIteEmbLeg: TColorLabel
      Left = 186
      Top = 291
      Width = 117
      Height = 14
      Caption = '(S)im, (N)'#227'o ou (T)odos '
      CorDestaque = clRed
    end
    object Label167: TLabel
      Left = 23
      Top = 267
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Produto:'
    end
    object Label6: TLabel
      Left = 77
      Top = 313
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Itens com lotes?'
    end
    object ColorLabel1: TColorLabel
      Left = 183
      Top = 314
      Width = 117
      Height = 14
      Caption = '(S)im, (N)'#227'o ou (T)odos '
      CorDestaque = clRed
    end
    object lblSitPro: TLabel
      Left = 334
      Top = 268
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sit. prod.:'
    end
    object lblPeriodoDe: TLabel
      Left = 371
      Top = 291
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo de :'
      Visible = False
    end
    object lblPeriodoA: TLabel
      Left = 507
      Top = 291
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
      Visible = False
    end
    object edtDesIni: TEditFocus
      Tag = 99
      Left = 114
      Top = 125
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesFin: TEditFocus
      Tag = 99
      Left = 378
      Top = 125
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 382
      Top = 194
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 9
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 114
      Top = 217
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 11
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtLinGru: TMaskEditFocus
      Tag = 99
      Left = 114
      Top = 240
      Width = 42
      Height = 22
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 13
      Text = ''
      OnExit = edtLinGruExit
      OnKeyPress = edtLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomFor: TEditFocus
      Left = 183
      Top = 217
      Width = 405
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 424
      Top = 194
      Width = 164
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtDesGru: TEditFocus
      Left = 158
      Top = 240
      Width = 166
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpb1: TGroupBox
      Left = 7
      Top = -2
      Width = 594
      Height = 101
      Caption = 'Per'#237'odo de Altera'#231#227'o de Pre'#231'o'
      TabOrder = 0
      object lbl1: TLabel
        Left = 183
        Top = 18
        Width = 19
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fim:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 6
        Top = 18
        Width = 27
        Height = 14
        Alignment = taRightJustify
        Caption = 'In'#237'cio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEmpresa: TLabel
        Left = 10
        Top = 43
        Width = 45
        Height = 14
        Caption = 'Empresa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 105
        Top = 18
        Width = 26
        Height = 14
        Caption = 'Hora:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 274
        Top = 18
        Width = 26
        Height = 14
        Caption = 'Hora:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTabPre: TLabel
        Left = 318
        Top = 43
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tabela:'
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 37
        Top = 14
        Width = 65
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
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 206
        Top = 14
        Width = 65
        Height = 22
        Enabled = False
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
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtCodEmpresa: TEditFocus
        Tag = 99
        Left = 57
        Top = 39
        Width = 47
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 4
        OnExit = edtCodEmpresaExit
        OnKeyPress = edtCodEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpresa: TEditFocus
        Left = 103
        Top = 39
        Width = 194
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskHraIni: TMaskEditFocus
        Tag = 99
        Left = 134
        Top = 14
        Width = 45
        Height = 22
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 1
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskHraFin: TMaskEditFocus
        Tag = 99
        Left = 303
        Top = 14
        Width = 45
        Height = 22
        EditMask = '!99:99;1;_'
        MaxLength = 5
        TabOrder = 3
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object rdgPreAlt: TRadioGroup
        Left = 3
        Top = 63
        Width = 576
        Height = 35
        Caption = 'Pre'#231'o Alterado'
        Columns = 3
        Ctl3D = True
        ItemIndex = 1
        Items.Strings = (
          'Pre'#231'o de Custo'
          'Pre'#231'o de Venda'
          'Todos os pre'#231'os')
        ParentCtl3D = False
        TabOrder = 7
      end
      object clbPreTab: TCheckListBox
        Tag = 99
        Left = 353
        Top = 42
        Width = 216
        Height = 17
        BorderStyle = bsNone
        Color = 16770261
        Columns = 7
        Ctl3D = True
        ItemHeight = 14
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7')
        ParentCtl3D = False
        TabOrder = 6
        StyleElements = [seFont, seBorder]
      end
      object chkItensDivergentes: TCheckBox
        Left = 353
        Top = 7
        Width = 226
        Height = 30
        Caption = 'Itens marcados como divergentes pelo coletor'
        TabOrder = 8
        WordWrap = True
        OnClick = chkItensDivergentesClick
      end
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 114
      Top = 194
      Width = 210
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 114
      Top = 102
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 1
      OnExit = edtCodProExit
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtDesPro: TEditFocus
      Left = 170
      Top = 102
      Width = 236
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 382
      Top = 240
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDep: TEditFocus
      Left = 424
      Top = 240
      Width = 164
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 114
      Top = 148
      Width = 474
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDESSIM: TEditFocus
      Tag = 99
      Left = 114
      Top = 171
      Width = 474
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDataPromoc: TMaskEditFocus
      Tag = 99
      Left = 503
      Top = 102
      Width = 85
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
      ValidaData = True
    end
    object edtIteEmb: TEditFocus
      Tag = 99
      Left = 158
      Top = 287
      Width = 22
      Height = 22
      Alignment = taCenter
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtDesPrdPro: TEditFocus
      Left = 158
      Top = 263
      Width = 150
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPrdGru: TEditFocus
      Tag = 99
      Left = 114
      Top = 263
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 17
      OnExit = edtPrdGruExit
      OnKeyPress = edtPrdGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtIteLot: TEditFocus
      Tag = 99
      Left = 158
      Top = 309
      Width = 22
      Height = 22
      Alignment = taCenter
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 24
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtDesSitPro: TEditFocus
      Left = 424
      Top = 263
      Width = 164
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSitPro: TEditFocus
      Tag = 99
      Left = 382
      Top = 263
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 18
      OnExit = edtSitProExit
      OnKeyPress = edtSitProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object mskPrecoDtaIni: TMaskEditFocus
      Tag = 99
      Left = 434
      Top = 287
      Width = 67
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
      TabOrder = 22
      Text = '  /  /    '
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskPrecoDtaFin: TMaskEditFocus
      Tag = 99
      Left = 521
      Top = 287
      Width = 67
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
      TabOrder = 23
      Text = '  /  /    '
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object pnlLocFis: TPanel [3]
    Left = 0
    Top = 332
    Width = 599
    Height = 88
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lblLocFis: TLabel
      Left = 57
      Top = 3
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Loc. Fisica:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 7
      Top = 70
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Armaz'#233'm:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 114
      Top = 0
      Width = 450
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAmz: TEditFocus
      Tag = 99
      Left = 57
      Top = 66
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      OnExit = edtCodAmzExit
      OnKeyPress = edtCodAmzKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesAmz: TEditFocus
      Left = 110
      Top = 66
      Width = 247
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object gb2: TGroupBox
      Tag = 99
      Left = 308
      Top = 23
      Width = 280
      Height = 40
      Caption = 'Loc. F'#237'sica - Super Estoque'
      TabOrder = 4
      object Label11: TLabel
        Left = 146
        Top = 19
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Final:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 7
        Top = 19
        Width = 29
        Height = 14
        Alignment = taRightJustify
        Caption = 'Inicial:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtLocFinSup: TEditFocus
        Tag = 99
        Left = 173
        Top = 15
        Width = 95
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        OnKeyPress = edtLocFinSupKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtLocIniSup: TEditFocus
        Tag = 99
        Left = 38
        Top = 15
        Width = 95
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnChange = edtLocIniSupChange
        OnKeyPress = edtLocIniSupKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object gb1: TGroupBox
      Tag = 99
      Left = 4
      Top = 23
      Width = 280
      Height = 40
      Caption = 'Loc. F'#237'sica - Estoque'
      TabOrder = 3
      object Label5: TLabel
        Left = 7
        Top = 19
        Width = 29
        Height = 14
        Alignment = taRightJustify
        Caption = 'Inicial:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 147
        Top = 19
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Final:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtLocFin: TEditFocus
        Tag = 99
        Left = 174
        Top = 15
        Width = 95
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        OnKeyPress = edtLocFinKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtLocIni: TEditFocus
        Tag = 99
        Left = 42
        Top = 15
        Width = 95
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnChange = edtLocIniChange
        OnKeyPress = edtLocIniKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object chkSalArm: TCheckBox
      Left = 363
      Top = 69
      Width = 225
      Height = 17
      Caption = 'Apenas produtos com saldo no armaz'#233'm'
      TabOrder = 5
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 581
    Width = 599
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object Label10: TLabel
      Left = 507
      Top = 15
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qt.Etiq.:'
    end
    object chkCodBar: TCheckBox
      Left = 7
      Top = 0
      Width = 162
      Height = 15
      Caption = 'Produtos com c'#243'd.barras'
      TabOrder = 0
      WordWrap = True
    end
    object chkImpEst: TCheckBox
      Left = 163
      Top = 0
      Width = 189
      Height = 15
      Caption = 'Quantidade dispon'#237'vel em estoque'
      TabOrder = 3
      OnClick = chkImpEstClick
    end
    object chkPromoc: TCheckBox
      Left = 356
      Top = 0
      Width = 150
      Height = 15
      Caption = 'Filtrar itens em promo'#231#227'o'
      TabOrder = 1
    end
    object chkMosFil: TCheckBox
      Left = 265
      Top = 15
      Width = 212
      Height = 15
      Caption = 'Apenas registros que satisfazem o filtro'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 547
      Top = 11
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object chkSaldoMinimo: TCheckBox
      Left = 7
      Top = 15
      Width = 252
      Height = 15
      Caption = 'Produtos que possuam saldo m'#237'nimo em estoque'
      TabOrder = 4
    end
  end
  object pnlWms: TPanel [5]
    Left = 0
    Top = 463
    Width = 599
    Height = 47
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label13: TLabel
      Left = 4
      Top = 27
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rua:'
    end
    object Label14: TLabel
      Left = 145
      Top = 28
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#233'dio:'
    end
    object Label15: TLabel
      Left = 295
      Top = 27
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Andar:'
    end
    object Label16: TLabel
      Left = 460
      Top = 27
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Apto:'
    end
    object Label17: TLabel
      Left = 26
      Top = 3
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Loc. Separa'#231#227'o:'
    end
    object Label18: TLabel
      Left = 373
      Top = 27
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label19: TLabel
      Left = 529
      Top = 27
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label20: TLabel
      Left = 70
      Top = 27
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object Label21: TLabel
      Left = 223
      Top = 27
      Width = 15
      Height = 14
      Caption = 'at'#233
    end
    object edtRuaIni: TEditFocus
      Tag = 99
      Left = 29
      Top = 23
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPredioIni: TEditFocus
      Tag = 99
      Left = 181
      Top = 23
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAndarIni: TEditFocus
      Tag = 99
      Left = 329
      Top = 23
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtApartamentoIni: TEditFocus
      Tag = 99
      Left = 486
      Top = 23
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodLse: TEditFocus
      Tag = 99
      Left = 114
      Top = 0
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodLseExit
      OnKeyPress = edtCodLseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesLse: TEditFocus
      Left = 167
      Top = 0
      Width = 419
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtRuaFin: TEditFocus
      Tag = 99
      Left = 88
      Top = 23
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPredioFin: TEditFocus
      Tag = 99
      Left = 240
      Top = 23
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAndarFin: TEditFocus
      Tag = 99
      Left = 394
      Top = 23
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtApartamentoFin: TEditFocus
      Tag = 99
      Left = 546
      Top = 23
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlExpEtiEle: TPanel [6]
    Left = 0
    Top = 420
    Width = 599
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object grbExpEtiEle: TGroupBox
      Left = 4
      Top = 1
      Width = 584
      Height = 40
      Caption = 'Exporta'#231#227'o Etiquetas Eletr'#244'nicas'
      TabOrder = 0
      object Label4: TLabel
        Left = 25
        Top = 19
        Width = 42
        Height = 14
        Caption = 'Empresa'
      end
      object EdtCodEmpresaEtiEle: TEditFocus
        Tag = 99
        Left = 73
        Top = 15
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnExit = EdtCodEmpresaEtiEleExit
        OnKeyPress = EdtCodEmpresaEtiEleKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesEmpresaEtiEle: TEditFocus
        Left = 131
        Top = 15
        Width = 441
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
  end
  object pnlEstoqPro: TPanel [7]
    Left = 0
    Top = 510
    Width = 599
    Height = 71
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object rdgEstMin: TRadioGroup
      Left = 4
      Top = -1
      Width = 276
      Height = 33
      Caption = 'Listar produtos com estoque m'#237'nimo: '
      Columns = 3
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Zero'
        'Maior que zero')
      ParentCtl3D = False
      TabOrder = 0
      TabStop = True
    end
    object rdgEstMax: TRadioGroup
      Left = 295
      Top = -1
      Width = 291
      Height = 33
      Caption = 'Listar produtos com estoque m'#225'ximo: '
      Columns = 3
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Zero'
        'Maior que zero')
      ParentCtl3D = False
      TabOrder = 1
      TabStop = True
    end
    object rdgEstFis: TRadioGroup
      Left = 4
      Top = 32
      Width = 582
      Height = 33
      Caption = 'Listar produtos com estoque f'#237'sico:'
      Columns = 4
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Todos os produtos'
        'Zero'
        'Maior que zero'
        'Menor que zero')
      ParentCtl3D = False
      TabOrder = 2
      TabStop = True
    end
  end
  object pnlExibirEstoque: TPanel [8]
    Left = 0
    Top = 614
    Width = 599
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 8
    object rdgExibirEstoque: TRadioGroup
      Left = 4
      Top = -2
      Width = 582
      Height = 31
      Caption = 'Exibir Estoque'
      Columns = 2
      Ctl3D = True
      ItemIndex = 0
      Items.Strings = (
        'Produto'
        'Armaz'#233'm')
      ParentCtl3D = False
      TabOrder = 0
      TabStop = True
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 440
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 212
    Top = 436
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 288
    Top = 440
  end
end
