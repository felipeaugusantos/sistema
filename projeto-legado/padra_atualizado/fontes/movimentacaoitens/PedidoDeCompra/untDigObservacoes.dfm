inherited frmDigObservacoes: TfrmDigObservacoes
  Left = 385
  Top = 202
  Width = 809
  Height = 710
  BorderIcons = [biSystemMenu]
  Caption = 'Op'#231#245'es'
  Position = poMainFormCenter
  ExplicitWidth = 809
  ExplicitHeight = 710
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 639
    Width = 803
    Height = 26
    Enabled = True
    TabOrder = 4
    Visible = True
    ExplicitTop = 639
    ExplicitWidth = 803
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 179
      Width = 545
      Height = 22
      TabOrder = 3
      ExplicitLeft = 179
      ExplicitWidth = 545
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 724
      Top = 2
      Align = alRight
      ModalResult = 2
      TabOrder = 2
      ExplicitLeft = 724
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 75
      Height = 22
      Align = alLeft
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnParcel: TBitBtnLocked
      Left = 77
      Top = 2
      Width = 102
      Height = 22
      Align = alLeft
      Caption = '&Parcelamento'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00030000000C0000001400000017000000180000001900000019000000120000
        0004000000000000000000000000000000000000000000000000000000000000
        000A885835C3BB7846FFB97544FFB77242FFB66F3EFFB36C3DFF7F4C2AC90000
        0011000000000000000000000000000000000000000000000000000000000000
        000EC07E4EFFF7F3EDFFF3EAE0FFF1E8DDFFF0E7DBFFF0E6D8FFB56D3DFF0000
        0044000000230000000800000000000000000000000000000000000000000000
        000DC38352FFF9F4EFFFF4EDE3FFF2EAE0FFF2E9DDFFF0E7DAFFB77140FF127D
        22FF277325F30000002100000000000000000000000000000000000000000000
        000CC68857FFF9F6F1FFF4EFE6FFF4ECE3FFF3EBE0FFF1E9DDFFB97544FF46CC
        87FF138D27FF0000004300000012000000040000000000000000000000000000
        000AC98D5CFFFBF7F4FFF6F0E9FFF4EEE6FFF4EDE3FFF3EBE0FFBC7848FF4BD0
        8AFF158E28FF9C6540FF885736C9000000110000000000000000000000000000
        0009CB915FFFFCF9F6FFF7F3ECFFF6F0E9FFF5EEE6FFF4ECE3FFBF7E4DFF4ED3
        8EFF15912AFFC8BFB4FFC07D4FFF0000002F0000001200000004000000000000
        0007CF9564FFFCFAF8FFF9F5EFFFF7F2ECFFF6F0E9FFF5EEE6FFC28251FF51D7
        92FF17932CFFCBC3B8FFC28052FF1A812EFF146724C900000011000000000000
        0006D19967FFFCFBFAFFFCFAF8FFFBF9F6FFFAF8F4FFF9F6F1FFC48555FF56DA
        96FF19952FFFCFC8BEFFC48254FF5CCF94FF1C9235FF00000019000000000000
        00039D744FC1D29A69FFD09765FFCD9463FFCC915FFFCA8E5DFFAA9C67FF5BE1
        9DFF1A9931FFD4CCC3FFC68558FF60D196FF1E9336FF00000018000000000000
        0001000000030000001121A23DFFA9F0CDFFA4EEC9FFA0ECC6FF9EEDC6FF9DF1
        C6FF1C9B34FFD9D2CAFFC78A5DFF63D59AFF1F9538FF00000016000000000000
        00000000000000000006409844F022A73FFF21A63EFF20A33CFF1FA03AFF1EA0
        38FF439945FFE5DED6FFCA8D60FF67D89EFF21973AFF00000015000000000000
        000000000000000000020000000600000010CC966BFFEEEDECFFECEAE8FFE9E7
        E4FFECEBE7FFF5F2EDFFCC9063FF6BDCA1FF23983DFF00000013000000000000
        000000000000000000000000000000000003A17856C1D79F72FFD59D70FFD49B
        6EFFD3996BFFD19669FFB4A473FF70E3A7FF259B3FFF00000011000000000000
        000000000000000000000000000000000001000000030000000B2CA149FFB4F0
        D1FFB0EFCFFFACEDCBFFAAEECBFFAAF2CCFF279D42FF0000000E000000000000
        0000000000000000000000000000000000000000000000000003237B39C12DA6
        4BFF2CA54AFF2BA349FF2AA147FF29A145FF1D7632C500000009}
      TabOrder = 1
      OnClick = btnParcelClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 665
    Width = 803
    TabOrder = 5
    ExplicitTop = 665
    ExplicitWidth = 803
    inherited pnlNomeForm: TPanel
      Left = 641
      Width = 162
      ExplicitLeft = 641
      ExplicitWidth = 162
    end
    inherited pnlInfo: TPanel
      Width = 641
      ExplicitWidth = 641
    end
  end
  inherited pgcDados: TPageControl
    Top = 545
    Width = 417
    Height = 53
    Align = alNone
    TabOrder = 3
    Visible = False
    ExplicitTop = 545
    ExplicitWidth = 417
    ExplicitHeight = 53
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 409
      ExplicitHeight = 21
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 88
    Width = 400
    Height = 551
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object gpbTransportador: TGroupBox
      Left = 0
      Top = 138
      Width = 400
      Height = 230
      Align = alTop
      Caption = ' Transportador  '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Panel1: TPanel
        Left = 2
        Top = 16
        Width = 396
        Height = 212
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 35
          Top = 3
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 41
          Top = 27
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 22
          Top = 50
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 35
          Top = 73
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodTra: TEditFocus
          Tag = 99
          Left = 74
          Top = 0
          Width = 49
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodTraKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomTra: TEditFocus
          Tag = 99
          Left = 74
          Top = 23
          Width = 319
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEndere: TEditFocus
          Tag = 99
          Left = 74
          Top = 46
          Width = 319
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
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
        object edtCidade: TEditFocus
          Tag = 99
          Left = 74
          Top = 69
          Width = 319
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object pnlFrete: TPanel
          Left = 0
          Top = 91
          Width = 396
          Height = 121
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object Label6: TLabel
            Left = 5
            Top = 7
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Frete:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 0
            Top = 27
            Width = 71
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor do Frete:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl1: TLabel
            Left = 3
            Top = 84
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Des. Acess'#243'.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblPerFre: TLabel
            Left = 218
            Top = 27
            Width = 123
            Height = 14
            Alignment = taRightJustify
            Caption = 'Perc. Frete Total Itens:'
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lblPerAce: TLabel
            Left = 185
            Top = 84
            Width = 156
            Height = 14
            Alignment = taRightJustify
            Caption = 'Perc. Des. Acess Total Itens:'
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lblPerFreVlr: TLabel
            Left = 359
            Top = 27
            Width = 21
            Height = 14
            Alignment = taRightJustify
            Caption = '0,00'
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lblPerAceVlr: TLabel
            Left = 359
            Top = 84
            Width = 21
            Height = 14
            Alignment = taRightJustify
            Caption = '0,00'
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lblPerFre_: TLabel
            Left = 383
            Top = 27
            Width = 9
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lblPerAce_: TLabel
            Left = 383
            Top = 84
            Width = 9
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object cmbTipFre: TComboBoxFocus
            Tag = 99
            Left = 74
            Top = 1
            Width = 200
            Height = 22
            Style = csDropDownList
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnChange = cmbTipFreChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtDesAce: TEditFocus
            Tag = 99
            Left = 74
            Top = 79
            Width = 84
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
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
          object edtValFre: TEditFocus
            Tag = 99
            Left = 74
            Top = 24
            Width = 84
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
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
          object chkCalStFrete: TCheckBox
            Left = 4
            Top = 46
            Width = 214
            Height = 17
            Caption = 'Incluir Frete na Base de C'#225'lculo de ST'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object chkCalStDesAce: TCheckBox
            Left = 4
            Top = 102
            Width = 239
            Height = 17
            Caption = 'Incluir Desp. Ace. na Base de C'#225'lculo de ST'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object chkCalIpiFrete: TCheckBox
            Left = 4
            Top = 61
            Width = 214
            Height = 17
            Caption = 'Incluir Frete na Base de C'#225'lculo de IPI'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
        end
      end
    end
    object gpbEntrega: TGroupBox
      Left = 0
      Top = 368
      Width = 400
      Height = 113
      Align = alTop
      Caption = ' Endere'#231'o de Entrega '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object lbl2: TLabel
        Left = 43
        Top = 46
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl3: TLabel
        Left = 24
        Top = 69
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl4: TLabel
        Left = 37
        Top = 92
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 12
        Top = 22
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Carregar de:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtNomEmp: TEditFocus
        Tag = 99
        Left = 76
        Top = 42
        Width = 319
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 60
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEndEmp: TEditFocus
        Tag = 99
        Left = 76
        Top = 65
        Width = 319
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 50
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
      object edtCidEmp: TEditFocus
        Tag = 99
        Left = 76
        Top = 88
        Width = 319
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 50
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cmbEmpresas: TComboBoxFocus
        Left = 76
        Top = 19
        Width = 318
        Height = 22
        Style = csDropDownList
        TabOrder = 0
        OnChange = cmbEmpresasChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object gpbDadAdc: TGroupBox
      Left = 0
      Top = 481
      Width = 400
      Height = 66
      Align = alTop
      Caption = ' Dados Adicionais '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object btnCodCta: TBitBtnLocked
        Left = 92
        Top = 40
        Width = 41
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
          300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
          330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
          333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
          339977FF777777773377000BFB03333333337773FF733333333F333000333333
          3300333777333333337733333333333333003333333333333377333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 2
        Visible = False
        OnClick = btnCodCtaClick
      end
      inline fraCentroCusto: TfraCentroCustoEditFocus
        Left = 5
        Top = 16
        Width = 388
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 5
        ExplicitTop = 16
        ExplicitWidth = 388
        inherited lblEventos: TLabel
          Left = 0
          Width = 87
          Height = 14
          ExplicitLeft = 0
          ExplicitWidth = 87
          ExplicitHeight = 14
        end
        inherited edtCodEve: TEditFocus
          Left = 87
          Width = 62
          Height = 22
          ExplicitLeft = 87
          ExplicitWidth = 62
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Width = 237
          Height = 22
          ExplicitWidth = 237
          ExplicitHeight = 22
        end
      end
      inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
        Left = 11
        Top = 39
        Width = 385
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 11
        ExplicitTop = 39
        ExplicitWidth = 385
        inherited lblPlaContas: TLabel
          Left = 0
          Top = 3
          Width = 81
          Height = 14
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          ParentFont = False
          ExplicitLeft = 0
          ExplicitTop = 3
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 144
          Width = 237
          Height = 22
          ExplicitLeft = 144
          ExplicitWidth = 237
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 81
          Width = 62
          Height = 22
          OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
          ExplicitLeft = 81
          ExplicitWidth = 62
          ExplicitHeight = 22
        end
      end
    end
    object rgbTransRedespacho: TGroupBox
      Left = 0
      Top = 0
      Width = 400
      Height = 138
      Align = alTop
      Caption = 'Transportador De Redespacho  '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Panel3: TPanel
        Left = 2
        Top = 16
        Width = 396
        Height = 120
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label13: TLabel
          Left = 35
          Top = 7
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 41
          Top = 30
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 22
          Top = 53
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 35
          Top = 76
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodTraRedespacho: TEditFocus
          Tag = 99
          Left = 74
          Top = 3
          Width = 49
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodTraRedespachoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomTraRedespacho: TEditFocus
          Tag = 99
          Left = 74
          Top = 26
          Width = 319
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEndereRedespacho: TEditFocus
          Tag = 99
          Left = 74
          Top = 49
          Width = 319
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
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
        object edtCidadeRedespacho: TEditFocus
          Tag = 99
          Left = 74
          Top = 72
          Width = 319
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object Panel4: TPanel
          Left = 0
          Top = 95
          Width = 396
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object Label17: TLabel
            Left = 5
            Top = 5
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Frete:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object cmbTipFreRedespacho: TComboBoxFocus
            Tag = 99
            Left = 74
            Top = 0
            Width = 200
            Height = 22
            Style = csDropDownList
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnChange = cmbTipFreRedespachoChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
    end
  end
  object pnlDireita: TPanel [4]
    Left = 400
    Top = 88
    Width = 403
    Height = 551
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object gpbObservacao: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 56
      Width = 397
      Height = 164
      Margins.Top = 0
      Align = alTop
      Caption = ' Observa'#231#245'es '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object pnlPedidoVenda: TPanel
        Left = 2
        Top = 16
        Width = 393
        Height = 26
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 6
          Width = 84
          Height = 14
          Caption = 'Pedido de Venda:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtPedVen: TEditFocus
          Tag = 99
          Left = 96
          Top = 2
          Width = 288
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtPedVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlDados: TPanel
        Left = 2
        Top = 42
        Width = 393
        Height = 120
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object memObserv: TMemo
          Tag = 99
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 387
          Height = 114
          Align = alClient
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1440
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object gpbAtencao: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 226
      Width = 397
      Height = 68
      Align = alTop
      Caption = 'Contato no Fornecedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object pnlFundo: TPanel
        Left = 2
        Top = 39
        Width = 393
        Height = 27
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object edtAtenca: TEditFocus
          Tag = 99
          Left = 5
          Top = 3
          Width = 380
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
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
      end
      object cbxEnviarWhatsapp: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 19
        Width = 387
        Height = 17
        Align = alTop
        Caption = 'Enviar para Whastapp'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
      end
    end
    object gpbFinalPed: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 300
      Width = 397
      Height = 169
      Align = alTop
      Caption = ' Finaliza'#231#227'o do Pedido '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object rdgEndEnt: TRadioGroup
        Left = 8
        Top = 87
        Width = 377
        Height = 62
        Caption = 'Endere'#231'o de entrega para o(s) pedido(s) gerado(s):'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Digitado acima'
          'Gravar o endere'#231'o de loja para a qual o pedido ser'#225' gerado')
        ParentFont = False
        TabOrder = 1
      end
      object rdgOpcMultiLojas: TRadioGroup
        Left = 8
        Top = 19
        Width = 377
        Height = 62
        Caption = 'Op'#231#227'o de Grava'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Manter o pedido como Multi-Loja'
          'Desmembrar o pedido gerando um pedido para cada loja')
        ParentFont = False
        TabOrder = 0
        OnClick = rdgOpcMultiLojasClick
      end
    end
    object gpbOrdemCompra: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 397
      Height = 50
      Align = alTop
      Caption = 'Ordem de Compra no Fornecedor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Panel5: TPanel
        Left = 2
        Top = 16
        Width = 393
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object edtOrdemCompra: TEditFocus
          Tag = 99
          Left = 5
          Top = 3
          Width = 380
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
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
      end
    end
    object chkEnvEmailAutomatico: TCheckBox
      Left = 0
      Top = 534
      Width = 403
      Height = 17
      Align = alBottom
      Caption = 'Envia Email automaticamente para o fornecedor do pedido'
      TabOrder = 4
      Visible = False
    end
  end
  object pnlDadosIniciais: TPanel [5]
    Left = 0
    Top = 0
    Width = 803
    Height = 88
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    Visible = False
    object Label7: TLabel
      Left = 16
      Top = 13
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Entrega:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 379
      Top = 13
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comprador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 163
      Top = 13
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Faturam.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 187
      Top = 40
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cnd.Pgto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 7
      Top = 60
      Width = 226
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ocorr'#234'ncia para baixa dos pedidos unificados:'
    end
    object mskDtaPed: TMaskEditFocus
      Tag = 99
      Left = 84
      Top = 9
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodCmp: TEditFocus
      Tag = 99
      Left = 438
      Top = 9
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      PasswordChar = '*'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaFat: TMaskEditFocus
      Tag = 99
      Left = 236
      Top = 9
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object chkPgAVis: TCheckBox
      Left = 18
      Top = 40
      Width = 129
      Height = 14
      Caption = 'Cnd. Pagto '#192' Vista'
      TabOrder = 3
      OnClick = chkPgAVisClick
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 236
      Top = 32
      Width = 539
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 4
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomCmp: TEditFocus
      Left = 526
      Top = 9
      Width = 249
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodOco: TEditFocus
      Tag = 99
      Left = 236
      Top = 56
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 6
      OnExit = edtCodOcoExit
      OnKeyPress = edtCodOcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesOco: TEditFocus
      Left = 287
      Top = 56
      Width = 239
      Height = 22
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
    object rdgTipoGravacao: TRadioGroup
      Left = 529
      Top = 32
      Width = 185
      Height = 49
      Caption = 'Tipo Grava'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Pedido'
        'Or'#231'amento')
      TabOrder = 8
    end
    object pnlMultLojaPasta: TPanel
      Left = 456
      Top = 1
      Width = 346
      Height = 86
      Align = alRight
      BevelOuter = bvLowered
      Caption = 'pnlMultLojaPasta'
      ShowCaption = False
      TabOrder = 9
      Visible = False
      object pnlAvisoEmpresas: TPanel
        Left = 1
        Top = 1
        Width = 344
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Ser'#227'o gerados pedidos para XXX empresas.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object chkReplicarDados: TCheckBox
        Left = 24
        Top = 30
        Width = 297
        Height = 17
        Caption = 'Replicar os dados acima para todos os pedidos gerados'
        TabOrder = 1
      end
      object MemoFocus1: TMemoFocus
        Left = 1
        Top = 51
        Width = 344
        Height = 34
        Align = alBottom
        Lines.Strings = (
          'OBS.: Endere'#231'o de Entrega N'#195'O ser'#225' replicado '#8212' ser'#225' preenchido '
          'conforme a empresa de cada pedido.')
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
        Texto = 
          'OBS.: Endere'#231'o de Entrega N'#195'O ser'#225' replicado '#8212' ser'#225' preenchido c' +
          'onforme a empresa de cada pedido.'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 600
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 160
  end
end
