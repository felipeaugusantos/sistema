inherited frmConfiguracoesLazzumix: TfrmConfiguracoesLazzumix
  Left = 191
  Top = 77
  Width = 710
  Height = 646
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Lazzumix'
  Position = poScreenCenter
  ExplicitWidth = 710
  ExplicitHeight = 646
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 578
    Width = 704
    TabOrder = 3
    ExplicitTop = 578
    ExplicitWidth = 704
    DesignSize = (
      704
      0)
  end
  inherited pnlStatus: TPanel
    Top = 606
    Width = 704
    TabOrder = 4
    ExplicitTop = 606
    ExplicitWidth = 704
    inherited pnlNomeForm: TPanel
      Left = 533
      TabOrder = 1
      ExplicitLeft = 533
    end
    inherited pnlInfo: TPanel
      Width = 533
      TabOrder = 0
      ExplicitWidth = 533
    end
  end
  inherited pgcDados: TPageControl
    Top = 23
    Width = 704
    Height = 555
    TabOrder = 1
    OnChange = pgcDadosChange
    ExplicitTop = 23
    ExplicitWidth = 704
    ExplicitHeight = 555
    inherited tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      OnShow = tbsGeralShow
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 696
      ExplicitHeight = 523
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 696
        Height = 523
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label6: TLabel
          Left = 121
          Top = 36
          Width = 98
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda:'
        end
        object Label18: TLabel
          Left = 48
          Top = 123
          Width = 171
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo (FORMULA.TXT):'
        end
        object Label17: TLabel
          Left = 49
          Top = 102
          Width = 170
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo (PRODUTO.TXT):'
        end
        object Label16: TLabel
          Left = 498
          Top = 80
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator:'
        end
        object Label15: TLabel
          Left = 497
          Top = 58
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator:'
        end
        object ColorLabel2: TColorLabel
          Left = 287
          Top = 80
          Width = 195
          Height = 14
          Caption = '(3) Pre'#231'o de Venda (4) - Pre'#231'o de Custo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object ColorLabel1: TColorLabel
          Left = 287
          Top = 58
          Width = 195
          Height = 14
          Caption = '(1) Pre'#231'o de Venda (2) - Pre'#231'o de Custo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label12: TLabel
          Left = 88
          Top = 80
          Width = 131
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para venda (Diluido):'
        end
        object Label9: TLabel
          Left = 57
          Top = 58
          Width = 162
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para venda (Concentrado):'
        end
        object Label11: TLabel
          Left = 117
          Top = 168
          Width = 102
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sistema Operacional:'
        end
        object ColorLabel3: TColorLabel
          Left = 286
          Top = 168
          Width = 84
          Height = 14
          Caption = '(W)indows (D)os'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label13: TLabel
          Left = 374
          Top = 168
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valores da Formula'#231#227'o:'
        end
        object ColorLabel4: TColorLabel
          Left = 546
          Top = 168
          Width = 144
          Height = 14
          Caption = '(1) Acumulados (2) Absolutos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label20: TLabel
          Left = 163
          Top = 190
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Perc. Frete:'
        end
        object Label21: TLabel
          Left = 306
          Top = 190
          Width = 41
          Height = 14
          Alignment = taRightJustify
          Caption = 'Perc. IPI:'
        end
        object Label22: TLabel
          Left = 427
          Top = 190
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Perc. Retido:'
        end
        object Label23: TLabel
          Left = 139
          Top = 212
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Perc. Adicionais:'
        end
        object Label24: TLabel
          Left = 288
          Top = 212
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Perc. Perda:'
        end
        object Label25: TLabel
          Left = 416
          Top = 212
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem Lucro:'
        end
        object Label26: TLabel
          Left = 30
          Top = 234
          Width = 189
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo sequencial de novas f'#243'rmulas:'
        end
        object Label33: TLabel
          Left = 52
          Top = 253
          Width = 167
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo (Perso210.TXT):'
        end
        object Label34: TLabel
          Left = 53
          Top = 274
          Width = 166
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo (Perso211.TXT):'
        end
        object Label35: TLabel
          Left = 70
          Top = 145
          Width = 149
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo (BASE.TXT):'
        end
        object ColorLabel5: TColorLabel
          Left = 283
          Top = 299
          Width = 49
          Height = 14
          Caption = '(3) ou (4) '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label38: TLabel
          Left = 33
          Top = 296
          Width = 186
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade de Linhas (Perso211.TXT):'
        end
        object Label49: TLabel
          Left = 90
          Top = 320
          Width = 129
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais %'
        end
        object Label50: TLabel
          Left = 2
          Top = 346
          Width = 209
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
        end
        object edtDesLaz: TEditFocus
          Left = 278
          Top = 32
          Width = 308
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
        object edtProLaz: TEditFocus
          Tag = 99
          Left = 221
          Top = 32
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          OnKeyPress = edtProLazKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtLazPfo: TFilenameEditFocus
          Tag = 99
          Left = 221
          Top = 119
          Width = 366
          Height = 22
          Filter = 'Arquivos Texto|*.txt|Todos os arquivos|*.*'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtLazPpr: TFilenameEditFocus
          Tag = 99
          Left = 221
          Top = 98
          Width = 366
          Height = 22
          Filter = 'Arquivos Texto|*.txt|Todos os arquivos|*.*'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtFatDlz: TEditFocus
          Tag = 99
          Left = 528
          Top = 76
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtFatClz: TEditFocus
          Tag = 99
          Left = 528
          Top = 54
          Width = 57
          Height = 22
          Alignment = taLeftJustify
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
        object edtTraDlz: TEditFocus
          Tag = 99
          Left = 221
          Top = 76
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtTraClz: TEditFocus
          Tag = 99
          Left = 221
          Top = 54
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object chkUsaLaz: TCheckBox
          Tag = 99
          Left = 8
          Top = 14
          Width = 175
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtLaz_So: TEditFocus
          Tag = 99
          Left = 221
          Top = 164
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object chkUsaFor: TCheckBox
          Tag = 99
          Left = 205
          Top = 14
          Width = 175
          Height = 18
          Caption = 'Utilizar Formula'#231#227'o'
          TabOrder = 1
        end
        object edtAcuAbs: TEditFocus
          Tag = 99
          Left = 490
          Top = 164
          Width = 55
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtPerFre: TEditFocus
          Tag = 99
          Left = 221
          Top = 186
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
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
        object edtPerIpi: TEditFocus
          Tag = 99
          Left = 349
          Top = 186
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
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
        object edtPerRet: TEditFocus
          Tag = 99
          Left = 490
          Top = 186
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
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
        object edtPerAdc: TEditFocus
          Tag = 99
          Left = 221
          Top = 208
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
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
        object edtPerPer: TEditFocus
          Tag = 99
          Left = 349
          Top = 208
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
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
        object edtMarLuc: TEditFocus
          Tag = 99
          Left = 490
          Top = 208
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
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
        object edtProNfm: TEditFocus
          Tag = 99
          Left = 221
          Top = 230
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtPerso210: TFilenameEditFocus
          Tag = 99
          Left = 221
          Top = 250
          Width = 366
          Height = 22
          Filter = 'Arquivos Texto|*.txt|Todos os arquivos|*.*'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 20
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtPerso211: TFilenameEditFocus
          Tag = 99
          Left = 221
          Top = 271
          Width = 366
          Height = 22
          Filter = 'Arquivos Texto|*.txt|Todos os arquivos|*.*'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 21
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtLazPba: TFilenameEditFocus
          Tag = 99
          Left = 221
          Top = 141
          Width = 366
          Height = 22
          Filter = 'Arquivos Texto|*.txt|Todos os arquivos|*.*'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtLinPer: TEditFocus
          Tag = 99
          Left = 221
          Top = 293
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
        object edtDesOpe: TEditFocus
          Tag = 99
          Left = 221
          Top = 316
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 23
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtApreve: TEditFocus
          Tag = 99
          Left = 220
          Top = 340
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 24
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
    object tbsEmbalagens: TTabSheet
      Caption = '&2 - Embalagens'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 682
      ExplicitHeight = 0
      object pnlEmbalagens: TPanel
        Left = 0
        Top = 0
        Width = 696
        Height = 523
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 682
        object pnlPrecos: TPanel
          Left = 2
          Top = 2
          Width = 692
          Height = 74
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          ExplicitWidth = 678
          object Label10: TLabel
            Left = 190
            Top = 13
            Width = 77
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o de Gal'#227'o:'
          end
          object Label7: TLabel
            Left = 20
            Top = 13
            Width = 103
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o de Embalagem:'
          end
          object Label31: TLabel
            Left = 337
            Top = 13
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o de Copo:'
          end
          object Label32: TLabel
            Left = 477
            Top = 13
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o de Spray:'
          end
          object Label39: TLabel
            Left = 53
            Top = 40
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o de Lata:'
          end
          object edtGalLaz: TEditFocus
            Tag = 99
            Left = 269
            Top = 9
            Width = 56
            Height = 22
            Alignment = taLeftJustify
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
          object edtEmbLaz: TEditFocus
            Tag = 99
            Left = 125
            Top = 9
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
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
          object edtCopLaz: TEditFocus
            Tag = 99
            Left = 413
            Top = 9
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          object edtSprLaz: TEditFocus
            Tag = 99
            Left = 557
            Top = 9
            Width = 56
            Height = 22
            Alignment = taLeftJustify
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
          object edtLatLaz: TEditFocus
            Tag = 99
            Left = 125
            Top = 36
            Width = 56
            Height = 22
            Alignment = taLeftJustify
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
        end
        object pnlProdBaixas: TPanel
          Left = 2
          Top = 434
          Width = 692
          Height = 87
          Align = alBottom
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          ExplicitWidth = 678
          object lblLazSpr: TLabel
            Left = 29
            Top = 37
            Width = 158
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem Spray:'
          end
          object lblLazCop: TLabel
            Left = 33
            Top = 14
            Width = 154
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto baixa embalagem Copo:'
          end
          object edtLazCop: TEditFocus
            Tag = 99
            Left = 189
            Top = 8
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtLazIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtLazSpr: TEditFocus
            Tag = 99
            Left = 189
            Top = 31
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 1
            OnKeyPress = edtLazIglKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesLazCop: TEditFocus
            Left = 245
            Top = 8
            Width = 365
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
          object edtDesLazSpr: TEditFocus
            Left = 245
            Top = 31
            Width = 365
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
        end
        object pgcTiposEmbalagens: TPageControl
          Left = 2
          Top = 76
          Width = 692
          Height = 358
          ActivePage = tbsGalao
          Align = alClient
          Style = tsFlatButtons
          TabOrder = 2
          ExplicitWidth = 678
          object tbsGalao: TTabSheet
            Caption = 'Gal'#227'o'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 670
            ExplicitHeight = 0
            object gpbGalao: TGroupBox
              Left = 3
              Top = 3
              Width = 649
              Height = 212
              Caption = 'Gal'#227'o'
              TabOrder = 0
              object Label4: TLabel
                Left = 32
                Top = 12
                Width = 179
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZURIL:'
              end
              object Label5: TLabel
                Left = 26
                Top = 34
                Width = 185
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZULAC:'
              end
              object Label1: TLabel
                Left = 26
                Top = 56
                Width = 185
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZUDUR:'
              end
              object Label2: TLabel
                Left = 61
                Top = 78
                Width = 150
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem P. U.:'
              end
              object Label27: TLabel
                Left = 38
                Top = 100
                Width = 173
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem Lazzucril:'
              end
              object Label28: TLabel
                Left = 31
                Top = 122
                Width = 180
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem Fleet Color:'
              end
              object lbl1: TLabel
                Left = 35
                Top = 144
                Width = 176
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem UltraBase:'
              end
              object lbl2: TLabel
                Left = 51
                Top = 166
                Width = 160
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem PU MS:'
              end
              object Label37: TLabel
                Left = 4
                Top = 188
                Width = 207
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem SHERTRUCKMIX:'
              end
              object edtDesLazIgl: TEditFocus
                Left = 269
                Top = 8
                Width = 365
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
              object edtLazIgl: TEditFocus
                Tag = 99
                Left = 213
                Top = 8
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 0
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazGla: TEditFocus
                Left = 269
                Top = 30
                Width = 365
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
              object edtLazGla: TEditFocus
                Tag = 99
                Left = 213
                Top = 30
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 2
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazGpo: TEditFocus
                Left = 269
                Top = 52
                Width = 365
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
              object edtLazGpo: TEditFocus
                Tag = 99
                Left = 213
                Top = 52
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 4
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazGpu: TEditFocus
                Left = 269
                Top = 74
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
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
              object edtLazGpu: TEditFocus
                Tag = 99
                Left = 213
                Top = 74
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 6
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazGcr: TEditFocus
                Left = 269
                Top = 96
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
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
              object edtLazGcr: TEditFocus
                Tag = 99
                Left = 213
                Top = 96
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 8
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtLazGfl: TEditFocus
                Tag = 99
                Left = 213
                Top = 118
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 10
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazGfl: TEditFocus
                Left = 269
                Top = 118
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 11
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtUltraBaseGl: TEditFocus
                Tag = 99
                Left = 213
                Top = 140
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 12
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesUltraBaseGl: TEditFocus
                Left = 269
                Top = 140
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 13
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtDesPuMsGl: TEditFocus
                Left = 269
                Top = 162
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 15
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtPuMsGl: TEditFocus
                Tag = 99
                Left = 213
                Top = 162
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 14
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtSherGl: TEditFocus
                Tag = 99
                Left = 213
                Top = 184
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 16
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesSherGl: TEditFocus
                Left = 269
                Top = 184
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 17
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
          object tbsLitro: TTabSheet
            Caption = 'Litro'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 670
            ExplicitHeight = 0
            object gpbLitro: TGroupBox
              Left = 3
              Top = 0
              Width = 649
              Height = 221
              Caption = 'Litro'
              TabOrder = 0
              object Label3: TLabel
                Left = 26
                Top = 42
                Width = 185
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZULAC:'
              end
              object Label14: TLabel
                Left = 26
                Top = 64
                Width = 185
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZUDUR:'
              end
              object Label19: TLabel
                Left = 61
                Top = 86
                Width = 150
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem P. U.:'
              end
              object Label8: TLabel
                Left = 32
                Top = 20
                Width = 179
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZURIL:'
              end
              object Label29: TLabel
                Left = 38
                Top = 108
                Width = 173
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem Lazzucril:'
              end
              object Label30: TLabel
                Left = 31
                Top = 130
                Width = 180
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem Fleet Color:'
              end
              object lbl3: TLabel
                Left = 35
                Top = 152
                Width = 176
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem UltraBase:'
              end
              object lbl4: TLabel
                Left = 51
                Top = 174
                Width = 160
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem PU MS:'
              end
              object Label36: TLabel
                Left = 4
                Top = 196
                Width = 207
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem SHERTRUCKMIX:'
              end
              object edtDesLazIem: TEditFocus
                Left = 270
                Top = 16
                Width = 365
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
              object edtLazIem: TEditFocus
                Tag = 99
                Left = 213
                Top = 16
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 0
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLla: TEditFocus
                Left = 270
                Top = 38
                Width = 365
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
              object edtLazLla: TEditFocus
                Tag = 99
                Left = 213
                Top = 38
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 2
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLpo: TEditFocus
                Left = 270
                Top = 60
                Width = 365
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
              object edtLazLpo: TEditFocus
                Tag = 99
                Left = 213
                Top = 60
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 4
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLpu: TEditFocus
                Left = 270
                Top = 82
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
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
              object edtLazLpu: TEditFocus
                Tag = 99
                Left = 213
                Top = 82
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 6
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLcr: TEditFocus
                Left = 269
                Top = 104
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
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
              object edtLazLcr: TEditFocus
                Tag = 99
                Left = 213
                Top = 104
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 8
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtLazLfl: TEditFocus
                Tag = 99
                Left = 213
                Top = 126
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 10
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLfl: TEditFocus
                Left = 269
                Top = 126
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 11
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtUltraBaseLt: TEditFocus
                Tag = 99
                Left = 213
                Top = 148
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 12
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesUltraBaseLt: TEditFocus
                Left = 269
                Top = 148
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 13
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtPuMsLt: TEditFocus
                Tag = 99
                Left = 213
                Top = 170
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 14
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesPuMsLt: TEditFocus
                Left = 269
                Top = 170
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 15
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtSherLt: TEditFocus
                Tag = 99
                Left = 213
                Top = 192
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 16
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesSherLt: TEditFocus
                Left = 269
                Top = 192
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 17
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
          object tbsLata: TTabSheet
            Caption = 'Lata'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 670
            ExplicitHeight = 0
            object gpbLata: TGroupBox
              Left = 3
              Top = 3
              Width = 649
              Height = 212
              Caption = 'Lata'
              TabOrder = 0
              object Label40: TLabel
                Left = 32
                Top = 12
                Width = 179
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZURIL:'
              end
              object Label41: TLabel
                Left = 26
                Top = 34
                Width = 185
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZULAC:'
              end
              object Label42: TLabel
                Left = 26
                Top = 56
                Width = 185
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem LAZZUDUR:'
              end
              object Label43: TLabel
                Left = 61
                Top = 78
                Width = 150
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem P. U.:'
              end
              object Label44: TLabel
                Left = 38
                Top = 100
                Width = 173
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem Lazzucril:'
              end
              object Label45: TLabel
                Left = 31
                Top = 122
                Width = 180
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem Fleet Color:'
              end
              object Label46: TLabel
                Left = 35
                Top = 144
                Width = 176
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem UltraBase:'
              end
              object Label47: TLabel
                Left = 51
                Top = 166
                Width = 160
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem PU MS:'
              end
              object Label48: TLabel
                Left = 4
                Top = 188
                Width = 207
                Height = 14
                Alignment = taRightJustify
                Caption = 'Produto baixa embalagem SHERTRUCKMIX:'
              end
              object edtDesLazIla: TEditFocus
                Left = 269
                Top = 8
                Width = 365
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
              object edtLazIla: TEditFocus
                Tag = 99
                Left = 213
                Top = 8
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 0
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLaz: TEditFocus
                Left = 269
                Top = 30
                Width = 365
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
              object edtLazLaz: TEditFocus
                Tag = 99
                Left = 213
                Top = 30
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 2
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLdu: TEditFocus
                Left = 269
                Top = 52
                Width = 365
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
              object edtLazLdu: TEditFocus
                Tag = 99
                Left = 213
                Top = 52
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 4
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLap: TEditFocus
                Left = 269
                Top = 74
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
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
              object edtLazLap: TEditFocus
                Tag = 99
                Left = 213
                Top = 74
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 6
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLil: TEditFocus
                Left = 269
                Top = 96
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
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
              object edtLazLil: TEditFocus
                Tag = 99
                Left = 213
                Top = 96
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 8
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtLazLco: TEditFocus
                Tag = 99
                Left = 213
                Top = 118
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 10
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesLazLco: TEditFocus
                Left = 269
                Top = 118
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 11
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtUltraBaseLa: TEditFocus
                Tag = 99
                Left = 213
                Top = 140
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 12
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesUltraBaseLa: TEditFocus
                Left = 269
                Top = 140
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 13
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtDesPuMsLa: TEditFocus
                Left = 269
                Top = 162
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 15
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object edtPuMsLa: TEditFocus
                Tag = 99
                Left = 213
                Top = 162
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 14
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtSherLa: TEditFocus
                Tag = 99
                Left = 213
                Top = 184
                Width = 56
                Height = 22
                Alignment = taLeftJustify
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 16
                OnKeyPress = edtLazIglKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = True
                TamCampo = 5
                TipoTexto = ttNumerico
              end
              object edtDesSherLa: TEditFocus
                Left = 269
                Top = 184
                Width = 365
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Color = 16768952
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ReadOnly = True
                TabOrder = 17
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
        end
      end
    end
    object tbsConfCampos: TTabSheet
      Caption = '&3 - Consulta'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 682
      ExplicitHeight = 0
    end
  end
  object pnlBotoesConf: TPanel [3]
    Left = 0
    Top = 578
    Width = 704
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      704
      28)
    object btnSairConf: TBitBtnLocked
      Left = 622
      Top = 4
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
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
      TabOrder = 1
      OnClick = btnSairConfClick
    end
    object btnGravarConf: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 77
      Height = 22
      Caption = 'Gra&var'
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
      OnClick = btnGravarConfClick
    end
    object btnRestaurar: TBitBtnLocked
      Left = 81
      Top = 4
      Width = 77
      Height = 22
      Caption = 'Restaurar'
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
      TabOrder = 2
      Visible = False
      OnClick = btnRestaurarClick
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 704
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Lazzumix'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 644
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 612
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 24
  end
end
