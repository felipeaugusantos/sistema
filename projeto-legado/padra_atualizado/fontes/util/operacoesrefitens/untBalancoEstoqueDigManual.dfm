inherited frmBalancoEstoqueDigManual: TfrmBalancoEstoqueDigManual
  Left = 249
  Top = 137
  Width = 900
  Height = 619
  Caption = 'Balan'#231'o de Estoque - Digita'#231#227'o Manual'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 900
  ExplicitHeight = 619
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 546
    Width = 894
    TabOrder = 3
    ExplicitTop = 546
    ExplicitWidth = 894
    DesignSize = (
      894
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 890
      TabOrder = 2
      ExplicitWidth = 890
    end
    inherited btnSair: TBitBtnLocked
      Left = 811
      TabOrder = 3
      ExplicitLeft = 811
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 97
      Height = 22
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
    object btnFinalizaContagem: TBitBtnLocked
      Left = 137
      Top = 3
      Width = 132
      Height = 22
      Caption = '&Finaliza Contagens'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00010000000B08271977051D11770000000B0000000100000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000604190F501D7951FB11643EFB03110A520000000700000000000000020000
        000A0000000F000000100000001000000010000000110000001100000015020B
        0739147048ED20B175FF18AA6DFF0F5233EC0108052D00000004000000094633
        2CC160453BFF644A41FFB87D4EFFB97A4AFFB47444FFC69777FFC4A891FF3986
        5FFF26B07BFF1EB97CFF1EB87BFF1AA26AFF0B442BD1000201160000000D6F53
        47FF947869FF6A4F46FFD8B07BFFD7AE77FFD7AB74FFE5CFB4FF659674FF4BB5
        91FF8FE5CCFF7FE1C3FF5CD4ABFF69D8B4FF40A581FF093420A50000000C7357
        4AFF987D6EFF70564BFFFFFFFFFFF6EFEAFFF6EFE9FFF6F2EFFF208760FF2086
        5DFF1F845DFF97EBD4FF77E1C3FF1A774FFF1A764EFF19754FFF0000000B785C
        4EFF9D8273FF765C50FFFFFFFFFFF7F0EBFFF7F0EBFFFAF6F4FFF6F2F0FFEFEB
        E9FF218B63FFA8F1DFFF8CEBD2FF1C7B55FF0000000F000000070000000A7C60
        50FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFA
        FAFF229067FFC7F8EFFFC5F8EDFF1C8158FF0000000600000000000000097F63
        54FFA78E7DFF977A6AFF967969FF957967FF84695CFF705548FF775C51FFBAAD
        A7FF4D9B7BFF24946BFF23936AFF19694CBD0000000300000000000000088367
        57FFAB9382FF634A41FF614740FF5E463DFF5C443CFF5B433BFF594139FF9485
        7FFFAA9E9AFFBBACA8FFAFA29DFF0000000C000000000000000000000007866A
        59FFAF9788FF674E44FFF3EAE4FFE7D5C8FFE7D4C6FFE6D3C5FFE6D3C5FFE6D3
        C5FF594139FF795D54FF674C40FF00000009000000000000000000000006886D
        5CFFB39C8CFF6B5248FFF4ECE6FFE9D9CDFFE8D7CAFF4B3D3AFF50433EFFE6D3
        C5FF5D453CFF7B6056FF6B4F43FF000000080000000000000000000000058B70
        5EFFB7A091FF70564DFFF6EFEAFFECDDD3FFEADAD0FF473A36FF473A36FFE7D4
        C7FF604740FF7D6257FF6E5347FF000000070000000000000000000000048E72
        60FFBBA595FF755A50FFF7F1ECFFF6F0EBFFF5EEE9FFF5EDE7FFF4ECE6FFF4EB
        E4FF654B43FF7F6459FF72574AFF000000060000000000000000000000026A56
        49BF8F7361FF795E54FF765D52FF745A50FF72584EFF70564CFF6E544AFF6B52
        48FF6A5047FF795D4EFF574439C0000000040000000000000000000000010000
        0002000000030000000300000003000000040000000400000004000000040000
        0004000000040000000400000003000000010000000000000000}
      TabOrder = 1
      OnClick = btnFinalizaContagemClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 574
    Width = 894
    TabOrder = 5
    ExplicitTop = 574
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 723
      ExplicitLeft = 723
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 723
    end
  end
  object pnlProduto: TPanel [2]
    Left = 0
    Top = 0
    Width = 894
    Height = 239
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object pnlDigitador: TPanel
      Left = 1
      Top = 1
      Width = 892
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblDigita: TLabel
        Left = 43
        Top = 6
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Digitador:'
      end
      object edtSenDig: TEditFocus
        Tag = 99
        Left = 91
        Top = 2
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 0
        OnEnter = edtSenDigEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomDig: TEditFocus
        Left = 157
        Top = 2
        Width = 310
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
    end
    object Panel1: TPanel
      Left = 1
      Top = 76
      Width = 892
      Height = 162
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object Label2: TLabel
        Left = 13
        Top = 5
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo Produto:'
      end
      object Label5: TLabel
        Left = 37
        Top = 28
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label7: TLabel
        Left = 33
        Top = 51
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
      end
      object Label9: TLabel
        Left = 374
        Top = 51
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object Label11: TLabel
        Left = 56
        Top = 75
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object Label13: TLabel
        Left = 30
        Top = 97
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label3: TLabel
        Left = 473
        Top = 28
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label1: TLabel
        Left = 7
        Top = 147
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo Contagem:'
      end
      object lblSalGml: TLabel
        Left = 170
        Top = 147
        Width = 110
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo Cont. Grama/ML:'
        Visible = False
      end
      object Label6: TLabel
        Left = 31
        Top = 123
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo Atual:'
      end
      object lblSalAml: TLabel
        Left = 172
        Top = 118
        Width = 109
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo Atual Grama/ML:'
        Visible = False
      end
      object lblSalRes: TLabel
        Left = 364
        Top = 118
        Width = 178
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo Reservado em Ordem Servi'#231'o:'
        Visible = False
      end
      object lblSalResVenSep: TLabel
        Left = 666
        Top = 110
        Width = 143
        Height = 28
        Alignment = taRightJustify
        Caption = 'Saldo Reservado em Vendas (Separado e conferido):'
        Visible = False
        WordWrap = True
      end
      object lblItemEstrutura: TLabel
        Left = 287
        Top = 6
        Width = 92
        Height = 14
        Caption = 'ITEM ESTRUTURA'
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 91
        Top = 1
        Width = 189
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 40
        TabOrder = 0
        OnEnter = edtCodIteEnter
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtLinGru: TEditFocus
        Left = 543
        Top = 24
        Width = 226
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
        Left = 91
        Top = 24
        Width = 376
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
        Left = 91
        Top = 47
        Width = 275
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
      object edtDesMar: TEditFocus
        Left = 91
        Top = 70
        Width = 376
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
      object edtNomFor: TEditFocus
        Left = 91
        Top = 93
        Width = 376
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
      object edtDesUni: TEditFocus
        Left = 419
        Top = 47
        Width = 48
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
      object edtSalCon: TEditFocus
        Tag = 99
        Left = 91
        Top = 139
        Width = 77
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 10
        ReadOnly = True
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###0.000'
      end
      object edtSalGMl: TEditFocus
        Tag = 99
        Left = 283
        Top = 139
        Width = 77
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 10
        ReadOnly = True
        TabOrder = 8
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###0.0000'
      end
      object edtSalAtu: TEditFocus
        Tag = 99
        Left = 91
        Top = 116
        Width = 77
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 10
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###0.000'
      end
      object edtSalAMl: TEditFocus
        Tag = 99
        Left = 283
        Top = 116
        Width = 77
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 10
        ReadOnly = True
        TabOrder = 10
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###0.0000'
      end
      object chkUsarInativos: TcxCheckBox
        Left = 366
        Top = 140
        Caption = 'Exibir tamb'#233'm os lotes inativos'
        TabOrder = 11
      end
      object edtSalRes: TEditFocus
        Tag = 99
        Left = 543
        Top = 115
        Width = 77
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 10
        ReadOnly = True
        TabOrder = 12
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###0.0000'
      end
      object edtSalResVenSep: TEditFocus
        Tag = 99
        Left = 810
        Top = 115
        Width = 77
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 10
        ReadOnly = True
        TabOrder = 13
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###0.0000'
      end
    end
    object pnlLocFis: TPanel
      Left = 1
      Top = 54
      Width = 892
      Height = 22
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Label8: TLabel
        Left = -1
        Top = 4
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Caption = 'Localiza'#231#227'o Fis'#237'ca'
      end
      object edtLocFis: TEditFocus
        Tag = 99
        Left = 91
        Top = 0
        Width = 189
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        TabOrder = 0
        OnEnter = edtLocFisEnter
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlOper: TPanel
      Left = 1
      Top = 26
      Width = 892
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label10: TLabel
        Left = 0
        Top = 0
        Width = 87
        Height = 28
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Operador da Contagem:'
        WordWrap = True
      end
      object edtCodOpe: TEditFocus
        Tag = 99
        Left = 91
        Top = 3
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        OnKeyPress = edtCodOpeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesOpe: TEditFocus
        Left = 157
        Top = 3
        Width = 310
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
    end
  end
  object pnlSaldo: TPanel [3]
    Left = 0
    Top = 239
    Width = 894
    Height = 30
    Align = alTop
    Color = 16770261
    Enabled = False
    TabOrder = 1
    object Label4: TLabel
      Left = 27
      Top = 8
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo Fis'#237'co:'
    end
    object lblSldMl: TLabel
      Left = 181
      Top = 8
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo em Grama/ML:'
      Visible = False
    end
    object edtSldCon: TEditFocus
      Tag = 99
      Left = 91
      Top = 4
      Width = 77
      Height = 22
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '###0.000'
    end
    object edtSldMl: TEditFocus
      Tag = 99
      Left = 283
      Top = 4
      Width = 77
      Height = 22
      Alignment = taRightJustify
      MaxLength = 10
      TabOrder = 1
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '###0.0000'
    end
  end
  object pnlSalLot: TPanel [4]
    Tag = 99
    Left = 0
    Top = 269
    Width = 894
    Height = 208
    Align = alTop
    Caption = 'Grid de Lotes'
    ParentColor = True
    TabOrder = 2
    Visible = False
  end
  object pnlItens: TPanel [5]
    Left = 0
    Top = 477
    Width = 894
    Height = 69
    Align = alClient
    Caption = 'Grid contados'
    ParentColor = True
    TabOrder = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 712
    Top = 144
  end
end
