inherited frmDigCodBarLocFis: TfrmDigCodBarLocFis
  Left = 214
  Top = 276
  Width = 800
  Height = 637
  BorderStyle = bsSizeable
  Caption = 'Digita'#231#227'o C'#243'digo de Barras e Localiza'#231#227'o F'#237'sica de Produtos'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 637
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 548
    Width = 784
    Height = 34
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 16770261
    TabOrder = 2
    ExplicitTop = 548
    ExplicitWidth = 784
    ExplicitHeight = 34
    DesignSize = (
      784
      34)
    inherited FlwBotoes: TFlowPanel
      Width = 780
      Height = 30
      TabOrder = 3
      ExplicitWidth = 780
      ExplicitHeight = 30
    end
    inherited btnSair: TBitBtnLocked
      Left = 668
      Top = 5
      Width = 111
      Height = 25
      Caption = '(ESC) &Sair'
      Glyph.Data = {00000000}
      ExplicitLeft = 668
      ExplicitTop = 5
      ExplicitWidth = 111
      ExplicitHeight = 25
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 5
      Width = 111
      Height = 25
      Caption = '[ F10 ] Confirma'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnTransCod: TBitBtnLocked
      Left = 269
      Top = 5
      Width = 338
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '[ F5 ] Retorna o c'#243'digo de barras principal para a confer'#234'ncia'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0001000000050000000500000002000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        0009301E136729170D6700000009000000010000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000040C08
        052B936241F2804F31F20B06042C000000040000000000000000000000000000
        00000000000000000000000000000000000000000000000000010000000E6542
        2ABACFA87DFFC69B6DFF573320BB0000000F0000000100000000000000000000
        000000000000000000000000000000000000000000010000000733211669B589
        63FFE8C691FFE8C48EFFA57651FF2C1A106B0000000800000001000000000000
        000000000000000000000000000000000000000000030D0906269B6A4BF2E7CB
        9FFFEACB98FFE9C792FFE1BE8BFF895939F20B07042900000004000000000000
        000000000000000000000000000000000000000000086B4932B7D9BE9FFFF5E5
        C9FFF2DCB8FFECCF9FFFEFD6ABFFD2B392FF5E3B25B90000000A000000000000
        00000000000000000000000000000000000000000009B68B67FFB38863FFA16E
        4AFFF2DDB8FFEED5A8FF9F6A47FFA77753FFA57551FF0000000B000000000000
        000000000000000000000000000000000000000000020000000A06040320AB7D
        5AFFF1DDB6FFEAD0A7FFA2724EFA000000170000000B00000003000000000000
        00010000000400000007000000050000000200000002000000073F2A1B77BF9A
        78FFF1DCB4FFDEC29CFF936849E00000000A0000000000000000000000010000
        00064B312089AB7D59FA3D25157F100906290F0905273B251878A07555F9DABE
        9AFFF1DFB8FFCDAC88FF5C422F93000000060000000000000000000000034D34
        2288B89273FFE3CCA8FFB38C68FF946342FF936241FFB28A68FFD8BC96FFF3E1
        BBFFE0C8A6FFB28967F5130E0A2600000002000000000000000000000004B589
        65FCE4CFB4FFF7ECD2FFF6E8CAFFF4E5C1FFF3E4BEFFF3E4C0FFF5E7C7FFE2CC
        ADFFC59E7BFF4030226400000004000000000000000000000000000000013529
        1E4DBA9572F3D7BB9BFFE7D4BAFFF3E7D0FFF3E7D0FFE7D4B9FFD5B898FFB892
        6EF53F3022600000000400000001000000000000000000000000000000000000
        00010E0B08165F493583947254C9BD916AFCBE926AFF957253CC624B368A0F0C
        091B000000030000000000000000000000000000000000000000000000000000
        0000000000000000000100000002000000030000000400000003000000020000
        0001000000000000000000000000000000000000000000000000}
      TabOrder = 2
      Visible = False
      OnClick = btnTransCodClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 582
    Width = 784
    ExplicitTop = 582
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 153
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 14
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label5: TLabel
      Left = 40
      Top = 60
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label7: TLabel
      Left = 36
      Top = 83
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label9: TLabel
      Left = 441
      Top = 83
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label11: TLabel
      Left = 59
      Top = 106
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label2: TLabel
      Left = 33
      Top = 129
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 24
      Top = 37
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object lblCodOpe: TLabel
      Left = 525
      Top = 130
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
      Visible = False
    end
    object lblSitPro: TLabel
      Left = 532
      Top = 8
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
      Visible = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 94
      Top = 9
      Width = 100
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 15
      TabOrder = 0
      OnEnter = edtCodIteEnter
      OnExit = edtCodIteExit
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
      Top = 33
      Width = 428
      Height = 22
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
    object edtDesIte: TEditFocus
      Left = 93
      Top = 56
      Width = 428
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtRefere: TEditFocus
      Left = 93
      Top = 79
      Width = 340
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtDesUni: TEditFocus
      Left = 485
      Top = 79
      Width = 36
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtDesMar: TEditFocus
      Left = 93
      Top = 102
      Width = 428
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNomFor: TEditFocus
      Left = 93
      Top = 125
      Width = 428
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 576
      Top = 125
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      Visible = False
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 619
      Top = 125
      Width = 160
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSitPro: TEditFocus
      Left = 579
      Top = 5
      Width = 200
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 9
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pagCadastros: TPageControl [3]
    Left = 0
    Top = 153
    Width = 784
    Height = 395
    ActivePage = tbsLocFis
    Align = alClient
    TabOrder = 3
    object tbsLocFis: TTabSheet
      Caption = '&1- Localiza'#231#227'o F'#237'sica'
      object pnlLocalizacao: TPanel
        Left = 0
        Top = 0
        Width = 776
        Height = 366
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 776
          Height = 88
          Align = alTop
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label6: TLabel
            Left = 49
            Top = 22
            Width = 79
            Height = 18
            Alignment = taRightJustify
            Caption = 'Loc. F'#237'sica:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label12: TLabel
            Left = 7
            Top = 56
            Width = 121
            Height = 18
            Alignment = taRightJustify
            Caption = 'Capacidade Loc.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbl1: TLabel
            Left = 322
            Top = 22
            Width = 112
            Height = 18
            Alignment = taRightJustify
            Caption = 'Loc. Super Est.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblLocSep: TLabel
            Left = 321
            Top = 56
            Width = 113
            Height = 18
            Alignment = taRightJustify
            Caption = 'Loc. Separa'#231#227'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object shpTamLcf: TShape
            Left = 133
            Top = 48
            Width = 7
            Height = 29
          end
          object shpLocFis: TShape
            Left = 133
            Top = 16
            Width = 7
            Height = 29
          end
          object shpSupEst: TShape
            Left = 438
            Top = 16
            Width = 7
            Height = 29
          end
          object shpLocSep: TShape
            Left = 438
            Top = 48
            Width = 7
            Height = 29
          end
          object edtLocFis: TEditFocus
            Tag = 99
            Left = 141
            Top = 16
            Width = 174
            Height = 30
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            MaxLength = 30
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
          object edtSupEst: TEditFocus
            Tag = 99
            Left = 446
            Top = 16
            Width = 174
            Height = 30
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            MaxLength = 10
            ParentFont = False
            TabOrder = 1
            OnKeyPress = edtSupEstKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtTamLcf: TEditFocus
            Tag = 99
            Left = 141
            Top = 48
            Width = 174
            Height = 30
            Alignment = taLeftJustify
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            MaxLength = 30
            ParentFont = False
            TabOrder = 2
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
            Left = 446
            Top = 48
            Width = 50
            Height = 30
            Alignment = taLeftJustify
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            MaxLength = 3
            ParentFont = False
            TabOrder = 3
            OnKeyPress = edtCodLseKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttAlfanumerico
          end
          object edtDesLse: TEditFocus
            Left = 497
            Top = 48
            Width = 123
            Height = 30
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -19
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
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
        end
        object pnlLocFis: TPanel
          Left = 0
          Top = 88
          Width = 776
          Height = 278
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
    end
    object tbsEmbalagens: TTabSheet
      Caption = '&2- Embalagens'
      ImageIndex = 1
      object pnlEmbalagens: TPanel
        Left = 0
        Top = 0
        Width = 776
        Height = 366
        Align = alClient
        ParentColor = True
        TabOrder = 0
      end
    end
    object tbsEstoque: TTabSheet
      Caption = '&3 - Estoque M'#225'ximo/M'#237'nimo'
      ImageIndex = 2
      object pnlEstoque: TPanel
        Left = 0
        Top = 0
        Width = 776
        Height = 366
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl30: TLabel
          Left = 19
          Top = 67
          Width = 114
          Height = 18
          Caption = 'Estoque M'#237'nimo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl31: TLabel
          Left = 19
          Top = 120
          Width = 117
          Height = 18
          Caption = 'Estoque M'#225'ximo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label67: TLabel
          Left = 19
          Top = 14
          Width = 36
          Height = 18
          Caption = 'Ativo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ColorLabel4: TColorLabel
          Left = 55
          Top = 33
          Width = 105
          Height = 22
          Caption = '(S)im (N)'#227'o '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          CorDestaque = clRed
        end
        object shpIteAti: TShape
          Left = 19
          Top = 33
          Width = 7
          Height = 30
        end
        object shpEstMin: TShape
          Left = 19
          Top = 87
          Width = 7
          Height = 30
        end
        object shpEstMax: TShape
          Left = 19
          Top = 140
          Width = 7
          Height = 30
        end
        object edtEstMin: TEditFocus
          Tag = 99
          Left = 29
          Top = 87
          Width = 145
          Height = 30
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.000'
        end
        object edtEstMax: TEditFocus
          Tag = 99
          Left = 29
          Top = 140
          Width = 145
          Height = 30
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.000'
        end
        object edtIteAti: TEditFocus
          Tag = 99
          Left = 29
          Top = 33
          Width = 20
          Height = 30
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          Text = 'S'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
      end
    end
    object tbsPontoExposicao: TTabSheet
      Caption = '&4 - Ponto de Exposi'#231#227'o'
      ImageIndex = 3
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 776
        Height = 366
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label4: TLabel
          Left = 19
          Top = 7
          Width = 141
          Height = 18
          Caption = 'Ponto de Exposi'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object shpPonExp: TShape
          Left = 19
          Top = 27
          Width = 7
          Height = 30
        end
        object edtPonExp: TEditFocus
          Tag = 99
          Left = 29
          Top = 27
          Width = 145
          Height = 30
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          Text = '0,00'
          OnExit = edtPonExpExit
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 40
  end
end
