inherited frmConfiguracoesDupont: TfrmConfiguracoesDupont
  Left = 141
  Top = 184
  Width = 754
  Height = 605
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Dupont'
  Position = poMainFormCenter
  ExplicitWidth = 754
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 537
    Width = 748
    ExplicitTop = 537
    ExplicitWidth = 748
    DesignSize = (
      748
      0)
  end
  inherited pnlStatus: TPanel
    Top = 565
    Width = 748
    ExplicitTop = 565
    ExplicitWidth = 748
    inherited pnlNomeForm: TPanel
      Left = 577
      ExplicitLeft = 577
    end
    inherited pnlInfo: TPanel
      Width = 577
      ExplicitWidth = 577
    end
  end
  inherited pgcDados: TPageControl
    Top = 23
    Width = 748
    Height = 514
    OnChange = pgcDadosChange
    ExplicitTop = 23
    ExplicitWidth = 748
    ExplicitHeight = 514
    inherited tbsGeral: TTabSheet
      Caption = '&1 - Geral'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 740
      ExplicitHeight = 482
      object pnlCentral: TPanel
        Left = 0
        Top = 0
        Width = 740
        Height = 482
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 33
          Top = 83
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object Label3: TLabel
          Left = 283
          Top = 83
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator'
        end
        object Label5: TLabel
          Left = 61
          Top = 150
          Width = 148
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivo de f'#243'rmulas:'
        end
        object Label20: TLabel
          Left = 165
          Top = 83
          Width = 45
          Height = 14
          Caption = 'DUP_PRE'
        end
        object Label1: TLabel
          Left = 79
          Top = 104
          Width = 130
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator para pre'#231'o de Custo:'
        end
        object Label4: TLabel
          Left = 64
          Top = 127
          Width = 145
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo c'#243'digo Nova F'#243'rmula:'
        end
        object Label13: TLabel
          Left = 95
          Top = 174
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valores da Formula'#231#227'o:'
        end
        object ColorLabel4: TColorLabel
          Left = 276
          Top = 174
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
        object lblDtaAtu: TLabel
          Left = 78
          Top = 197
          Width = 130
          Height = 14
          Caption = 'Data da '#218'ltima Atualiza'#231#227'o:'
        end
        object lblVersao: TLabel
          Left = 312
          Top = 197
          Width = 38
          Height = 14
          Caption = 'Vers'#227'o:'
        end
        object lblVendaChroma: TLabel
          Left = 63
          Top = 224
          Width = 146
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda (Chroma):'
        end
        object lblVendaDuxone: TLabel
          Left = 63
          Top = 252
          Width = 146
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda (Duxone):'
        end
        object lblVendaIron: TLabel
          Left = 74
          Top = 280
          Width = 135
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda (Imron):'
        end
        object lblVendaNason: TLabel
          Left = 69
          Top = 308
          Width = 140
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda (Nason):'
        end
        object lblCormax: TLabel
          Left = 63
          Top = 336
          Width = 146
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto para venda (Cormax):'
        end
        object Label32: TLabel
          Left = 6
          Top = 357
          Width = 203
          Height = 28
          Alignment = taRightJustify
          Caption = 
            'Quantidade de casas decimais que ser'#227'o '#13#10'exibidas nas quantidade' +
            's da formula'#231#227'o:'
        end
        object ColorLabel1: TColorLabel
          Left = 276
          Top = 366
          Width = 69
          Height = 14
          Caption = '(1) , (2) ou (3)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'bitstream vera sans'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label33: TLabel
          Left = 80
          Top = 392
          Width = 129
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais %'
        end
        object Label38: TLabel
          Left = 1
          Top = 415
          Width = 209
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
        end
        object chkUsaDup: TCheckBox
          Tag = 99
          Left = 16
          Top = 30
          Width = 175
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object edtTraDup: TEditFocus
          Tag = 99
          Left = 215
          Top = 79
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtFatDup: TEditFocus
          Tag = 99
          Left = 314
          Top = 80
          Width = 57
          Height = 22
          Alignment = taLeftJustify
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
        object chkUsaFor: TCheckBox
          Tag = 99
          Left = 192
          Top = 30
          Width = 175
          Height = 18
          Caption = 'Utilizar Formula'#231#227'o'
          TabOrder = 1
        end
        object edtFatCus: TEditFocus
          Tag = 99
          Left = 215
          Top = 101
          Width = 56
          Height = 22
          Alignment = taLeftJustify
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
        object edtNfmDup: TEditFocus
          Tag = 99
          Left = 215
          Top = 124
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtAcuAbs: TEditFocus
          Tag = 99
          Left = 215
          Top = 171
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object rgOpcoes: TRadioGroup
          Left = 488
          Top = 85
          Width = 177
          Height = 41
          Caption = 'Gera'#231#227'o de Arquivo'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Csv'
            'Xml')
          TabOrder = 8
        end
        object edtDtaAtu: TMaskEditFocus
          Tag = 99
          Left = 215
          Top = 193
          Width = 89
          Height = 22
          EditMask = '!99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 9
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtVersao: TEditFocus
          Left = 357
          Top = 194
          Width = 164
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtVendaChroma: TEditFocus
          Tag = 99
          Left = 215
          Top = 221
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 11
          OnKeyPress = edtVendaChromaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesVendaChroma: TEditFocus
          Left = 271
          Top = 221
          Width = 394
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
        object edtVendaDuxone: TEditFocus
          Tag = 99
          Left = 215
          Top = 249
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 13
          OnKeyPress = edtVendaChromaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesVendaDuxone: TEditFocus
          Left = 271
          Top = 249
          Width = 394
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
        object edtDesVendaIron: TEditFocus
          Left = 271
          Top = 277
          Width = 394
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
        object edtVendaIron: TEditFocus
          Tag = 99
          Left = 215
          Top = 277
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 16
          OnKeyPress = edtVendaChromaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtVendaNason: TEditFocus
          Tag = 99
          Left = 215
          Top = 305
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 17
          OnKeyPress = edtVendaChromaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesVendaNason: TEditFocus
          Left = 271
          Top = 305
          Width = 394
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 18
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtVendaCormax: TEditFocus
          Tag = 99
          Left = 215
          Top = 333
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 19
          OnKeyPress = edtVendaChromaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesVendaCormax: TEditFocus
          Left = 271
          Top = 333
          Width = 394
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtDecFor: TEditFocus
          Tag = 99
          Left = 215
          Top = 363
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 21
          Text = '1'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttNumerico
        end
        object edtDesOpe: TEditFocus
          Tag = 99
          Left = 215
          Top = 386
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 22
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
          Left = 215
          Top = 409
          Width = 56
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
        inline fraPatDup: TfraDirectoryEditFocus
          Left = 215
          Top = 147
          TabOrder = 6
          Width = 450
          Height = 24
          Color = 16770261
          ParentBackground = False
          ParentColor = False
          inherited edtDirectory: TEditFocus
          end
        end
      end
    end
    object tbsConfCampos: TTabSheet
      Caption = '&2 - Consulta'
      ImageIndex = 1
    end
    object TabSheet1: TTabSheet
      Caption = '&3 - Embalagens'
      ImageIndex = 2
      object pnlEmbalagens: TPanel
        Left = 0
        Top = 0
        Width = 740
        Height = 482
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object sbEmbalagens: TScrollBox
          Left = 2
          Top = 2
          Width = 736
          Height = 478
          VertScrollBar.Position = 68
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BevelKind = bkFlat
          TabOrder = 0
          object Label8: TLabel
            Left = 24
            Top = -53
            Width = 189
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem DUXONE (LT):'
          end
          object Label6: TLabel
            Left = 21
            Top = -31
            Width = 192
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem DUXONE (GL):'
          end
          object Label9: TLabel
            Left = 55
            Top = 326
            Width = 158
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem (Copo):'
          end
          object Label11: TLabel
            Left = 51
            Top = 348
            Width = 162
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem (Spray):'
            Visible = False
          end
          object Label12: TLabel
            Left = 7
            Top = 370
            Width = 206
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem (Spray Sint'#233'tico):'
          end
          object Label14: TLabel
            Left = 7
            Top = 392
            Width = 206
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem (Spray Poliester):'
          end
          object Label15: TLabel
            Left = 23
            Top = 414
            Width = 190
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem (Spray Duco):'
          end
          object Label7: TLabel
            Left = 478
            Top = -53
            Width = 127
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o de Embalagem Litro:'
            Visible = False
          end
          object Label10: TLabel
            Left = 528
            Top = -31
            Width = 77
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o de Gal'#227'o:'
            Visible = False
          end
          object Label16: TLabel
            Left = 29
            Top = 25
            Width = 184
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem NASON (LT):'
          end
          object Label17: TLabel
            Left = 26
            Top = 47
            Width = 187
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem NASON (GL):'
          end
          object Label18: TLabel
            Left = 22
            Top = 103
            Width = 191
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem CHROMA (LT):'
          end
          object Label19: TLabel
            Left = 19
            Top = 125
            Width = 194
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem CHROMA (GL):'
          end
          object Label21: TLabel
            Left = 34
            Top = 180
            Width = 179
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem IMRON (LT):'
          end
          object Label22: TLabel
            Left = 31
            Top = 202
            Width = 182
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem IMRON (GL):'
          end
          object Label23: TLabel
            Left = 21
            Top = -9
            Width = 192
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem DUXONE (LA):'
          end
          object Label24: TLabel
            Left = 26
            Top = 69
            Width = 187
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem NASON (LA):'
          end
          object Label25: TLabel
            Left = 19
            Top = 147
            Width = 194
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem CHROMA (LA):'
          end
          object Label26: TLabel
            Left = 31
            Top = 224
            Width = 182
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem IMRON (LA):'
          end
          object Label27: TLabel
            Left = 53
            Top = 435
            Width = 160
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem (Balde):'
          end
          object Label28: TLabel
            Left = 45
            Top = 457
            Width = 168
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem (Tambor):'
          end
          object Label29: TLabel
            Left = 21
            Top = 252
            Width = 192
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem CORMAX (LT):'
          end
          object Label30: TLabel
            Left = 18
            Top = 274
            Width = 195
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem CORMAX (GL):'
          end
          object Label31: TLabel
            Left = 18
            Top = 296
            Width = 195
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto para Embalagem CORMAX (LA):'
          end
          object edtIte1_4: TEditFocus
            Tag = 99
            Left = 215
            Top = -57
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtIte1_4KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtIteGal: TEditFocus
            Tag = 99
            Left = 215
            Top = -35
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteGal: TEditFocus
            Left = 273
            Top = -35
            Width = 200
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
          object edtDesIte1_4: TEditFocus
            Left = 273
            Top = -57
            Width = 200
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
          object edtIteCop: TEditFocus
            Tag = 99
            Left = 215
            Top = 322
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 30
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteCop: TEditFocus
            Left = 273
            Top = 322
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 31
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtIteSpr: TEditFocus
            Tag = 99
            Left = 215
            Top = 344
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 32
            Visible = False
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteSpr: TEditFocus
            Left = 273
            Top = 344
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 33
            Visible = False
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtIteSps: TEditFocus
            Tag = 99
            Left = 215
            Top = 366
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 34
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteSps: TEditFocus
            Left = 273
            Top = 366
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 35
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtIteSpo: TEditFocus
            Tag = 99
            Left = 215
            Top = 388
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 36
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteSpo: TEditFocus
            Left = 273
            Top = 388
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 37
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtIteSdu: TEditFocus
            Tag = 99
            Left = 215
            Top = 411
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 39
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteSdu: TEditFocus
            Left = 273
            Top = 410
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 38
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtEmbGal: TEditFocus
            Tag = 99
            Left = 607
            Top = -35
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 45
            Visible = False
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtEmb1_4: TEditFocus
            Tag = 99
            Left = 607
            Top = -57
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 44
            Visible = False
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtNasoLT: TEditFocus
            Tag = 99
            Left = 215
            Top = 21
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtIte1_4KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtNasoGL: TEditFocus
            Tag = 99
            Left = 215
            Top = 43
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 8
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesNasoGL: TEditFocus
            Left = 273
            Top = 43
            Width = 200
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
          object edtDesNasoLT: TEditFocus
            Left = 273
            Top = 21
            Width = 200
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
          object edtChroLT: TEditFocus
            Tag = 99
            Left = 215
            Top = 99
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 12
            OnKeyPress = edtIte1_4KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtChroGL: TEditFocus
            Tag = 99
            Left = 215
            Top = 121
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 14
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesChroGL: TEditFocus
            Left = 273
            Top = 121
            Width = 200
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
          object edtDesChroLT: TEditFocus
            Left = 273
            Top = 99
            Width = 200
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
          object edtImroLT: TEditFocus
            Tag = 99
            Left = 215
            Top = 176
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 18
            OnKeyPress = edtIte1_4KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtImroGL: TEditFocus
            Tag = 99
            Left = 215
            Top = 198
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 20
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesImroGL: TEditFocus
            Left = 273
            Top = 198
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 21
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesImroLT: TEditFocus
            Left = 273
            Top = 176
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtIteLat: TEditFocus
            Tag = 99
            Left = 215
            Top = -13
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteLat: TEditFocus
            Left = 273
            Top = -13
            Width = 200
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
          object edtNasoLA: TEditFocus
            Tag = 99
            Left = 215
            Top = 65
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 10
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesNasoLA: TEditFocus
            Left = 273
            Top = 65
            Width = 200
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
          object edtChroLA: TEditFocus
            Tag = 99
            Left = 215
            Top = 142
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 16
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesChroLA: TEditFocus
            Left = 273
            Top = 143
            Width = 200
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
          object edtImroLA: TEditFocus
            Tag = 99
            Left = 215
            Top = 220
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 22
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesImroLA: TEditFocus
            Left = 273
            Top = 220
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 23
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtIteBal: TEditFocus
            Tag = 99
            Left = 215
            Top = 432
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 40
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteBal: TEditFocus
            Left = 273
            Top = 432
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 41
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtIteTam: TEditFocus
            Tag = 99
            Left = 215
            Top = 454
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 42
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIteTam: TEditFocus
            Left = 273
            Top = 454
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 43
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCormLT: TEditFocus
            Tag = 99
            Left = 215
            Top = 248
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 24
            OnKeyPress = edtIte1_4KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesCormLT: TEditFocus
            Left = 273
            Top = 248
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 25
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCormGL: TEditFocus
            Tag = 99
            Left = 215
            Top = 270
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 26
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesCormGL: TEditFocus
            Left = 273
            Top = 270
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 27
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCormLA: TEditFocus
            Tag = 99
            Left = 215
            Top = 292
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 28
            OnKeyPress = edtIteGalKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesCormLA: TEditFocus
            Left = 273
            Top = 292
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 29
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
  object pnlBotoesConf: TPanel [3]
    Left = 0
    Top = 537
    Width = 748
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      748
      28)
    object btnSairConf: TBitBtnLocked
      Left = 666
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
    Width = 748
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es - Dupont'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
  end
end
