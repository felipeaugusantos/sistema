inherited frmCadCupomPromProd: TfrmCadCupomPromProd
  Width = 807
  Height = 636
  Caption = 'Cupom de promo'#231#227'o para produtos'
  ExplicitWidth = 807
  ExplicitHeight = 636
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 563
    Width = 801
    ExplicitTop = 563
    ExplicitWidth = 801
    inherited FlwBotoes: TFlowPanel
      Width = 797
      ExplicitTop = 2
      ExplicitWidth = 797
      object btnAltDataFin: TBitBtnLocked
        Left = 432
        Top = 0
        Width = 100
        Height = 20
        Caption = 'Alterar &Data'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000002000000090000
          000E0000000F0000000F000000100000000F0000000A00000002000000000000
          0000000000000000000000000000000000000000000000000008173E72C01C4A
          99FF1C4A98FF1B4997FF1B4897FF1B4896FF15366FC100000009000000000000
          000000000000000000000000000000000000000000000000000B2A66ADFF87CE
          F2FF63BBEDFF63BBEDFF62BBEEFF81CAF2FF2761A9FF0000000D000000090000
          000E00000010000000100000001000000010000000100000001A2C6BB0FF8FD2
          F3FF67BEEEFF67BDEEFF66BDEEFF89CFF2FF2A66ACFF0000000D855F52C1B984
          72FFB98472FFB98371FFB88271FFB88270FFB88270FFD3B8B1FF2E6FB3FFACDF
          F7FF93D4F4FF97D6F5FF92D4F4FFA7DDF7FF2B6AAFFF0000000CBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF4EFEDFF3073B5FFDCF3
          FCFFDCF2FCFFDBF3FCFFDBF2FCFFDAF2FCFF2D6EB2FF0000000AC08E7DFFFCFA
          F9FFC19C8DFFEDDFD9FFC0998BFFEDDFD8FFBF9788FFF0E9E4FF6298C3FF3C8B
          C7FF3C8AC6FF3B89C6FF3B88C5FF3A87C4FF2B6391C300000006C39482FFFCFA
          FAFFEEE2DCFFEEE1DBFFEEE1DBFFEEE0DBFFEEE0DBFFEFE3DEFFF1E8E4FFEFE8
          E6FFEFE8E6FFF4F1EFFFD9C1B8FF000000170000000600000002C79887FFFDFB
          FAFFC5A192FFEEE2DEFFC49F90FFEEE2DCFFC29D8EFFEEE1DBFFC19B8BFFEEE1
          DBFFC09889FFFAF4F1FFC49482FF0000000E0000000000000000C99D8CFFFDFC
          FCFFEFE4DFFFEFE3DFFFEFE3DFFFEEE3DEFFEFE2DEFFEEE2DDFFEEE2DDFFEEE2
          DCFFEEE2DCFFFAF6F3FFC79987FF0000000D0000000000000000CDA190FFFEFC
          FCFFC9A597FFEFE4E0FFC7A495FFEFE4E0FFC6A293FFEFE3DFFFC49F91FFEFE3
          DFFFC39D8FFFFBF7F6FFCA9E8CFF0000000C0000000000000000CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCFAF8FFCDA291FF0000000C00000000000000004B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF6270DDFF3538ABFF0000000B00000000000000004C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF6775DFFF363AACFF0000000A00000000000000004D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF373BADFF0000000900000000000000003A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF2A2C81C2000000060000000000000000}
        TabOrder = 6
        OnClick = btnAltDataFinClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 720
      ExplicitLeft = 720
    end
  end
  inherited pnlStatus: TPanel
    Top = 591
    Width = 801
    ExplicitTop = 591
    ExplicitWidth = 801
    inherited pnlNomeForm: TPanel
      Left = 454
      ExplicitLeft = 454
    end
    inherited pnlInfo: TPanel
      Width = 454
      ExplicitWidth = 454
      object btnShowTrace: TSpeedButton
        Left = 452
        Top = 0
        Width = 23
        Height = 22
      end
      object btnHideTrace: TSpeedButton
        Left = 452
        Top = 0
        Width = 23
        Height = 22
      end
    end
  end
  inherited pgcDados: TPageControl
    Width = 801
    Height = 563
    ExplicitWidth = 801
    ExplicitHeight = 563
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 793
      ExplicitHeight = 531
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 793
        Height = 531
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 38
          Top = 8
          Width = 39
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 31
          Top = 80
          Width = 46
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Validade:'
        end
        object Label3: TLabel
          Left = 166
          Top = 80
          Width = 6
          Height = 14
          Alignment = taRightJustify
          Caption = 'a'
        end
        object clb3: TColorLabel
          Left = 106
          Top = 104
          Width = 246
          Height = 14
          Caption = '(F) Pessoa F'#237'sica   (J) Pessoa Jur'#237'dica   (A) Ambos'
          CorDestaque = clRed
        end
        object lbl24: TLabel
          Left = 4
          Top = 104
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Cliente:'
        end
        object Label14: TLabel
          Left = 4
          Top = 31
          Width = 73
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Descri'#231#227'o:'
        end
        object lblLayout: TLabel
          Left = 524
          Top = 8
          Width = 39
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Layout:'
        end
        object pnlEmpresa: TPanel
          Left = 1
          Top = 248
          Width = 791
          Height = 282
          Align = alBottom
          Alignment = taRightJustify
          ParentColor = True
          TabOrder = 15
          object Label16: TLabel
            Left = 1
            Top = 1
            Width = 789
            Height = 14
            Align = alTop
            Alignment = taCenter
            Caption = 'Empresas'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 56
          end
          object clbEmpresa: TCheckListBox
            Left = 1
            Top = 15
            Width = 789
            Height = 266
            Align = alClient
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
          end
        end
        object dbeCodPro: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 5
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'CPP_CODCPP'
          DataSource = dtsPromo
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDesPro: TDBEditFocus
          Tag = 99
          Left = 151
          Top = 5
          Width = 367
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CPP_DESCPP'
          DataSource = dtsPromo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 80
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaFin: TDBEditFocus
          Tag = 99
          Left = 189
          Top = 77
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CPP_DTAFIN'
          DataSource = dtsPromo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDtaIni: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 77
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CPP_DTAINI'
          DataSource = dtsPromo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object rdgTipPro: TRadioGroup
          Left = 4
          Top = 126
          Width = 726
          Height = 118
          Caption = 'Tipo de Promo'#231#227'o'
          Enabled = False
          ItemIndex = 0
          Items.Strings = (
            
              'Imprimir 1 cupom a cada                          em compras dos ' +
              'produtos relacionados nesta promo'#231#227'o.'
            
              'A partir de                           em compras dos produtos re' +
              'lacionados nesta promo'#231#227'o, imprimir quantidade fixa de          ' +
              '                 cupons.')
          TabOrder = 10
          OnClick = rdgTipProClick
        end
        object dbeVLCPP1: TDBEditFocus
          Tag = 99
          Left = 148
          Top = 155
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CPP_VLCPP1'
          DataSource = dtsPromo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeVLCPP2: TDBEditFocus
          Tag = 99
          Left = 84
          Top = 204
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CPP_VLCPP2'
          DataSource = dtsPromo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeNumCup: TDBEditFocus
          Tag = 99
          Left = 570
          Top = 204
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CPP_NUMCUP'
          DataSource = dtsPromo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDescri: TDBMemo
          Tag = 99
          Left = 80
          Top = 28
          Width = 438
          Height = 48
          DataField = 'CPP_DESCRI'
          DataSource = dtsPromo
          TabOrder = 4
        end
        object dbeTipCli: TDBEditFocus
          Tag = 99
          Left = 80
          Top = 100
          Width = 20
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CPP_TIPCLI'
          DataSource = dtsPromo
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object chkCpcLcs: TDBCheckBox
          Tag = 99
          Left = 407
          Top = 104
          Width = 233
          Height = 16
          Caption = 'N'#227'o gerar cupom para cliente consumidor'
          DataField = 'CPP_CPCLCS'
          DataSource = dtsPromo
          TabOrder = 9
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object chkAcmVal: TDBCheckBox
          Tag = 99
          Left = 31
          Top = 182
          Width = 282
          Height = 16
          Caption = 'Acumular valor n'#227'o utilizado para pr'#243'xima compra'
          DataField = 'CPP_ACMVAL'
          DataSource = dtsPromo
          TabOrder = 12
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object edtCodLay: TDBEditFocus
          Tag = 99
          Left = 565
          Top = 5
          Width = 48
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CPP_CODLAY'
          DataSource = dtsPromo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 2
          OnKeyPress = edtCodLayKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object edtDesLay: TEditFocus
          Left = 614
          Top = 5
          Width = 171
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object chkImpCup: TDBCheckBox
          Tag = 99
          Left = 407
          Top = 82
          Width = 233
          Height = 16
          Caption = 'Imprimir Cupom no Faturamento'
          DataField = 'CPP_IMPCUP'
          DataSource = dtsPromo
          TabOrder = 7
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
    object tbsItens: TTabSheet
      Caption = '&2 - Itens da Promo'#231#227'o'
      ImageIndex = 1
      object pnlItens: TPanel
        Left = 0
        Top = 0
        Width = 793
        Height = 531
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label9: TLabel
          Left = 16
          Top = 25
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 51
          Top = 48
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDescricao: TLabel
          Left = 3
          Top = 71
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o Inicial:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 28
          Top = 94
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 360
          Top = 71
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o Final:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 352
          Top = 25
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
        end
        object Label10: TLabel
          Left = 379
          Top = 48
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 359
          Top = 94
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo Unidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object mskLinhaGrupo: TMaskEditFocus
          Tag = 99
          Left = 86
          Top = 21
          Width = 70
          Height = 22
          EditMask = '999.999;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentFont = False
          TabOrder = 1
          Text = ''
          OnExit = mskLinhaGrupoExit
          OnKeyPress = mskLinhaGrupoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGrupo: TEditFocus
          Left = 157
          Top = 21
          Width = 194
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtMarca: TEditFocus
          Tag = 99
          Left = 86
          Top = 44
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          ParentFont = False
          TabOrder = 5
          OnExit = edtMarcaExit
          OnKeyPress = edtMarcaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMarca: TEditFocus
          Left = 157
          Top = 44
          Width = 194
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescriIni: TEditFocus
          Tag = 99
          Left = 86
          Top = 67
          Width = 265
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
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRefere: TEditFocus
          Tag = 99
          Left = 86
          Top = 90
          Width = 265
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
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesIte: TEditFocus
          Left = 511
          Top = 21
          Width = 220
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtFornecedor: TEditFocus
          Tag = 99
          Left = 440
          Top = 44
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 7
          OnExit = edtFornecedorExit
          OnKeyPress = edtFornecedorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDescriFin: TEditFocus
          Tag = 99
          Left = 440
          Top = 67
          Width = 291
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
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesFornecedor: TEditFocus
          Left = 511
          Top = 44
          Width = 220
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtUnidade: TEditFocus
          Tag = 99
          Left = 440
          Top = 90
          Width = 36
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
          MaxLength = 2
          ParentFont = False
          TabOrder = 12
          OnKeyPress = edtUnidadeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 440
          Top = 21
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          TabOrder = 3
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object btnConfirmar: TBitBtnLocked
          Left = 480
          Top = 90
          Width = 113
          Height = 23
          Caption = 'C&onfirma'
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
          TabOrder = 13
          OnClick = btnConfirmarClick
        end
        object DBGridCitel1: TDBGridCitel
          Left = 1
          Top = 152
          Width = 791
          Height = 378
          Align = alBottom
          DataSource = dtsItens
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 14
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnKeyDown = DBGridCitel1KeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'CODITE'
              Title.Caption = 'C'#243'digo'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESITE'
              Title.Caption = 'Produto'
              Width = 600
              Visible = True
            end>
        end
        object btnLimparGrid: TBitBtnLocked
          Left = 599
          Top = 90
          Width = 113
          Height = 23
          Caption = '&Limpar Itens'
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
          TabOrder = 15
          OnClick = btnLimparGridClick
        end
        object ckbTodosItens: TDBCheckBox
          Left = 86
          Top = 4
          Width = 123
          Height = 17
          Caption = 'Todos os Produtos'
          DataField = 'CPP_ALLITE'
          DataSource = dtsPromo
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
    object tabVendedores: TTabSheet
      Caption = '&3 - Vendedores'
      ImageIndex = 2
      object pnlVendedores: TPanel
        Left = 0
        Top = 0
        Width = 793
        Height = 531
        Align = alClient
        TabOrder = 0
        object Label5: TLabel
          Left = 29
          Top = 13
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendedor:'
        end
        object Label6: TLabel
          Left = 10
          Top = 36
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento:'
        end
        object Label24: TLabel
          Left = 8
          Top = 60
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo Operador:'
        end
        object Label7: TLabel
          Left = 8
          Top = 87
          Width = 176
          Height = 14
          Caption = 'Vendedores que n'#227'o geram cupons:'
        end
        object edtCodOpe: TEditFocus
          Tag = 99
          Left = 86
          Top = 9
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 0
          OnExit = edtCodOpeExit
          OnKeyPress = edtCodOpeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomOpe: TEditFocus
          Left = 152
          Top = 9
          Width = 433
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
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
        object edtCodDep: TEditFocus
          Tag = 99
          Left = 86
          Top = 32
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
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
          Left = 152
          Top = 32
          Width = 433
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object btnConfirmarVendedor: TBitBtnLocked
          Left = 317
          Top = 54
          Width = 113
          Height = 23
          Caption = 'C&onfirma'
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
          TabOrder = 5
          OnClick = btnConfirmarVendedorClick
        end
        object btnLimparGridVendedores: TBitBtnLocked
          Left = 436
          Top = 54
          Width = 149
          Height = 23
          Caption = '&Limpar Vendedores'
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
          TabOrder = 6
          OnClick = btnLimparGridVendedoresClick
        end
        object DBGridCitelVendedores: TDBGridCitel
          Left = 1
          Top = 104
          Width = 791
          Height = 426
          Align = alBottom
          DataSource = dtsVendedores
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 7
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnKeyDown = DBGridCitelVendedoresKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'OPE_CODOPE'
              Title.Caption = 'C'#243'digo'
              Width = 72
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'OPE_NOMOPE'
              Title.Caption = 'Vendedor'
              Width = 387
              Visible = True
            end>
        end
        object cbxTipoOperadores: TComboBoxFocus
          Left = 86
          Top = 55
          Width = 163
          Height = 22
          Style = csDropDownList
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
    end
    object tabSorteados: TTabSheet
      Caption = '&4 - Sorteados'
      ImageIndex = 3
      object pnlSorteados: TPanel
        Left = 0
        Top = 0
        Width = 793
        Height = 531
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblCupom: TLabel
          Left = 7
          Top = 13
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cupom:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDtaSorteio: TLabel
          Left = 256
          Top = 13
          Width = 62
          Height = 14
          Caption = 'Data Sorteio:'
        end
        object edtCupom: TEditFocus
          Tag = 99
          Left = 49
          Top = 10
          Width = 192
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object mskDtaIni: TcxDateEdit
          Tag = 99
          Left = 324
          Top = 9
          Properties.ButtonGlyph.SourceDPI = 96
          Properties.ButtonGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000000000020000000A0000
            0010000000110000001100000011000000120000001200000012000000120000
            00120000001300000013000000120000000C000000030000000A81594CC2B47C
            69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
            67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
            F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
            E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
            F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
            83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
            F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
            D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
            F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
            86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
            FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
            D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
            FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
            8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
            FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
            DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
            FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
            91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
            FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
            F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
            ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
            DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
            EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
            DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
            EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
            E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
            C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
            B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
            0006000000060000000600000007000000070000000700000007000000070000
            00070000000800000008000000070000000500000001}
          Properties.ClearKey = 46
          Properties.DateButtons = []
          Properties.MinDate = 2.000000000000000000
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          Width = 106
        end
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 791
          Height = 529
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 2
          object Label15: TLabel
            Left = 7
            Top = 13
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cupom:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbldataSorteio: TLabel
            Left = 256
            Top = 13
            Width = 62
            Height = 14
            Caption = 'Data Sorteio:'
          end
          object edtCupSorteio: TEditFocus
            Tag = 99
            Left = 49
            Top = 11
            Width = 192
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
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object dtaDataSorteio: TcxDateEdit
            Tag = 99
            Left = 324
            Top = 9
            Properties.ButtonGlyph.SourceDPI = 96
            Properties.ButtonGlyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E00000000000000000000000000020000000A0000
              0010000000110000001100000011000000120000001200000012000000120000
              00120000001300000013000000120000000C000000030000000A81594CC2B47C
              69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
              67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
              F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
              E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
              F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
              83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
              F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
              D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
              F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
              86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
              FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
              D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
              FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
              8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
              FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
              DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
              FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
              91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
              FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
              F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
              ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
              DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
              EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
              DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
              EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
              E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
              C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
              B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
              0006000000060000000600000007000000070000000700000007000000070000
              00070000000800000008000000070000000500000001}
            Properties.ClearKey = 46
            Properties.DateButtons = []
            Properties.MinDate = 2.000000000000000000
            Properties.ValidateOnEnter = False
            Properties.ValidationOptions = []
            StyleFocused.Color = clInfoBk
            TabOrder = 1
            Width = 106
          end
          object btnSorteio: TBitBtnLocked
            Left = 436
            Top = 10
            Width = 113
            Height = 23
            Caption = 'C&onfirma'
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
            TabOrder = 2
            OnClick = btnSorteioClick
          end
          object grdSorteio: TDBGridCitel
            Left = 1
            Top = 39
            Width = 789
            Height = 489
            Align = alBottom
            DataSource = dtsSorteio
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 3
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnKeyDown = grdSorteioKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'NUMCUP'
                Title.Caption = 'Cupom Sorteado'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DTASOR'
                Title.Caption = 'Data Sorteio'
                Width = 68
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DOCUME'
                Title.Caption = 'Documento'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CLIENT'
                Title.Caption = 'Cliente'
                Width = 375
                Visible = True
              end>
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 424
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 752
    Top = 456
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 752
    Top = 488
  end
  object dtsPromo: TDataSource
    OnStateChange = dtsPromoStateChange
    Left = 748
    Top = 371
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 748
    Top = 36
    object cdsItensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 80
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 748
    Top = 84
  end
  object cdsVendedores: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 750
    Top = 233
    object cdsVendedoresOPE_CODOPE: TStringField
      FieldName = 'OPE_CODOPE'
      Size = 3
    end
    object cdsVendedoresOPE_NOMOPE: TStringField
      FieldName = 'OPE_NOMOPE'
      Size = 50
    end
  end
  object dtsVendedores: TDataSource
    DataSet = cdsVendedores
    Left = 752
    Top = 288
  end
  object cdsSorteio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 621
    Top = 93
    object cdsSorteioAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsSorteioSEQPRO: TStringField
      FieldName = 'SEQPRO'
    end
    object cdsSorteioCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsSorteioCODOPE: TStringField
      FieldName = 'CODOPE'
      Size = 3
    end
    object cdsSorteioDTAENT: TDateField
      FieldName = 'DTAENT'
    end
    object cdsSorteioNUMCUP: TStringField
      FieldName = 'NUMCUP'
      Size = 30
    end
    object cdsSorteioDTASOR: TDateField
      FieldName = 'DTASOR'
    end
    object cdsSorteioNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsSorteioESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsSorteioEMPDOC: TStringField
      FieldName = 'EMPDOC'
      Size = 3
    end
    object cdsSorteioCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsSorteioDOCUME: TStringField
      FieldName = 'DOCUME'
      Size = 19
    end
    object cdsSorteioCLIENT: TStringField
      FieldName = 'CLIENT'
      Size = 69
    end
  end
  object dtsSorteio: TDataSource
    DataSet = cdsSorteio
    Left = 621
    Top = 149
  end
end
