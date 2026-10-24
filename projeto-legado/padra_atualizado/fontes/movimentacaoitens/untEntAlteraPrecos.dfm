inherited frmEntAlteraPrecos: TfrmEntAlteraPrecos
  Left = 240
  Top = 105
  Width = 857
  Height = 750
  BorderIcons = [biSystemMenu]
  Caption = 'Pre'#231'os de Itens'
  Position = poMainFormCenter
  ExplicitWidth = 857
  ExplicitHeight = 750
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 138
    Width = 851
    ExplicitTop = 138
    ExplicitWidth = 851
    DesignSize = (
      851
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 847
      ExplicitWidth = 847
    end
    inherited btnSair: TBitBtnLocked
      Left = 500
      ExplicitLeft = 500
    end
  end
  inherited pnlStatus: TPanel
    Top = 705
    Width = 851
    ExplicitTop = 705
    ExplicitWidth = 851
    inherited pnlNomeForm: TPanel
      Left = 680
      ExplicitLeft = 680
    end
    inherited pnlInfo: TPanel
      Width = 680
      ExplicitWidth = 680
    end
  end
  inherited pgcDados: TPageControl
    Top = 22
    Width = 851
    Height = 116
    Visible = False
    ExplicitTop = 22
    ExplicitWidth = 851
    ExplicitHeight = 116
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 843
      ExplicitHeight = 84
    end
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 0
    Width = 851
    Height = 22
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'PRE'#199'OS DE ITENS'
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 22
    Width = 851
    Height = 116
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDblClick = dbgItensDblClick
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ENT_CODITE'
        Title.Alignment = taCenter
        Title.Caption = 'Item'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_DESITE'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o'
        Width = 563
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_REFERE'
        Title.Alignment = taCenter
        Title.Caption = 'Refer'#234'ncia'
        Width = 199
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_CODUNI'
        Title.Alignment = taCenter
        Title.Caption = 'UN'
        Width = 30
        Visible = True
      end>
  end
  object pnlPrecos: TPanel [5]
    Left = 0
    Top = 171
    Width = 851
    Height = 506
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 6
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 559
      Height = 502
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label13: TLabel
        Left = 87
        Top = 11
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o Compra:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        StyleElements = [seClient, seBorder]
      end
      object Label24: TLabel
        Left = 79
        Top = 319
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sub. Tribut'#225'ria (+):'
      end
      object Label43: TLabel
        Left = 262
        Top = 319
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label14: TLabel
        Left = 90
        Top = 32
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto 01 (-):'
      end
      object Label33: TLabel
        Left = 262
        Top = 32
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label26: TLabel
        Left = 340
        Top = 10
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Custo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        StyleElements = [seClient, seBorder]
      end
      object Label15: TLabel
        Left = 139
        Top = 54
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '02 (-):'
      end
      object Label34: TLabel
        Left = 262
        Top = 54
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label25: TLabel
        Left = 356
        Top = 56
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'ICMS Sa'#237'da (+):'
      end
      object Label16: TLabel
        Left = 139
        Top = 75
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '03 (-):'
      end
      object Label35: TLabel
        Left = 262
        Top = 75
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label1: TLabel
        Left = 334
        Top = 76
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Imposto Federal (+):'
      end
      object Label2: TLabel
        Left = 521
        Top = 76
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label17: TLabel
        Left = 139
        Top = 97
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '04 (-):'
      end
      object Label36: TLabel
        Left = 262
        Top = 97
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label6: TLabel
        Left = 353
        Top = 98
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desp. Oper. (+):'
      end
      object lblDesOpePer: TLabel
        Left = 521
        Top = 98
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label18: TLabel
        Left = 139
        Top = 119
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '05 (-):'
      end
      object Label37: TLabel
        Left = 262
        Top = 119
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label19: TLabel
        Left = 139
        Top = 141
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = '06 (-):'
      end
      object Label38: TLabel
        Left = 262
        Top = 140
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label20: TLabel
        Left = 87
        Top = 185
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'ICMS Entrada (-):'
      end
      object Label39: TLabel
        Left = 262
        Top = 185
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label21: TLabel
        Left = 99
        Top = 230
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'IPI Entrada (+):'
      end
      object Label40: TLabel
        Left = 262
        Top = 231
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label22: TLabel
        Left = 124
        Top = 252
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Frete (+):'
      end
      object Label41: TLabel
        Left = 262
        Top = 252
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label23: TLabel
        Left = 72
        Top = 294
        Width = 97
        Height = 14
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo Final (+):'
      end
      object Label42: TLabel
        Left = 262
        Top = 293
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblValFre: TLabel
        Left = 96
        Top = 274
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Frete (+):'
      end
      object lblDesAdi: TLabel
        Left = 6
        Top = 342
        Width = 163
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descontos Adicionais (Boleto) (-):'
      end
      object Label9: TLabel
        Left = 263
        Top = 342
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label10: TLabel
        Left = 75
        Top = 208
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Imposto Federal (-):'
      end
      object Label11: TLabel
        Left = 262
        Top = 208
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblOutVal: TLabel
        Left = 337
        Top = 33
        Width = 93
        Height = 14
        Alignment = taRightJustify
        Caption = 'Outros Valores (+):'
      end
      object lblTabPre: TLabel
        Left = 277
        Top = 123
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
        StyleElements = [seClient, seBorder]
      end
      object Label137: TLabel
        Left = 67
        Top = 165
        Width = 102
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre. Compra L'#237'qu.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        StyleElements = [seClient, seBorder]
      end
      object edtPreCom: TEditFocus
        Tag = 99
        Left = 173
        Top = 3
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
        Left = 173
        Top = 311
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
      object edtDesf01: TEditFocus
        Tag = 99
        Left = 173
        Top = 24
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
      object edtPreCus: TEditFocus
        Left = 432
        Top = 2
        Width = 88
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 16
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
        Left = 173
        Top = 46
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
      object edtIcmSai: TEditFocus
        Tag = 99
        Left = 432
        Top = 47
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
        EditFormat = '#,##0.00'
      end
      object edtDesf03: TEditFocus
        Tag = 99
        Left = 173
        Top = 67
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
      object edtImpFed: TEditFocus
        Tag = 99
        Left = 432
        Top = 68
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
      object edtDesf04: TEditFocus
        Tag = 99
        Left = 173
        Top = 89
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
      object edtDesOpe: TEditFocus
        Tag = 99
        Left = 432
        Top = 90
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
      object edtDesf05: TEditFocus
        Tag = 99
        Left = 173
        Top = 111
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
      object edtDesf06: TEditFocus
        Tag = 99
        Left = 173
        Top = 133
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
      object edtIcmEnt: TEditFocus
        Tag = 99
        Left = 173
        Top = 177
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
      object edtIpiEnt: TEditFocus
        Tag = 99
        Left = 173
        Top = 222
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
      object edtFreEnt: TEditFocus
        Tag = 99
        Left = 173
        Top = 244
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
      object edtAcrFin: TEditFocus
        Tag = 99
        Left = 173
        Top = 288
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
      object edtValFre: TEditFocus
        Tag = 99
        Left = 173
        Top = 266
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
      object edtDesAdb: TEditFocus
        Tag = 99
        Left = 173
        Top = 334
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
      object edtSubFed: TEditFocus
        Tag = 99
        Left = 173
        Top = 200
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
      object edtOutVal: TEditFocus
        Tag = 99
        Left = 432
        Top = 24
        Width = 88
        Height = 22
        Alignment = taRightJustify
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.000'
      end
      object Panel3: TPanel
        Left = 278
        Top = 137
        Width = 274
        Height = 246
        BevelOuter = bvNone
        Color = 16770261
        TabOrder = 21
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
            Transparent = False
            StyleElements = [seClient, seBorder]
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
            Transparent = False
            StyleElements = [seClient, seBorder]
          end
          object lblMarBr1: TLabel
            Left = 123
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = False
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
            Transparent = False
            StyleElements = [seClient, seBorder]
          end
          object lblPerComTb1: TLabel
            Left = 246
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = False
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
            Transparent = False
            StyleElements = [seClient, seBorder]
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
            Transparent = False
            StyleElements = [seClient, seBorder]
          end
          object lblMarBr2: TLabel
            Left = 123
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = False
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
            Transparent = False
            StyleElements = [seClient, seBorder]
          end
          object lblPerComTb2: TLabel
            Left = 246
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = False
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
            Transparent = False
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
            Transparent = False
            StyleElements = [seClient, seBorder]
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
            Transparent = False
            StyleElements = [seClient, seBorder]
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
            Transparent = False
            StyleElements = [seClient, seBorder]
          end
          object lblPerComTb3: TLabel
            Left = 246
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = False
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
        object gpbTabPre04: TcxGroupBox
          Left = 0
          Top = 174
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
          TabOrder = 3
          Visible = False
          Height = 58
          Width = 274
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
            Transparent = False
            StyleElements = [seClient, seBorder]
          end
          object lblMarBr4: TLabel
            Left = 123
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = False
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
            Transparent = False
            StyleElements = [seClient, seBorder]
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
            Transparent = False
            StyleElements = [seClient, seBorder]
          end
          object lblPerComTb4: TLabel
            Left = 246
            Top = 17
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = False
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
      object edtComLiq: TEditFocus
        Left = 173
        Top = 155
        Width = 88
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 22
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object pnlSuframa: TPanel
        Left = 4
        Top = 357
        Width = 272
        Height = 141
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 15
        object Label7: TLabel
          Left = 259
          Top = 8
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label8: TLabel
          Left = 259
          Top = 31
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label12: TLabel
          Left = 259
          Top = 53
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label27: TLabel
          Left = 259
          Top = 76
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label28: TLabel
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
    object Panel2: TPanel
      Left = 561
      Top = 2
      Width = 277
      Height = 502
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Panel6: TPanel
        Left = 0
        Top = 174
        Width = 277
        Height = 328
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        object lblDesMax: TLabel
          Left = 74
          Top = 16
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desc.M'#225'ximo:'
        end
        object lblMarMin: TLabel
          Left = 65
          Top = 39
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem M'#237'nima:'
        end
        object Label4: TLabel
          Left = 14
          Top = 62
          Width = 127
          Height = 14
          Alignment = taRightJustify
          Caption = 'NCM / Classifica'#231#227'o de IPI:'
        end
        object edtDesMax: TEditFocus
          Tag = 99
          Left = 143
          Top = 8
          Width = 102
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtMarMin: TEditFocus
          Tag = 99
          Left = 143
          Top = 31
          Width = 102
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object gpbUltCompra: TGroupBox
          Left = 0
          Top = 83
          Width = 270
          Height = 98
          Caption = #218'ltima Compra'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          StyleElements = [seClient, seBorder]
          object Label86: TLabel
            Left = 5
            Top = 25
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label87: TLabel
            Left = 4
            Top = 48
            Width = 26
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtde:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label88: TLabel
            Left = 148
            Top = 25
            Width = 31
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label94: TLabel
            Left = 117
            Top = 48
            Width = 62
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o M'#233'dio:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label93: TLabel
            Left = 6
            Top = 74
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fornecedor:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtUltCom: TEditFocus
            Left = 32
            Top = 20
            Width = 84
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtQtdUco: TEditFocus
            Left = 32
            Top = 43
            Width = 84
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,###0.000'
          end
          object edtPreUlt: TEditFocus
            Left = 181
            Top = 20
            Width = 84
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtPreMed: TEditFocus
            Left = 181
            Top = 43
            Width = 84
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
            EditFormat = '#,##0.00'
          end
          object edtNomUltFor: TEditFocus
            Left = 66
            Top = 66
            Width = 199
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object edtClaIpi: TEditFocus
          Tag = 99
          Left = 143
          Top = 54
          Width = 102
          Height = 22
          Alignment = taRightJustify
          MaxLength = 10
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbTabPre05: TcxGroupBox
        Left = 0
        Top = 0
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
        TabOrder = 0
        Visible = False
        Height = 58
        Width = 277
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
          Transparent = False
          StyleElements = [seClient, seBorder]
        end
        object lblMarBr5: TLabel
          Left = 123
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = False
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
          Transparent = False
          StyleElements = [seClient, seBorder]
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
          Transparent = False
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb5: TLabel
          Left = 246
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = False
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
      object gpbTabPre06: TcxGroupBox
        Left = 0
        Top = 58
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
        TabOrder = 1
        Visible = False
        Height = 58
        Width = 277
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
          Transparent = False
          StyleElements = [seClient, seBorder]
        end
        object lblMarBr6: TLabel
          Left = 123
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = False
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
          Transparent = False
          StyleElements = [seClient, seBorder]
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
          Transparent = False
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb6: TLabel
          Left = 246
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = False
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
      object gpbTabPre07: TcxGroupBox
        Left = 0
        Top = 116
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
        TabOrder = 2
        Visible = False
        Height = 58
        Width = 277
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
          Transparent = False
          StyleElements = [seClient, seBorder]
        end
        object Label126: TLabel
          Left = 123
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = False
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
          Transparent = False
          StyleElements = [seClient, seBorder]
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
          Transparent = False
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb7: TLabel
          Left = 246
          Top = 17
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = False
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
    end
    object pnl1: TPanel
      Left = 838
      Top = 2
      Width = 11
      Height = 502
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 2
    end
  end
  object pnlBotoesEnt: TPanel [6]
    Left = 0
    Top = 677
    Width = 851
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 7
    object btnConfirma: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnUltCmp: TBitBtnLocked
      Left = 323
      Top = 3
      Width = 141
      Height = 22
      Caption = '[ F8 ] '#218'ltimas Compras'
      TabOrder = 1
      OnClick = btnUltCmpClick
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 730
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnCancelarEntradaClick
    end
  end
  object pnlTipAlt: TPanel [7]
    Left = 0
    Top = 138
    Width = 851
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 5
    object rdgTipAlt: TRadioGroup
      Left = 0
      Top = 0
      Width = 851
      Height = 33
      Align = alClient
      Caption = 'Tipo de Altera'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Altera Pre'#231'o de Venda'
        'Altera Margem de Lucro')
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 80
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 80
  end
end
