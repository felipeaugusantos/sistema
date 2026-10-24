inherited frmAltPrecoProduto: TfrmAltPrecoProduto
  Left = 315
  Top = 159
  Width = 864
  Height = 746
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o de Pre'#231'os por Produto'
  Position = poScreenCenter
  ExplicitWidth = 864
  ExplicitHeight = 746
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 672
    Width = 858
    ExplicitTop = 695
    ExplicitWidth = 858
    DesignSize = (
      858
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 854
      ExplicitWidth = 854
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 701
    Width = 858
    ExplicitTop = 724
    ExplicitWidth = 858
    inherited pnlNomeForm: TPanel
      Left = 718
      Width = 140
      ExplicitLeft = 718
      ExplicitWidth = 140
    end
    inherited pnlInfo: TPanel
      Width = 718
      ExplicitLeft = 6
      ExplicitTop = 2
      ExplicitWidth = 718
    end
  end
  inherited pgcDados: TPageControl
    Top = 214
    Width = 858
    Height = 458
    Visible = False
    ExplicitTop = 234
    ExplicitWidth = 858
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 850
      ExplicitHeight = 429
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 858
    Height = 214
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 56
      Top = 42
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label5: TLabel
      Left = 40
      Top = 86
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label7: TLabel
      Left = 36
      Top = 108
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label9: TLabel
      Left = 689
      Top = 108
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label11: TLabel
      Left = 59
      Top = 130
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label2: TLabel
      Left = 33
      Top = 152
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 24
      Top = 64
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object lblCodFab: TLabel
      Left = 371
      Top = 108
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd F'#225'brica:'
    end
    object Label8: TLabel
      Left = 41
      Top = 177
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Aplica'#231#227'o:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 93
      Top = 39
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtLinGru: TEditFocus
      Left = 93
      Top = 61
      Width = 676
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtDesIte: TEditFocus
      Left = 93
      Top = 83
      Width = 676
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtRefere: TEditFocus
      Left = 93
      Top = 105
      Width = 250
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtDesUni: TEditFocus
      Left = 733
      Top = 105
      Width = 36
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtDesMar: TEditFocus
      Left = 93
      Top = 127
      Width = 676
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNomFor: TEditFocus
      Left = 93
      Top = 149
      Width = 676
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object rdgTipAlt: TRadioGroup
      Left = 93
      Top = 2
      Width = 676
      Height = 34
      Caption = 'Tipo de Altera'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Recalcular o Pre'#231'o de Venda'
        'Recalcular a Margem de Lucro')
      TabOrder = 0
    end
    object edtCodFab: TEditFocus
      Left = 434
      Top = 105
      Width = 250
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtAplica: TMemoFocus
      Left = 93
      Top = 171
      Width = 676
      Height = 39
      Color = 16768952
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object pnlPrecos: TPanel [4]
    Left = 0
    Top = 214
    Width = 858
    Height = 458
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    ExplicitHeight = 481
    object pnlPrecos1: TPanel
      Left = 2
      Top = 2
      Width = 575
      Height = 454
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      ExplicitHeight = 476
      object Label13: TLabel
        Left = 83
        Top = 14
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o Compra:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 80
        Top = 298
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sub. Tribut'#225'ria (+):'
      end
      object Label43: TLabel
        Left = 260
        Top = 298
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label14: TLabel
        Left = 90
        Top = 34
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto 01 (-):'
      end
      object Label33: TLabel
        Left = 261
        Top = 34
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label26: TLabel
        Left = 347
        Top = 14
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Custo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 139
        Top = 56
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '02 (-):'
      end
      object Label34: TLabel
        Left = 261
        Top = 56
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label25: TLabel
        Left = 361
        Top = 56
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'ICMS Sa'#237'da (+):'
      end
      object Label44: TLabel
        Left = 525
        Top = 56
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label16: TLabel
        Left = 136
        Top = 77
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = '03  (-):'
      end
      object Label35: TLabel
        Left = 261
        Top = 77
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label6: TLabel
        Left = 344
        Top = 77
        Width = 91
        Height = 14
        Alignment = taRightJustify
        Caption = 'Impostos Federais:'
      end
      object Label4: TLabel
        Left = 525
        Top = 77
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label17: TLabel
        Left = 139
        Top = 98
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '04 (-):'
      end
      object Label36: TLabel
        Left = 261
        Top = 99
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label32: TLabel
        Left = 358
        Top = 98
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desp. Oper. (+):'
      end
      object lblDesOpePer: TLabel
        Left = 525
        Top = 99
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label18: TLabel
        Left = 136
        Top = 121
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = '05  (-):'
      end
      object Label37: TLabel
        Left = 261
        Top = 121
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label19: TLabel
        Left = 139
        Top = 142
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '06 (-):'
      end
      object Label38: TLabel
        Left = 261
        Top = 142
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label20: TLabel
        Left = 87
        Top = 164
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'ICMS Entrada (-):'
      end
      object Label39: TLabel
        Left = 261
        Top = 164
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label21: TLabel
        Left = 99
        Top = 208
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'IPI Entrada (+):'
      end
      object Label40: TLabel
        Left = 261
        Top = 208
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label22: TLabel
        Left = 124
        Top = 230
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Frete (+):'
      end
      object Label41: TLabel
        Left = 261
        Top = 230
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label23: TLabel
        Left = 73
        Top = 275
        Width = 97
        Height = 14
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo Final (+):'
      end
      object Label42: TLabel
        Left = 260
        Top = 275
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblValFre: TLabel
        Left = 96
        Top = 252
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Frete (+):'
      end
      object lblDesAdi: TLabel
        Left = 6
        Top = 320
        Width = 163
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descontos Adicionais (Boleto) (-):'
      end
      object Label31: TLabel
        Left = 260
        Top = 320
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label45: TLabel
        Left = 73
        Top = 186
        Width = 97
        Height = 14
        Alignment = taRightJustify
        Caption = 'Impost. Federais (-):'
      end
      object Label46: TLabel
        Left = 260
        Top = 185
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblOutVal: TLabel
        Left = 342
        Top = 34
        Width = 93
        Height = 14
        Alignment = taRightJustify
        Caption = 'Outros Valores (+):'
      end
      object lblTabPre: TLabel
        Left = 280
        Top = 124
        Width = 274
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'TABELAS DE PRE'#199'O'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtPreCom: TEditFocus
        Tag = 99
        Left = 171
        Top = 4
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtSubsti: TEditFocus
        Tag = 99
        Left = 171
        Top = 290
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesf01: TEditFocus
        Tag = 99
        Left = 171
        Top = 26
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPreCus: TEditFocus
        Left = 436
        Top = 4
        Width = 88
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesf02: TEditFocus
        Tag = 99
        Left = 171
        Top = 48
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtIcmSai: TEditFocus
        Tag = 99
        Left = 436
        Top = 48
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesf03: TEditFocus
        Tag = 99
        Left = 171
        Top = 69
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtImpFed: TEditFocus
        Tag = 99
        Left = 436
        Top = 69
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 20
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesf04: TEditFocus
        Tag = 99
        Left = 171
        Top = 91
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesOpe: TEditFocus
        Tag = 99
        Left = 436
        Top = 91
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesf05: TEditFocus
        Tag = 99
        Left = 171
        Top = 113
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesf06: TEditFocus
        Tag = 99
        Left = 171
        Top = 134
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtIcmEnt: TEditFocus
        Tag = 99
        Left = 171
        Top = 156
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtIpiEnt: TEditFocus
        Tag = 99
        Left = 171
        Top = 200
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtFreEnt: TEditFocus
        Tag = 99
        Left = 171
        Top = 222
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtAcrFin: TEditFocus
        Tag = 99
        Left = 171
        Top = 267
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValFre: TEditFocus
        Tag = 99
        Left = 171
        Top = 244
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesAdb: TEditFocus
        Tag = 99
        Left = 171
        Top = 313
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtSubFed: TEditFocus
        Tag = 99
        Left = 171
        Top = 178
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtOutVal: TEditFocus
        Tag = 99
        Left = 436
        Top = 26
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object pnlTab1: TPanel
        Left = 279
        Top = 136
        Width = 274
        Height = 186
        BevelOuter = bvNone
        Color = 16770261
        TabOrder = 22
        object gpbTabPre01: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          Caption = 'Tabela 1:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          Style.Shadow = False
          Style.IsFontAssigned = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 0
          Visible = False
          Height = 58
          Width = 274
          object lblTitMarBr1: TLabel
            Left = 29
            Top = 19
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblTitPreVe1: TLabel
            Left = 6
            Top = 40
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblMarBr1: TLabel
            Left = 123
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object lblTitComTb1: TLabel
            Left = 142
            Top = 19
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblPerComTb1: TLabel
            Left = 246
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object edtComTb1: TEditFocus
            Tag = 99
            Left = 203
            Top = 11
            Width = 42
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
          object edtMarBr1: TEditFocus
            Tag = 99
            Left = 80
            Top = 11
            Width = 42
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnEnter = edtMarBr1Enter
            OnExit = edtMarBr1Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
          object edtPreVe1: TEditFocus
            Tag = 99
            Left = 80
            Top = 32
            Width = 165
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
        end
        object gpbTabPre02: TcxGroupBox
          Left = 0
          Top = 58
          Align = alTop
          Caption = 'Tabela 2:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 1
          Visible = False
          Height = 58
          Width = 274
          object lblTitMarBr2: TLabel
            Left = 29
            Top = 19
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblTitPreVe2: TLabel
            Left = 6
            Top = 40
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblMarBr2: TLabel
            Left = 123
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object lblTitComTb2: TLabel
            Left = 142
            Top = 19
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblPerComTb2: TLabel
            Left = 246
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object edtComTb2: TEditFocus
            Tag = 99
            Left = 203
            Top = 11
            Width = 42
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
          object edtMarBr2: TEditFocus
            Tag = 99
            Left = 80
            Top = 11
            Width = 42
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnEnter = edtMarBr1Enter
            OnExit = edtMarBr1Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
          object edtPreVe2: TEditFocus
            Tag = 99
            Left = 80
            Top = 32
            Width = 165
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
        end
        object gpbTabPre03: TcxGroupBox
          Left = 0
          Top = 116
          Align = alTop
          Caption = 'Tabela 3:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 2
          Visible = False
          Height = 58
          Width = 274
          object lblMarBr3: TLabel
            Left = 123
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object lblTitMarBr3: TLabel
            Left = 29
            Top = 19
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblTitPreVe3: TLabel
            Left = 6
            Top = 40
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblTitComTb3: TLabel
            Left = 142
            Top = 19
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblPerComTb3: TLabel
            Left = 246
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object edtComTb3: TEditFocus
            Tag = 99
            Left = 203
            Top = 11
            Width = 42
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
          object edtMarBr3: TEditFocus
            Tag = 99
            Left = 80
            Top = 11
            Width = 42
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnEnter = edtMarBr1Enter
            OnExit = edtMarBr1Exit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
          object edtPreVe3: TEditFocus
            Tag = 99
            Left = 80
            Top = 32
            Width = 165
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '##,#0.00'
          end
        end
      end
      object chkPreDol: TCheckBox
        Left = 262
        Top = 8
        Width = 70
        Height = 14
        Caption = 'Em d'#243'lar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = chkPreDolClick
      end
      object pnlSuframa: TPanel
        Left = 2
        Top = 335
        Width = 272
        Height = 141
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 16
        object Label27: TLabel
          Left = 259
          Top = 8
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label28: TLabel
          Left = 259
          Top = 31
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label29: TLabel
          Left = 259
          Top = 53
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label30: TLabel
          Left = 259
          Top = 76
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label47: TLabel
          Left = 259
          Top = 98
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label221: TLabel
          Left = 124
          Top = 5
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'TCIF (+):'
        end
        object Label222: TLabel
          Left = 132
          Top = 28
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'TS (+):'
        end
        object Label223: TLabel
          Left = 43
          Top = 51
          Width = 122
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto PIS/COFINS (-):'
        end
        object Label224: TLabel
          Left = 74
          Top = 74
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto ICMS (-):'
        end
        object Label225: TLabel
          Left = 76
          Top = 97
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator Regional (+):'
        end
        object edtFatReg: TEditFocus
          Tag = 99
          Left = 169
          Top = 94
          Width = 88
          Height = 22
          Alignment = taRightJustify
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDeICMS: TEditFocus
          Tag = 99
          Left = 169
          Top = 71
          Width = 88
          Height = 22
          Alignment = taRightJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDePiCo: TEditFocus
          Tag = 99
          Left = 169
          Top = 48
          Width = 88
          Height = 22
          Alignment = taRightJustify
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTSCust: TEditFocus
          Tag = 99
          Left = 169
          Top = 25
          Width = 88
          Height = 22
          Alignment = taRightJustify
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTCIFCu: TEditFocus
          Tag = 99
          Left = 169
          Top = 2
          Width = 88
          Height = 22
          Alignment = taRightJustify
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
    end
    object pnlPrecos2: TPanel
      Left = 577
      Top = 2
      Width = 268
      Height = 454
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      ExplicitHeight = 457
      object pnlDesconto: TPanel
        Left = 0
        Top = 228
        Width = 268
        Height = 226
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 4
        ExplicitHeight = 229
        object lblDesMax: TLabel
          Left = 21
          Top = 6
          Width = 138
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto M'#225'ximo Vendedor:'
        end
        object lblDesMaxPor: TLabel
          Left = 246
          Top = 6
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblDesMge: TLabel
          Left = 29
          Top = 52
          Width = 130
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto M'#225'ximo Gerente:'
        end
        object lblDesMgePor: TLabel
          Left = 246
          Top = 52
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblMarMin: TLabel
          Left = 83
          Top = 72
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem M'#237'nima:'
        end
        object lblMarMinPor: TLabel
          Left = 246
          Top = 73
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblImpLis: TLabel
          Left = 94
          Top = 95
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Imprime Lista:'
        end
        object clrImpLis: TColorLabel
          Left = 193
          Top = 95
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblIteAti: TLabel
          Left = 131
          Top = 118
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ativo:'
        end
        object clrIteAti: TColorLabel
          Left = 193
          Top = 118
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblDesMSu: TLabel
          Left = 6
          Top = 28
          Width = 153
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto M'#225'ximo Sub-Gerente:'
        end
        object lblDesMSuPor: TLabel
          Left = 246
          Top = 29
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object edtDesMax: TEditFocus
          Tag = 99
          Left = 160
          Top = 1
          Width = 85
          Height = 22
          Alignment = taRightJustify
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesMGe: TEditFocus
          Tag = 99
          Left = 160
          Top = 46
          Width = 85
          Height = 22
          Alignment = taRightJustify
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtMarMin: TEditFocus
          Tag = 99
          Left = 160
          Top = 68
          Width = 85
          Height = 22
          Alignment = taRightJustify
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtImpLis: TEditFocus
          Tag = 99
          Left = 160
          Top = 90
          Width = 30
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
        object edtIteAti: TEditFocus
          Tag = 99
          Left = 160
          Top = 112
          Width = 30
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
        object edtDesMSu: TEditFocus
          Tag = 99
          Left = 160
          Top = 23
          Width = 85
          Height = 22
          Alignment = taRightJustify
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
      object gpbTabPre07: TcxGroupBox
        Left = 0
        Top = 171
        Align = alTop
        Caption = 'Tabela 7:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 3
        Visible = False
        Height = 57
        Width = 268
        object Label125: TLabel
          Left = 29
          Top = 19
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label126: TLabel
          Left = 123
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
        end
        object Label123: TLabel
          Left = 6
          Top = 40
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitComTb7: TLabel
          Left = 142
          Top = 19
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comiss'#227'o:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblPerComTb7: TLabel
          Left = 246
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
        end
        object edtComTb7: TEditFocus
          Tag = 99
          Left = 203
          Top = 11
          Width = 42
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
        object edtMarBr7: TEditFocus
          Tag = 99
          Left = 80
          Top = 11
          Width = 42
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnEnter = edtMarBr1Enter
          OnExit = edtMarBr1Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
        object edtPreVe7: TEditFocus
          Tag = 99
          Left = 80
          Top = 32
          Width = 165
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
      end
      object gpbTabPre06: TcxGroupBox
        Left = 0
        Top = 114
        Align = alTop
        Caption = 'Tabela 6:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 2
        Visible = False
        Height = 57
        Width = 268
        object Label63: TLabel
          Left = 29
          Top = 19
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblMarBr6: TLabel
          Left = 123
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
        end
        object Label65: TLabel
          Left = 6
          Top = 40
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitComTb6: TLabel
          Left = 142
          Top = 19
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comiss'#227'o:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblPerComTb6: TLabel
          Left = 246
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
        end
        object edtComTb6: TEditFocus
          Tag = 99
          Left = 203
          Top = 11
          Width = 42
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
        object edtMarBr6: TEditFocus
          Tag = 99
          Left = 80
          Top = 11
          Width = 42
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnEnter = edtMarBr1Enter
          OnExit = edtMarBr1Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
        object edtPreVe6: TEditFocus
          Tag = 99
          Left = 80
          Top = 32
          Width = 165
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
      end
      object gpbTabPre05: TcxGroupBox
        Left = 0
        Top = 57
        Align = alTop
        Caption = 'Tabela 5:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Visible = False
        Height = 57
        Width = 268
        object Label54: TLabel
          Left = 29
          Top = 19
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblMarBr5: TLabel
          Left = 123
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
        end
        object Label61: TLabel
          Left = 6
          Top = 40
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitComTb5: TLabel
          Left = 142
          Top = 19
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comiss'#227'o:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblPerComTb5: TLabel
          Left = 246
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
        end
        object edtComTb5: TEditFocus
          Tag = 99
          Left = 203
          Top = 11
          Width = 42
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
        object edtMarBr5: TEditFocus
          Tag = 99
          Left = 80
          Top = 11
          Width = 42
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnEnter = edtMarBr1Enter
          OnExit = edtMarBr1Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
        object edtPreVe5: TEditFocus
          Tag = 99
          Left = 80
          Top = 32
          Width = 165
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
      end
      object gpbTabPre04: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        Caption = 'Tabela 4:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Visible = False
        Height = 57
        Width = 268
        object lblTitMarBr4: TLabel
          Left = 29
          Top = 19
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label10: TLabel
          Left = 123
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
        end
        object lblTitPreVe4: TLabel
          Left = 6
          Top = 40
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitComTb4: TLabel
          Left = 142
          Top = 19
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comiss'#227'o:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblPerComTb4: TLabel
          Left = 246
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
        end
        object edtComTb4: TEditFocus
          Tag = 99
          Left = 203
          Top = 11
          Width = 42
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
        object edtMarBr4: TEditFocus
          Tag = 99
          Left = 80
          Top = 11
          Width = 42
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnEnter = edtMarBr1Enter
          OnExit = edtMarBr1Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
        object edtPreVe4: TEditFocus
          Tag = 99
          Left = 80
          Top = 32
          Width = 165
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '##,#0.00'
        end
      end
    end
    object pnl1: TPanel
      Left = 845
      Top = 2
      Width = 11
      Height = 454
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 1
      ExplicitHeight = 457
    end
  end
  object pnlBotoesEnt: TPanel [5]
    Left = 0
    Top = 672
    Width = 858
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    ExplicitTop = 695
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 735
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnCancelarEntradaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 51
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 51
  end
end
