inherited frmConfiguracoesNexa: TfrmConfiguracoesNexa
  Left = 347
  Top = 80
  Width = 587
  Height = 701
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es - Nexa Autocolor'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 587
  ExplicitHeight = 701
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 633
    Width = 581
    TabOrder = 1
    ExplicitTop = 633
    ExplicitWidth = 581
    DesignSize = (
      581
      28)
    inherited btnSair: TBitBtnLocked
      Left = 498
      TabOrder = 2
      ExplicitLeft = 498
    end
    object btnGravarConf: TBitBtnLocked
      Left = 9
      Top = 3
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
      Left = 88
      Top = 3
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
      TabOrder = 1
      Visible = False
      OnClick = btnRestaurarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 661
    Width = 581
    TabOrder = 2
    ExplicitTop = 661
    ExplicitWidth = 581
    inherited pnlNomeForm: TPanel
      Left = 410
      TabOrder = 1
      ExplicitLeft = 410
    end
    inherited pnlInfo: TPanel
      Width = 410
      TabOrder = 0
      ExplicitWidth = 410
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 581
    Height = 633
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 2
      Top = 2
      Width = 577
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es - Nexa Autocolor'
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
    object PageControl1: TPageControl
      Left = 2
      Top = 25
      Width = 577
      Height = 606
      ActivePage = TabSheet1
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 1
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = '&1 - Geral'
        object lbPatTxtDin: TLabel
          Left = 79
          Top = 295
          Width = 124
          Height = 14
          Alignment = taRightJustify
          Caption = 'Path para arquivos (*.txt):'
        end
        object Label9: TLabel
          Left = 278
          Top = 222
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator'
        end
        object Label7: TLabel
          Left = 100
          Top = 246
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Embalagem:'
        end
        object Label20: TLabel
          Left = 155
          Top = 222
          Width = 53
          Height = 14
          Caption = 'NEXA_PRE'
        end
        object Label15: TLabel
          Left = 67
          Top = 322
          Width = 136
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor de venda litro diluente:'
        end
        object Label12: TLabel
          Left = 70
          Top = 346
          Width = 133
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor de custo litro diluente:'
        end
        object Label11: TLabel
          Left = 23
          Top = 222
          Width = 128
          Height = 14
          Alignment = taRightJustify
          Caption = 'Trava para valor de venda'
        end
        object Label10: TLabel
          Left = 126
          Top = 270
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Gal'#227'o:'
        end
        object Label21: TLabel
          Left = 48
          Top = 370
          Width = 155
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#243'ximo C'#243'digo Novas F'#243'rmulas'
        end
        object Label24: TLabel
          Left = 90
          Top = 437
          Width = 129
          Height = 14
          Alignment = taRightJustify
          Caption = 'Despesas Operacionais %'
        end
        object Label25: TLabel
          Left = 5
          Top = 461
          Width = 209
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acr'#233'scimo Adicional sobre Pre'#231'o de Venda'
        end
        object edtTraNexa: TEditFocus
          Tag = 99
          Left = 205
          Top = 219
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNexaVvd: TEditFocus
          Tag = 99
          Left = 205
          Top = 319
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          MaxLength = 10
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
        object edtNexaVcd: TEditFocus
          Tag = 99
          Left = 205
          Top = 343
          Width = 56
          Height = 20
          Alignment = taLeftJustify
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
        object edtGalNexa: TEditFocus
          Tag = 99
          Left = 205
          Top = 267
          Width = 56
          Height = 20
          Alignment = taLeftJustify
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
        object edtFatNexa: TEditFocus
          Tag = 99
          Left = 311
          Top = 219
          Width = 57
          Height = 20
          Alignment = taLeftJustify
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
        object edtEmbNexa: TEditFocus
          Tag = 99
          Left = 205
          Top = 243
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          MaxLength = 10
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
        object chkUsaNexa: TCheckBox
          Tag = 99
          Left = 4
          Top = 7
          Width = 164
          Height = 18
          Caption = 'Utilizar essa tinta de m'#225'quina'
          TabOrder = 0
        end
        object chkUsaFor: TCheckBox
          Tag = 99
          Left = 174
          Top = 7
          Width = 117
          Height = 18
          Caption = 'Utilizar Formula'#231#227'o'
          TabOrder = 1
        end
        object edtProCod: TEditFocus
          Tag = 99
          Left = 205
          Top = 367
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttInteiro
          EditFormat = '#,##0.00'
        end
        object rgVersaoArquivo: TRadioGroup
          Left = 40
          Top = 387
          Width = 473
          Height = 38
          Caption = 'Vers'#227'o do Arquivo'
          Columns = 2
          Items.Strings = (
            'Vers'#227'o 1.0'
            'Vers'#227'o 2.0 (PaintManager)')
          TabOrder = 12
        end
        object chkAcuAbs: TCheckBox
          Tag = 99
          Left = 297
          Top = 7
          Width = 138
          Height = 18
          Caption = 'Formula'#231#227'o Acumulada'
          TabOrder = 2
        end
        object grbProVen: TGroupBox
          Left = 3
          Top = 31
          Width = 524
          Height = 172
          Caption = 'Produto para Venda'
          TabOrder = 3
          object Label6: TLabel
            Left = 187
            Top = 23
            Width = 16
            Height = 14
            Alignment = taRightJustify
            Caption = '2K:'
          end
          object Label1: TLabel
            Left = 153
            Top = 44
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'ACS (LA):'
          end
          object Label2: TLabel
            Left = 155
            Top = 87
            Width = 48
            Height = 14
            Alignment = taRightJustify
            Caption = 'Industran:'
          end
          object Label3: TLabel
            Left = 133
            Top = 108
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'Spectral Grey:'
          end
          object Label4: TLabel
            Left = 159
            Top = 150
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Zynamix:'
          end
          object Label5: TLabel
            Left = 109
            Top = 66
            Width = 96
            Height = 14
            Alignment = taRightJustify
            Caption = 'ACS Evolution (LA):'
          end
          object Label8: TLabel
            Left = 149
            Top = 129
            Width = 54
            Height = 14
            Alignment = taRightJustify
            Caption = 'Turbo Plus:'
          end
          object edtProNexa: TEditFocus
            Tag = 99
            Left = 205
            Top = 21
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = edtProNexaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesProNexa: TEditFocus
            Left = 262
            Top = 21
            Width = 251
            Height = 20
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
          object edtProAcs: TEditFocus
            Tag = 99
            Left = 205
            Top = 42
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 2
            OnKeyPress = edtProAcsKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesProAcs: TEditFocus
            Left = 262
            Top = 42
            Width = 251
            Height = 20
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
          object edtProInd: TEditFocus
            Tag = 99
            Left = 205
            Top = 84
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            OnKeyPress = edtProIndKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesProInd: TEditFocus
            Left = 262
            Top = 84
            Width = 251
            Height = 20
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
          object edtProSpe: TEditFocus
            Tag = 99
            Left = 205
            Top = 105
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 8
            OnKeyPress = edtProSpeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesProSpe: TEditFocus
            Left = 262
            Top = 105
            Width = 251
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtProZyn: TEditFocus
            Tag = 99
            Left = 205
            Top = 147
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 12
            OnKeyPress = edtProZynKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesProZyn: TEditFocus
            Left = 262
            Top = 147
            Width = 251
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtProEvo: TEditFocus
            Tag = 99
            Left = 205
            Top = 63
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtProEvoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesProEvo: TEditFocus
            Left = 262
            Top = 63
            Width = 251
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtProTur: TEditFocus
            Tag = 99
            Left = 205
            Top = 126
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 9
            OnKeyPress = edtProTurKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesProTur: TEditFocus
            Left = 262
            Top = 126
            Width = 251
            Height = 20
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        end
        object edtDesOpe: TEditFocus
          Tag = 99
          Left = 221
          Top = 431
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtApreve: TEditFocus
          Tag = 99
          Left = 220
          Top = 454
          Width = 56
          Height = 20
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtPatNexaDin: TFilenameEditFocus
          Left = 205
          Top = 291
          Properties.Buttons = <
            item
              Default = True
              Glyph.Data = {
                36050000424D3605000000000000360400002800000010000000100000000100
                0800000000000001000000000000000000000001000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                A6000020400000206000002080000020A0000020C0000020E000004000000040
                20000040400000406000004080000040A0000040C0000040E000006000000060
                20000060400000606000006080000060A0000060C0000060E000008000000080
                20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                20004000400040006000400080004000A0004000C0004000E000402000004020
                20004020400040206000402080004020A0004020C0004020E000404000004040
                20004040400040406000404080004040A0004040C0004040E000406000004060
                20004060400040606000406080004060A0004060C0004060E000408000004080
                20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                20008000400080006000800080008000A0008000C0008000E000802000008020
                20008020400080206000802080008020A0008020C0008020E000804000008040
                20008040400080406000804080008040A0008040C0008040E000806000008060
                20008060400080606000806080008060A0008060C0008060E000808000008080
                20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
                0000000000000000000000000000000000115A5A5A1100000000009AE3DBECF7
                636C7474746B6300000000E3FFFF086375756B636B757463000000E3FFF6AD75
                7D7563FF637D756C120000E3FFF66CBE6C6363F663636C75630000E3FFFF6BBE
                6308FFFFFFFF637D630000E3FFFF6C08AC6363FF63636CBE630000E4FFFFB5B6
                F6F66CF66C0808B55A0000E4FFFFF66C08F6B56CADF6086C000000E4FFFFFF08
                6CB6F6F6F6B66C11000000E4FFFFFFFFF6B6746C74B60700000000ECFFFFFFFF
                FFFFFFFFFFFFEC00000000ECFFFFFFFFFFFFFFFFFFFFE400000000ECFFFFFFFF
                FFFFFFFFFFFFEC00000000A3ECECECECECECECECECECA3000000}
              Kind = bkGlyph
            end>
          StyleFocused.Color = clInfoBk
          TabOrder = 8
          Width = 322
        end
      end
      object tbsConfCampos: TTabSheet
        Caption = '&2 - Consulta'
        ImageIndex = 2
      end
      object tbsEmbPMNexa: TTabSheet
        Caption = '&3 - Embalagens PM (Nexa)'
        ImageIndex = 4
        object sbComponentes: TScrollBox
          Left = 0
          Top = 0
          Width = 569
          Height = 574
          VertScrollBar.Margin = 5
          VertScrollBar.Position = 189
          Align = alClient
          TabOrder = 0
          object lblLazCop: TLabel
            Left = 48
            Top = 564
            Width = 28
            Height = 14
            Alignment = taRightJustify
            Caption = 'Copo:'
          end
          object GroupBox9: TGroupBox
            Left = 3
            Top = -181
            Width = 542
            Height = 182
            Caption = 'Litro'
            TabOrder = 0
            object Label42: TLabel
              Left = 85
              Top = 15
              Width = 16
              Height = 14
              Alignment = taRightJustify
              Caption = '2K:'
            end
            object Label43: TLabel
              Left = 51
              Top = 39
              Width = 50
              Height = 14
              Alignment = taRightJustify
              Caption = 'ACS (LA):'
            end
            object Label44: TLabel
              Left = 53
              Top = 87
              Width = 48
              Height = 14
              Alignment = taRightJustify
              Caption = 'Industran:'
            end
            object Label45: TLabel
              Left = 31
              Top = 111
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'Spectral Grey:'
            end
            object Label59: TLabel
              Left = 57
              Top = 159
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Zynamix:'
            end
            object Label13: TLabel
              Left = 5
              Top = 63
              Width = 96
              Height = 14
              Alignment = taRightJustify
              Caption = 'ACS Evolution (LA):'
            end
            object Label14: TLabel
              Left = 47
              Top = 133
              Width = 54
              Height = 14
              Alignment = taRightJustify
              Caption = 'Turbo Plus:'
            end
            object edtNexaPML2k: TEditFocus
              Tag = 99
              Left = 106
              Top = 11
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 0
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPML2k: TEditFocus
              Left = 170
              Top = 11
              Width = 365
              Height = 20
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
            object edtNexaPMLAc: TEditFocus
              Tag = 99
              Left = 106
              Top = 35
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 2
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLAc: TEditFocus
              Left = 170
              Top = 35
              Width = 365
              Height = 20
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
            object edtNexaPMLIn: TEditFocus
              Tag = 99
              Left = 106
              Top = 83
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 6
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLIn: TEditFocus
              Left = 170
              Top = 83
              Width = 365
              Height = 20
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
            object edtNexaPMLSg: TEditFocus
              Tag = 99
              Left = 106
              Top = 107
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 8
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLSg: TEditFocus
              Left = 170
              Top = 107
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMLZy: TEditFocus
              Tag = 99
              Left = 106
              Top = 155
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 12
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLZy: TEditFocus
              Left = 170
              Top = 155
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMLEv: TEditFocus
              Tag = 99
              Left = 106
              Top = 59
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 4
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLEv: TEditFocus
              Left = 170
              Top = 59
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMLTp: TEditFocus
              Tag = 99
              Left = 106
              Top = 131
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 9
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLTp: TEditFocus
              Left = 170
              Top = 131
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
          end
          object GroupBox10: TGroupBox
            Left = 3
            Top = 2
            Width = 542
            Height = 182
            Caption = 'Gal'#227'o'
            TabOrder = 1
            object Label46: TLabel
              Left = 82
              Top = 15
              Width = 16
              Height = 14
              Alignment = taRightJustify
              Caption = '2K:'
            end
            object Label47: TLabel
              Left = 48
              Top = 39
              Width = 50
              Height = 14
              Alignment = taRightJustify
              Caption = 'ACS (LA):'
            end
            object Label48: TLabel
              Left = 50
              Top = 87
              Width = 48
              Height = 14
              Alignment = taRightJustify
              Caption = 'Industran:'
            end
            object Label49: TLabel
              Left = 28
              Top = 111
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'Spectral Grey:'
            end
            object Label60: TLabel
              Left = 56
              Top = 159
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Zynamix:'
            end
            object Label16: TLabel
              Left = 4
              Top = 63
              Width = 96
              Height = 14
              Alignment = taRightJustify
              Caption = 'ACS Evolution (LA):'
            end
            object Label17: TLabel
              Left = 46
              Top = 133
              Width = 54
              Height = 14
              Alignment = taRightJustify
              Caption = 'Turbo Plus:'
            end
            object edtNexaPMG2k: TEditFocus
              Tag = 99
              Left = 105
              Top = 11
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 0
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMG2k: TEditFocus
              Left = 169
              Top = 11
              Width = 365
              Height = 20
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
            object edtNexaPMGAc: TEditFocus
              Tag = 99
              Left = 105
              Top = 35
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 2
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMGAc: TEditFocus
              Left = 169
              Top = 35
              Width = 365
              Height = 20
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
            object edtNexaPMGIn: TEditFocus
              Tag = 99
              Left = 105
              Top = 83
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 6
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMGIn: TEditFocus
              Left = 169
              Top = 83
              Width = 365
              Height = 20
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
            object edtNexaPMGSg: TEditFocus
              Tag = 99
              Left = 105
              Top = 107
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 8
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMGSg: TEditFocus
              Left = 169
              Top = 107
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMGZy: TEditFocus
              Tag = 99
              Left = 105
              Top = 155
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 12
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMGZy: TEditFocus
              Left = 169
              Top = 155
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtDesNexaPMGEv: TEditFocus
              Left = 169
              Top = 59
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMGEv: TEditFocus
              Tag = 99
              Left = 105
              Top = 59
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 4
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMGTp: TEditFocus
              Left = 169
              Top = 131
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMGTp: TEditFocus
              Tag = 99
              Left = 105
              Top = 131
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 9
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
          end
          object GroupBox11: TGroupBox
            Left = 3
            Top = 185
            Width = 542
            Height = 180
            Caption = 'Balde'
            TabOrder = 2
            object Label50: TLabel
              Left = 82
              Top = 15
              Width = 16
              Height = 14
              Alignment = taRightJustify
              Caption = '2K:'
            end
            object Label51: TLabel
              Left = 48
              Top = 39
              Width = 50
              Height = 14
              Alignment = taRightJustify
              Caption = 'ACS (LA):'
            end
            object Label52: TLabel
              Left = 50
              Top = 87
              Width = 48
              Height = 14
              Alignment = taRightJustify
              Caption = 'Industran:'
            end
            object Label53: TLabel
              Left = 28
              Top = 111
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'Spectral Grey:'
            end
            object Label61: TLabel
              Left = 56
              Top = 157
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Zynamix:'
            end
            object Label18: TLabel
              Left = 4
              Top = 62
              Width = 96
              Height = 14
              Alignment = taRightJustify
              Caption = 'ACS Evolution (LA):'
            end
            object Label19: TLabel
              Left = 44
              Top = 133
              Width = 54
              Height = 14
              Alignment = taRightJustify
              Caption = 'Turbo Plus:'
            end
            object edtNexaPMLA2k: TEditFocus
              Tag = 99
              Left = 105
              Top = 11
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 0
              OnKeyPress = edtNexaPMLAduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLA2k: TEditFocus
              Left = 169
              Top = 11
              Width = 365
              Height = 20
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
            object edtNexaPMLAAc: TEditFocus
              Tag = 99
              Left = 105
              Top = 35
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 2
              OnKeyPress = edtNexaPMLAduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLAAc: TEditFocus
              Left = 169
              Top = 35
              Width = 365
              Height = 20
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
            object edtNexaPMLAIn: TEditFocus
              Tag = 99
              Left = 105
              Top = 83
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 6
              OnKeyPress = edtNexaPMLAduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLAIn: TEditFocus
              Left = 169
              Top = 83
              Width = 365
              Height = 20
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
            object edtNexaPMLASg: TEditFocus
              Tag = 99
              Left = 105
              Top = 107
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 8
              OnKeyPress = edtNexaPMLAduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLASg: TEditFocus
              Left = 169
              Top = 107
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMLAZy: TEditFocus
              Tag = 99
              Left = 105
              Top = 155
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 12
              OnKeyPress = edtNexaPMLAduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLAZy: TEditFocus
              Left = 169
              Top = 155
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMLAEv: TEditFocus
              Tag = 99
              Left = 105
              Top = 59
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 4
              OnKeyPress = edtNexaPMLAduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLAEv: TEditFocus
              Left = 169
              Top = 59
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMLATp: TEditFocus
              Tag = 99
              Left = 105
              Top = 131
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 9
              OnKeyPress = edtNexaPMLAduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMLATp: TEditFocus
              Left = 169
              Top = 131
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
          end
          object GroupBox12: TGroupBox
            Left = 3
            Top = 365
            Width = 542
            Height = 189
            Caption = 'Tambor'
            TabOrder = 3
            object Label54: TLabel
              Left = 82
              Top = 15
              Width = 16
              Height = 14
              Alignment = taRightJustify
              Caption = '2K:'
            end
            object Label55: TLabel
              Left = 48
              Top = 39
              Width = 50
              Height = 14
              Alignment = taRightJustify
              Caption = 'ACS (LA):'
            end
            object Label56: TLabel
              Left = 50
              Top = 87
              Width = 48
              Height = 14
              Alignment = taRightJustify
              Caption = 'Industran:'
            end
            object Label57: TLabel
              Left = 28
              Top = 111
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'Spectral Grey:'
            end
            object Label62: TLabel
              Left = 56
              Top = 161
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Zynamix:'
            end
            object Label22: TLabel
              Left = 4
              Top = 63
              Width = 96
              Height = 14
              Alignment = taRightJustify
              Caption = 'ACS Evolution (LA):'
            end
            object Label23: TLabel
              Left = 46
              Top = 136
              Width = 54
              Height = 14
              Alignment = taRightJustify
              Caption = 'Turbo Plus:'
            end
            object edtNexaPMT2k: TEditFocus
              Tag = 99
              Left = 105
              Top = 11
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 0
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMT2k: TEditFocus
              Left = 169
              Top = 11
              Width = 365
              Height = 20
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
            object edtNexaPMTAc: TEditFocus
              Tag = 99
              Left = 105
              Top = 35
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 2
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMTAc: TEditFocus
              Left = 169
              Top = 35
              Width = 365
              Height = 20
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
            object edtNexaPMTin: TEditFocus
              Tag = 99
              Left = 105
              Top = 83
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 6
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMTin: TEditFocus
              Left = 169
              Top = 83
              Width = 365
              Height = 20
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
            object edtNexaPMTSg: TEditFocus
              Tag = 99
              Left = 105
              Top = 107
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 8
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMTSg: TEditFocus
              Left = 169
              Top = 107
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMTZy: TEditFocus
              Tag = 99
              Left = 105
              Top = 157
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 12
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMTZy: TEditFocus
              Left = 169
              Top = 157
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtDesNexaPMTEv: TEditFocus
              Left = 169
              Top = 59
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMTEv: TEditFocus
              Tag = 99
              Left = 105
              Top = 59
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 4
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesNexaPMTTp: TEditFocus
              Left = 169
              Top = 132
              Width = 365
              Height = 20
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtNexaPMTTp: TEditFocus
              Tag = 99
              Left = 105
              Top = 132
              Width = 56
              Height = 20
              Alignment = taLeftJustify
              MaxLength = 5
              TabOrder = 9
              OnKeyPress = edtNexaPMLduKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
          end
          object edtNexaCop: TEditFocus
            Tag = 99
            Left = 84
            Top = 560
            Width = 56
            Height = 20
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 4
            OnKeyPress = edtNexaLAduKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesNexaCop: TEditFocus
            Left = 148
            Top = 560
            Width = 365
            Height = 20
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
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 16
  end
end
