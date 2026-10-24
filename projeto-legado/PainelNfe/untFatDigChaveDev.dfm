object frmFatDigChaveDev: TfrmFatDigChaveDev
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Chave NFe '#224' ser devolvida'
  ClientHeight = 399
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 43
    Align = alTop
    TabOrder = 0
    object rdgDocVen: TRadioGroup
      Left = 8
      Top = 1
      Width = 346
      Height = 36
      Caption = 'Doc. de Venda'
      Columns = 4
      ItemIndex = 0
      Items.Strings = (
        'Nota Fiscal'
        'Cupom Fiscal'
        'NFCe'
        'Modelo 1A')
      TabOrder = 0
      OnClick = rdgDocVenClick
    end
  end
  object pnlNF: TPanel
    Left = 0
    Top = 43
    Width = 372
    Height = 98
    Align = alTop
    TabOrder = 1
    object lblTituloNF: TLabel
      Left = 7
      Top = 6
      Width = 192
      Height = 13
      Caption = 'Chave NFe (Nota Fiscal '#224' ser devolvida)'
    end
    object lblObsNF: TLabel
      Left = 7
      Top = 50
      Width = 310
      Height = 36
      Caption = 
        '**'#201' permitido informar somente uma chave de acesso.'#13#10'**A chave d' +
        'a NFe deve referenciar a todos os itens informados'#13#10' nesta devol' +
        'u'#231#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object edtChave: TEditFocus
      Tag = 99
      Left = 7
      Top = 23
      Width = 322
      Height = 21
      Hint = 'Pressione INSERT para inserir um novo cliente'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 46
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 46
      TipoTexto = ttNumerico
    end
  end
  object pnlIF: TPanel
    Left = 0
    Top = 141
    Width = 372
    Height = 126
    Align = alTop
    TabOrder = 2
    object Label3: TLabel
      Left = 23
      Top = 9
      Width = 42
      Height = 13
      Caption = 'N'#186' COO:'
    end
    object Label4: TLabel
      Left = 22
      Top = 33
      Width = 43
      Height = 13
      Caption = 'N'#186' S'#233'rie:'
    end
    object Label5: TLabel
      Left = 6
      Top = 58
      Width = 59
      Height = 13
      Caption = 'C'#243'digo ECF:'
    end
    object Label6: TLabel
      Left = 7
      Top = 77
      Width = 303
      Height = 36
      Caption = 
        '**'#201' permitido informar somente um Cupom de ref'#234'ncia.       **Os ' +
        'itens do Cupom acima devem referenciar todos os itens informados' +
        ' nesta devolu'#231#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object edtNumCOO: TEditFocus
      Tag = 99
      Left = 66
      Top = 7
      Width = 112
      Height = 21
      Alignment = taRightJustify
      MaxLength = 6
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNumSer: TEditFocus
      Tag = 99
      Left = 66
      Top = 31
      Width = 263
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodNSU: TEditFocus
      Tag = 99
      Left = 66
      Top = 55
      Width = 39
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 371
    Width = 372
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 382
    DesignSize = (
      372
      28)
    object btnSair: TBitBtnLocked
      Left = 290
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'C&ancela'
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
      ModalResult = 2
      TabOrder = 1
      OnClick = btnSairClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 75
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
  end
  object pnlMod1A: TPanel
    Left = 0
    Top = 267
    Width = 372
    Height = 103
    Align = alTop
    TabOrder = 3
    object Label1: TLabel
      Left = 182
      Top = 35
      Width = 17
      Height = 13
      Caption = 'UF:'
    end
    object Label2: TLabel
      Left = 170
      Top = 10
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object Label9: TLabel
      Left = 258
      Top = 35
      Width = 46
      Height = 13
      Caption = 'M'#234's/Ano:'
    end
    object Label10: TLabel
      Left = 36
      Top = 35
      Width = 29
      Height = 13
      Caption = 'CNPJ:'
    end
    object Label11: TLabel
      Left = 267
      Top = 12
      Width = 38
      Height = 13
      Caption = 'Modelo:'
    end
    object Label12: TLabel
      Left = 24
      Top = 10
      Width = 41
      Height = 13
      Caption = 'N'#250'mero:'
    end
    object Label7: TLabel
      Left = 7
      Top = 62
      Width = 357
      Height = 35
      Caption = 
        '**'#201' permitido informar somente uma Nota Fiscal (Modelo 1A) de re' +
        'f'#234'ncia. **Os dados acima da Nota devem referenciar a todos os it' +
        'ens informados nesta devolu'#231#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object edtSerA1: TEditFocus
      Tag = 99
      Left = 204
      Top = 5
      Width = 34
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbbEstA1: TComboBoxFocus
      Tag = 99
      Left = 204
      Top = 30
      Width = 41
      Height = 21
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      Items.Strings = (
        'AC'
        'AL'
        'AM'
        'AP'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MG'
        'MS'
        'MT'
        'PA'
        'PB'
        'PE'
        'PI'
        'PR'
        'RJ'
        'RN'
        'RO'
        'RR'
        'RS'
        'SC'
        'SP'
        'TO'
        'SE')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskDatA1: TMaskEditFocus
      Tag = 99
      Left = 307
      Top = 30
      Width = 47
      Height = 21
      EditMask = '!99/9999;1;_'
      MaxLength = 7
      TabOrder = 5
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtModA1: TEditFocus
      Tag = 99
      Left = 307
      Top = 5
      Width = 34
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 2
      Text = '01'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumA1: TEditFocus
      Tag = 99
      Left = 66
      Top = 5
      Width = 62
      Height = 21
      Alignment = taRightJustify
      MaxLength = 9
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 9
      TipoTexto = ttNumerico
    end
    object edtCPFA1: TEditFocus
      Tag = 99
      Left = 66
      Top = 30
      Width = 106
      Height = 21
      Alignment = taRightJustify
      MaxLength = 14
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 14
      TipoTexto = ttNumerico
    end
  end
end
