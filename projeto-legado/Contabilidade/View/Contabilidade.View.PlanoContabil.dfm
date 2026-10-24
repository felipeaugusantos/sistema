inherited frmPlanoContabil: TfrmPlanoContabil
  Left = 578
  Top = 392
  Width = 576
  Height = 461
  Caption = 'Plano Cont'#225'bil'
  Position = poScreenCenter
  ExplicitWidth = 576
  ExplicitHeight = 461
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 391
    Width = 570
    Height = 25
    ExplicitTop = 391
    ExplicitWidth = 570
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 566
      Height = 21
      ExplicitWidth = 566
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 80
        ExplicitWidth = 80
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 497
      Width = 70
      Height = 20
      ExplicitLeft = 497
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 416
    Width = 570
    ExplicitTop = 416
    ExplicitWidth = 570
    inherited pnlNomeForm: TPanel
      Left = 343
      Width = 227
      ExplicitLeft = 343
      ExplicitWidth = 227
    end
    inherited pnlInfo: TPanel
      Width = 343
      ExplicitWidth = 343
    end
  end
  inherited pgcDados: TPageControl
    Width = 570
    Height = 391
    TabOrder = 3
    ExplicitWidth = 570
    ExplicitHeight = 391
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 562
      ExplicitHeight = 359
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 570
    Height = 391
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object pnlContaRef: TPanel
      Left = 1
      Top = 192
      Width = 568
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object lblContaRef: TLabel
        Left = 43
        Top = 7
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta Refer.:'
      end
      object dbeCtaRef: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 4
        Width = 157
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NCO_CTAREF'
        DataSource = dtsPlaNco
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = dbeCtaRefKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtDescricaoCtaRef: TEditFocus
        Left = 272
        Top = 4
        Width = 261
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
    object pnlCampos: TPanel
      Left = 1
      Top = 1
      Width = 568
      Height = 116
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label2: TLabel
        Left = 54
        Top = 39
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label1: TLabel
        Left = 75
        Top = 14
        Width = 31
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta:'
      end
      object Label3: TLabel
        Left = 27
        Top = 64
        Width = 79
        Height = 14
        Caption = 'Conta Reduzida:'
      end
      object Label101: TLabel
        Left = 28
        Top = 85
        Width = 78
        Height = 28
        Alignment = taRightJustify
        Caption = 'Tipo Plano de Contas Cont'#225'bil:'
        WordWrap = True
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 36
        Width = 424
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NCO_DESCRI'
        DataSource = dtsPlaNco
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeConta: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 11
        Width = 157
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NCO_CODCON'
        DataSource = dtsPlaNco
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnExit = dbeContaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeConRed: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 61
        Width = 424
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NCO_CONRED'
        DataSource = dtsPlaNco
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTplAco: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 90
        Width = 64
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'NCO_TPLACO'
        DataSource = dtsPlaNco
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
      object edtDescricaoDoTipoDePlanoDeContaContabil: TEditFocus
        Left = 177
        Top = 90
        Width = 356
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object dbcApurac: TDBCheckBox
        Left = 284
        Top = 14
        Width = 197
        Height = 17
        Caption = 'Apura'#231#227'o ap'#243's o lucro operacional?'
        DataField = 'NCO_APURAC'
        DataSource = dtsPlaNco
        TabOrder = 1
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    object pnlNatAju: TPanel
      Left = 1
      Top = 252
      Width = 568
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 5
      object lblNatAju: TLabel
        Left = 11
        Top = 7
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Natureza do Ajuste:'
      end
      object edtDescricaoNatAjuste: TEditFocus
        Left = 177
        Top = 4
        Width = 356
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
      object dbeNatAju: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 4
        Width = 64
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NCO_NATAJU'
        DataSource = dtsPlaNco
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeNatAjuKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlAjuLiq: TPanel
      Left = 1
      Top = 222
      Width = 568
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      object lblAjuLiq: TLabel
        Left = 11
        Top = 7
        Width = 248
        Height = 14
        Caption = 'Lan'#231'amentos representam ajustes do lucro l'#237'quido?'
      end
      object cbxAjuLiq: TComboBoxFocus
        Left = 265
        Top = 4
        Width = 100
        Height = 22
        Enabled = False
        TabOrder = 0
        OnChange = cbxAjuLiqChange
        Items.Strings = (
          'Nunca'
          'Sempre')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object btnAjudaAjustes: TBitBtnLocked
        Left = 371
        Top = 4
        Width = 22
        Height = 22
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000800000010000000100000
          0008000000010000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000006301D125F8A4B2DED854525ED2814
          0B60000000070000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000D9F6A48EAD8A471FFD3985FFF8245
          27EA0000000E0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000CAB7F5DECF5D9AEFFDEB285FF8D50
          2FEC0000000D0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000532271F50A18368D29D7C60D22F23
          1A51000000050000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000600000011000000140000
          000A000000020000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000066F503AA999532EFF4528
          187A000000070000000100000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000079F7959D7E5BF92FFAE71
          4AF724150D490000000800000002000000000000000000000000000000000000
          0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
          9FFFB4774BFF683D23AE0D080520000000020000000000000000000000000000
          000000000000000000034C301E7A7A4526D0522F1A8F0A09071A9A6745E0ECD2
          AAFFF6D39CFFD8A470FF74452ABD000000060000000000000000000000000000
          00000000000000000005B5855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
          76FFF8E7BCFFF3CC95FFA0623AF7000000070000000000000000000000000000
          000000000000000000039B7D5EC9EFDDBFFFCAA682FF7E5E44B2917C61B4C197
          70FFF9ECC4FFE8CCA4FF845434C7000000050000000000000000000000000000
          000000000000000000012B241D38CEAE8BF7E8D2B3FFCBA888FFBF9674FFF0E1
          C5FFDDBF9EFFAE7C58F01F140D34000000010000000000000000000000000000
          0000000000000000000000000001231E182D877157A5C2A07CEED9BA96FFBA99
          77E570533B9A17100A2500000002000000000000000000000000000000000000
          0000000000000000000000000000000000010000000100000002000000030000
          0002000000020000000100000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TabStop = False
      end
    end
    object pnlCompl: TPanel
      Left = 1
      Top = 282
      Width = 568
      Height = 106
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object dbrgNature: TcxDBRadioGroup
        Tag = 99
        Left = 109
        Top = 6
        Caption = 'Natureza'
        DataBinding.DataField = 'NCO_NATURE'
        DataBinding.DataSource = dtsPlaNco
        Properties.Columns = 2
        Properties.DefaultValue = 'A'
        Properties.Items = <
          item
            Caption = 'Anal'#237'tico'
            Value = 'A'
          end
          item
            Caption = 'Sint'#233'tico'
            Value = 'S'
          end>
        Properties.OnEditValueChanged = dbrgNaturePropertiesEditValueChanged
        TabOrder = 0
        Height = 43
        Width = 185
      end
      object dbrgFinali: TcxDBRadioGroup
        Tag = 99
        Left = 348
        Top = 6
        Caption = 'Finalidade'
        DataBinding.DataField = 'NCO_FINALI'
        DataBinding.DataSource = dtsPlaNco
        Properties.Columns = 2
        Properties.DefaultValue = 'C'
        Properties.Items = <
          item
            Caption = 'Credora'
            Value = 'C'
          end
          item
            Caption = 'Devedora'
            Value = 'D'
          end>
        TabOrder = 1
        Height = 43
        Width = 185
      end
      object dbrgRedutora: TcxDBRadioGroup
        Tag = 99
        Left = 109
        Top = 55
        Caption = 'Redutora'
        DataBinding.DataField = 'NCO_REDUTO'
        DataBinding.DataSource = dtsPlaNco
        Properties.Columns = 2
        Properties.DefaultValue = 'N'
        Properties.Items = <
          item
            Caption = 'Sim'
            Value = 'S'
          end
          item
            Caption = 'N'#227'o'
            Value = 'N'
          end>
        TabOrder = 2
        Height = 43
        Width = 185
      end
      object dbrgPatrimonial: TcxDBRadioGroup
        Tag = 99
        Left = 348
        Top = 55
        Caption = 'Patrimonial'
        DataBinding.DataField = 'NCO_PATRIM'
        DataBinding.DataSource = dtsPlaNco
        Properties.Columns = 2
        Properties.DefaultValue = 'N'
        Properties.Items = <
          item
            Caption = 'Sim'
            Value = 'S'
          end
          item
            Caption = 'N'#227'o'
            Value = 'N'
          end>
        TabOrder = 3
        Height = 43
        Width = 185
      end
    end
    object pnlVigencia: TPanel
      Left = 1
      Top = 117
      Width = 568
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 1
      object Label4: TLabel
        Left = 32
        Top = 4
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vig'#234'ncia Inicial:'
      end
      object Label5: TLabel
        Left = 227
        Top = 4
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vig'#234'ncia Final:'
      end
      object dbeDtaIni: TDBEditFocus
        Tag = 99
        Left = 109
        Top = 1
        Width = 108
        Height = 22
        CharCase = ecUpperCase
        DataSource = dtsPlaNco
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaFin: TDBEditFocus
        Tag = 99
        Left = 300
        Top = 1
        Width = 108
        Height = 22
        CharCase = ecUpperCase
        DataSource = dtsPlaNco
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlSubCnt: TPanel
      Left = 1
      Top = 147
      Width = 568
      Height = 45
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object dbrgSubcontas: TcxDBRadioGroup
        Tag = 99
        Left = 109
        Top = -2
        Caption = 'Essa conta ter'#225' seu desmembramento em subcontas?'
        DataBinding.DataField = 'NCO_SUBCNT'
        DataBinding.DataSource = dtsPlaNco
        Properties.Columns = 2
        Properties.DefaultValue = 'N'
        Properties.Items = <
          item
            Caption = 'Sim'
            Value = 'S'
          end
          item
            Caption = 'N'#227'o'
            Value = 'N'
          end>
        TabOrder = 0
        Height = 43
        Width = 279
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 440
    Top = 8
  end
  object dtsPlaNco: TDataSource
    OnDataChange = dtsPlaNcoDataChange
    Left = 408
    Top = 8
  end
end
