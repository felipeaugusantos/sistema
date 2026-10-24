inherited frmFatDadosCTe: TfrmFatDadosCTe
  Height = 716
  BorderIcons = [biSystemMenu]
  Caption = 'Dados do Conhecimento de Transporte Eletr'#244'nico'
  Position = poMainFormCenter
  ExplicitHeight = 716
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 410
    Align = alNone
    ExplicitTop = 410
    inherited FlwBotoes: TFlowPanel
      Enabled = False
    end
    inherited btnSair: TBitBtnLocked
      Left = 688
      Top = -53
      Visible = False
      ExplicitLeft = 688
      ExplicitTop = -53
    end
  end
  inherited pnlStatus: TPanel
    Top = 671
    TabOrder = 4
    ExplicitTop = 671
  end
  inherited pgcDados: TPageControl
    Height = 100
    Align = alNone
    TabOrder = 3
    Visible = False
    ExplicitHeight = 100
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 68
    end
  end
  object pnlDadosCTe: TPanel [3]
    Left = 0
    Top = 0
    Width = 769
    Height = 643
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 769
      Height = 155
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 163
        Top = 86
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'CFOP:'
      end
      object Label2: TLabel
        Left = 80
        Top = 11
        Width = 113
        Height = 14
        Alignment = taRightJustify
        Caption = 'Natureza da Opera'#231#227'o:'
      end
      object Label3: TLabel
        Left = 140
        Top = 36
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'S'#233'rie CT-e:'
      end
      object Label4: TLabel
        Left = 94
        Top = 61
        Width = 99
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tomador do Servi'#231'o:'
      end
      object Label5: TLabel
        Left = 65
        Top = 111
        Width = 128
        Height = 14
        Alignment = taRightJustify
        Caption = 'Papel Tomador do Servi'#231'o:'
      end
      object lblValorFrete: TLabel
        Left = 122
        Top = 136
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do Frete:'
      end
      object edtCFOP: TEditFocus
        Tag = 99
        Left = 196
        Top = 83
        Width = 53
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 4
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
      object edtNaturezaOp: TEditFocus
        Tag = 99
        Left = 196
        Top = 8
        Width = 564
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 60
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSerie: TEditFocus
        Tag = 99
        Left = 196
        Top = 33
        Width = 44
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
      object cmbTomadorServ: TComboBoxFocus
        Tag = 99
        Left = 196
        Top = 58
        Width = 124
        Height = 22
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemIndex = 0
        ParentFont = False
        TabOrder = 2
        Text = '0 - Remetente'
        OnChange = cmbTomadorServChange
        Items.Strings = (
          '0 - Remetente'
          '3 - Destinat'#225'rio')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbPapelTomador: TComboBoxFocus
        Tag = 99
        Left = 196
        Top = 108
        Width = 224
        Height = 22
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemIndex = 0
        ParentFont = False
        TabOrder = 4
        Text = '1 - Contribuinte ICMS'
        OnChange = cmbPapelTomadorChange
        Items.Strings = (
          '1 - Contribuinte ICMS'
          '2 - Contribuinte isento de inscri'#231#227'o'
          '9 - N'#227'o Contribuinte')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtValorFrete: TEditFocus
        Tag = 99
        Left = 196
        Top = 133
        Width = 151
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    end
    object pnlIcms: TPanel
      Left = 0
      Top = 155
      Width = 769
      Height = 219
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object gpbICMS: TGroupBox
        Left = 0
        Top = 0
        Width = 769
        Height = 219
        Align = alClient
        Caption = 'ICMS'
        TabOrder = 0
        object Label10: TLabel
          Left = 24
          Top = 16
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo da Classifica'#231#227'o Tribut'#225'ria:'
        end
        object lblPercRedBC: TLabel
          Left = 44
          Top = 41
          Width = 147
          Height = 14
          Alignment = taRightJustify
          Caption = 'Percentual de Redu'#231#227'o da BC:'
        end
        object lblValorBC: TLabel
          Left = 89
          Top = 66
          Width = 102
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor da BC do ICMS:'
        end
        object lblAliquota: TLabel
          Left = 107
          Top = 91
          Width = 84
          Height = 14
          Alignment = taRightJustify
          Caption = 'Al'#237'quota do ICMS:'
        end
        object lblValorImposto: TLabel
          Left = 121
          Top = 116
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor do ICMS:'
        end
        object lblValorCredito: TLabel
          Left = 4
          Top = 141
          Width = 187
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor do Cr'#233'dito Outorgado/Presumido:'
        end
        object btnCalcImposto: TSpeedButton
          Left = 351
          Top = 88
          Width = 24
          Height = 22
          Hint = 'Calcular Valor do ICMS'
          Flat = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000330B0000330B00000001000000010000BD4D0100CB57
            0000CC5A2A00A4676900D2851A00E7AC1D00E89B2700CF8E6800FF00FF00F3BB
            9F00FFCFA500FFD6B500FFDFC300FEEBD800FFEFDE0000000000000000000000
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
            0000000000000000000000000000000000000000000000000000080808080808
            0808080808080808080808080808080808080808080808080808080101010101
            0101010101010101010805090909090909090909090909090901050C09090B09
            090A09090B09090A0901050D02000B01000A01000A01000A0901050D09090C09
            090B09090A09090A0901050D02000D01000B01000A01000A0901050D0D0D0D0D
            0C0B0B0B0B0A0A0A0901050D0707070707070707070B0A0A0901050D030E0E0E
            0E0E0E0E070B0B0A0901050D0303030303030303030C0B0B0901050D0D0D0D0D
            0D0D0D0D0D0D0D0C090108060606060606060606060606060408080808080808
            0808080808080808080808080808080808080808080808080808}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCalcImpostoClick
        end
        object cmbCodigoClassTrib: TComboBoxFocus
          Tag = 99
          Left = 194
          Top = 13
          Width = 417
          Height = 22
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemIndex = 1
          ParentFont = False
          TabOrder = 0
          Text = '00 - Tributa'#231#227'o normal ICMS'
          OnChange = cmbCodigoClassTribChange
          Items.Strings = (
            '1 - SIMPLES NACIONAL'
            '00 - Tributa'#231#227'o normal ICMS'
            '20 - Tributa'#231#227'o com BC reduzida do ICMS'
            '40 - ICMS isen'#231#227'o'
            '41 - ICMS n'#227'o tributada'
            '51 - ICMS diferido'
            '60 - ICMS cobrado anteriormente por substitui'#231#227'o tribut'#225'ria'
            '90 - ICMS outros'
            
              '90 - ICMS devido a UF de origem de presta'#231#227'o, quando diferente d' +
              'a UF')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtPercReducaoBC: TEditFocus
          Tag = 99
          Left = 194
          Top = 38
          Width = 151
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtValorBC: TEditFocus
          Tag = 99
          Left = 194
          Top = 63
          Width = 151
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnExit = edtValorBCExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtAliquota: TEditFocus
          Tag = 99
          Left = 194
          Top = 88
          Width = 151
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          OnExit = edtValorBCExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtValorImposto: TEditFocus
          Tag = 99
          Left = 194
          Top = 113
          Width = 151
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtValorCredito: TEditFocus
          Left = 194
          Top = 138
          Width = 151
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object gpbPartilha: TGroupBox
          Left = 394
          Top = 35
          Width = 361
          Height = 182
          TabOrder = 6
          Visible = False
          object Label15: TLabel
            Left = 8
            Top = 9
            Width = 165
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Base Calc. ICMS UF Destino:'
          end
          object Label16: TLabel
            Left = 31
            Top = 34
            Width = 142
            Height = 14
            Alignment = taRightJustify
            Caption = 'Aliq. ICMS Interna UF Destino:'
          end
          object Label17: TLabel
            Left = 57
            Top = 59
            Width = 116
            Height = 14
            Alignment = taRightJustify
            Caption = 'Aliq. ICMS Interestadual:'
          end
          object Label18: TLabel
            Left = 39
            Top = 84
            Width = 134
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor ICMS Partilha T'#233'rmino:'
          end
          object Label19: TLabel
            Left = 53
            Top = 109
            Width = 120
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor ICMS Partilha In'#237'cio:'
          end
          object Label20: TLabel
            Left = 109
            Top = 134
            Width = 64
            Height = 14
            Alignment = taRightJustify
            Caption = 'Al'#237'quota FCP:'
          end
          object Label21: TLabel
            Left = 84
            Top = 159
            Width = 89
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor FCP Destino:'
          end
          object btnCalcImpostoPart: TSpeedButton
            Left = 331
            Top = 79
            Width = 24
            Height = 22
            Hint = 'Calcular Valor do ICMS'
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000330B0000330B00000001000000010000BD4D0100CB57
              0000CC5A2A00A4676900D2851A00E7AC1D00E89B2700CF8E6800FF00FF00F3BB
              9F00FFCFA500FFD6B500FFDFC300FEEBD800FFEFDE0000000000000000000000
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
              0000000000000000000000000000000000000000000000000000080808080808
              0808080808080808080808080808080808080808080808080808080101010101
              0101010101010101010805090909090909090909090909090901050C09090B09
              090A09090B09090A0901050D02000B01000A01000A01000A0901050D09090C09
              090B09090A09090A0901050D02000D01000B01000A01000A0901050D0D0D0D0D
              0C0B0B0B0B0A0A0A0901050D0707070707070707070B0A0A0901050D030E0E0E
              0E0E0E0E070B0B0A0901050D0303030303030303030C0B0B0901050D0D0D0D0D
              0D0D0D0D0D0D0D0C090108060606060606060606060606060408080808080808
              0808080808080808080808080808080808080808080808080808}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnCalcImpostoPartClick
          end
          object edtValorBaseCalculoIcmsUfDestino: TEditFocus
            Tag = 99
            Left = 176
            Top = 6
            Width = 151
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = edtAliquotaIcmsInterestadualExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAliquotaIcmsInternaUfDestino: TEditFocus
            Tag = 99
            Left = 176
            Top = 31
            Width = 151
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            OnExit = edtAliquotaIcmsInterestadualExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtAliquotaIcmsInterestadual: TEditFocus
            Tag = 99
            Left = 176
            Top = 56
            Width = 151
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            OnExit = edtAliquotaIcmsInterestadualExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorIcmsPartilhaTermino: TEditFocus
            Tag = 99
            Left = 176
            Top = 81
            Width = 151
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
            EditFormat = '#,##0.00'
          end
          object edtValorIcmsPartilhaInicio: TEditFocus
            Left = 176
            Top = 106
            Width = 151
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          object edtAliquotaFcp: TEditFocus
            Tag = 99
            Left = 176
            Top = 131
            Width = 151
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          object edtValorFcpDestino: TEditFocus
            Left = 176
            Top = 156
            Width = 151
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        end
      end
    end
    object pnlDados2: TPanel
      Left = 0
      Top = 374
      Width = 769
      Height = 102
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label6: TLabel
        Left = 85
        Top = 8
        Width = 108
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto Predominante:'
      end
      object Label7: TLabel
        Left = 86
        Top = 33
        Width = 107
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o do Servi'#231'o:'
      end
      object Label8: TLabel
        Left = 82
        Top = 58
        Width = 111
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade de Cargas:'
      end
      object Label9: TLabel
        Left = 10
        Top = 75
        Width = 183
        Height = 28
        Alignment = taRightJustify
        Caption = 'Registro Nacional de Transportadores Rodovi'#225'rios de Carga:'
        WordWrap = True
      end
      object edtProdutoPredom: TEditFocus
        Tag = 99
        Left = 199
        Top = 6
        Width = 564
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 60
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDescricaoServ: TEditFocus
        Tag = 99
        Left = 196
        Top = 30
        Width = 385
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdeCargas: TEditFocus
        Tag = 99
        Left = 196
        Top = 55
        Width = 151
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.0000'
      end
      object edtRNTRC: TEditFocus
        Tag = 99
        Left = 196
        Top = 80
        Width = 151
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
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
    object pnlFinanceiro: TPanel
      Left = 0
      Top = 476
      Width = 769
      Height = 164
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object gpbFinanceiro: TGroupBox
        Left = 0
        Top = 0
        Width = 769
        Height = 164
        Align = alClient
        Caption = 'Financeiro'
        TabOrder = 0
        object Label11: TLabel
          Left = 147
          Top = 17
          Width = 44
          Height = 14
          Hint = '888'
          Alignment = taRightJustify
          Caption = 'Portador:'
        end
        object Label13: TLabel
          Left = 90
          Top = 67
          Width = 101
          Height = 14
          Hint = '999'
          Alignment = taRightJustify
          Caption = 'Cnd. Pag.  (A Pagar):'
        end
        object Label14: TLabel
          Left = 80
          Top = 117
          Width = 111
          Height = 14
          Hint = '999'
          Alignment = taRightJustify
          Caption = 'Cnd. Pag.  (A receber):'
        end
        object edtCodPor: TEditFocus
          Tag = 99
          Left = 194
          Top = 14
          Width = 69
          Height = 22
          Hint = '888'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodPorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomPor: TEditFocus
          Left = 265
          Top = 14
          Width = 347
          Height = 22
          Hint = '888'
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object mskConPagPagar: TMaskEditFocus
          Tag = 99
          Left = 194
          Top = 64
          Width = 418
          Height = 22
          Hint = '999'
          AutoSize = False
          EditMask = 
            '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
            '99.999.999.999.999.999.999.999.999;0;'
          MaxLength = 98
          TabOrder = 3
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object mskConPagReceber: TMaskEditFocus
          Tag = 99
          Left = 194
          Top = 114
          Width = 419
          Height = 22
          Hint = '999'
          AutoSize = False
          EditMask = 
            '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
            '99.999.999.999.999.999.999.999.999;0;'
          MaxLength = 98
          TabOrder = 5
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        inline fraPlanoDeContasPga: TfraPlanoDeContasMskEdit
          Left = 89
          Top = 39
          Width = 534
          Height = 22
          TabOrder = 2
          ExplicitLeft = 89
          ExplicitTop = 39
          ExplicitWidth = 534
          inherited lblPlaContas: TLabel
            Left = 2
            Top = 3
            Width = 100
            Height = 14
            Caption = 'Pl. Contas (A pagar):'
            ExplicitLeft = 2
            ExplicitTop = 3
            ExplicitWidth = 100
            ExplicitHeight = 14
          end
          inherited edtDesCta: TEditFocus
            Left = 176
            Width = 347
            Height = 22
            ExplicitLeft = 176
            ExplicitWidth = 347
            ExplicitHeight = 22
          end
          inherited MskCodCta: TMaskEdit
            Left = 105
            Width = 69
            Height = 22
            ExplicitLeft = 105
            ExplicitWidth = 69
            ExplicitHeight = 22
          end
        end
        inline fraPlanoDeContasRec: TfraPlanoDeContasMskEdit
          Left = 79
          Top = 89
          Width = 544
          Height = 22
          TabOrder = 4
          ExplicitLeft = 79
          ExplicitTop = 89
          ExplicitWidth = 544
          inherited lblPlaContas: TLabel
            Left = 2
            Width = 110
            Height = 14
            Caption = 'Pl. Contas (A receber):'
            ExplicitLeft = 2
            ExplicitWidth = 110
            ExplicitHeight = 14
          end
          inherited edtDesCta: TEditFocus
            Left = 186
            Width = 347
            Height = 22
            ExplicitLeft = 186
            ExplicitWidth = 347
            ExplicitHeight = 22
          end
          inherited MskCodCta: TMaskEdit
            Left = 115
            Width = 69
            Height = 22
            ExplicitLeft = 115
            ExplicitWidth = 69
            ExplicitHeight = 22
          end
        end
        object pnlImpBol: TPanel
          Left = 3
          Top = 137
          Width = 366
          Height = 24
          BevelOuter = bvNone
          TabOrder = 6
          object Label12: TLabel
            Left = 106
            Top = 5
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'Imprimir o Boleto: '
          end
          object ColorLabel3: TColorLabel
            Left = 212
            Top = 5
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object edtImpBol: TEditFocus
            Tag = 99
            Left = 191
            Top = 1
            Width = 15
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            TabOrder = 0
            Text = 'N'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttAlfabetico
          end
        end
      end
    end
  end
  object pnlConfirma: TPanel [4]
    Left = 0
    Top = 643
    Width = 769
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      769
      28)
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
      TabOrder = 0
      OnClick = btnConfirmaDadosClick
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 687
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akTop, akRight]
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
      TabOrder = 1
      OnClick = btnCancelaDadosClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 692
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 628
    Top = 64
  end
end
