inherited frmRelCtpAnaDebitos: TfrmRelCtpAnaDebitos
  Left = 369
  Top = 156
  Width = 623
  Height = 595
  Caption = 'Relat'#243'rio de T'#237'tulos a Pagar'
  OnDestroy = FormDestroy
  ExplicitWidth = 623
  ExplicitHeight = 595
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 523
    Width = 617
    ExplicitTop = 523
    ExplicitWidth = 617
    inherited btnSair: TBitBtnLocked
      Left = 534
      ExplicitLeft = 534
    end
    inherited btnConfigurar: TBitBtnLocked
      Width = 83
      ExplicitWidth = 83
    end
  end
  inherited pnlDados: TPanel
    Width = 617
    Height = 523
    ExplicitWidth = 617
    ExplicitHeight = 523
    object Label5: TLabel [0]
      Left = 8
      Top = 37
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [1]
      Left = 190
      Top = 37
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [2]
      Left = 100
      Top = 55
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [3]
      Left = 282
      Top = 55
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [4]
      Left = 8
      Top = 74
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [5]
      Left = 8
      Top = 180
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [6]
      Left = 8
      Top = 144
      Width = 33
      Height = 14
      Caption = 'Evento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [7]
      Left = 8
      Top = 216
      Width = 78
      Height = 14
      Caption = 'Plano de Contas'
    end
    object Label3: TLabel [8]
      Left = 8
      Top = 110
      Width = 45
      Height = 14
      Caption = 'Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblPortador: TLabel [9]
      Left = 8
      Top = 253
      Width = 41
      Height = 14
      Caption = 'Portador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [10]
      Left = 8
      Top = 0
      Width = 62
      Height = 14
      Caption = 'Compet'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 433
      Top = 245
      Width = 176
      TabOrder = 14
      ExplicitLeft = 433
      ExplicitTop = 245
      ExplicitWidth = 176
      inherited ColorLabel1: TColorLabel
        Left = 30
        Width = 36
        Caption = '(V)'#237'deo'
        ExplicitLeft = 30
        ExplicitWidth = 36
      end
      object ColorLabel9: TColorLabel [1]
        Left = 69
        Top = 20
        Width = 62
        Height = 14
        Caption = '(I)mpressora'
        CorDestaque = clRed
      end
      object ColorLabel10: TColorLabel [2]
        Left = 136
        Top = 20
        Width = 34
        Height = 14
        Caption = '(E)xcel'
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Left = 8
        ExplicitLeft = 8
      end
    end
    object edtCodFornecedor: TEditFocus
      Left = 8
      Top = 88
      Width = 62
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodFornecedorExit
      OnKeyPress = edtCodFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 194
      Width = 62
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 6
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 71
      Top = 88
      Width = 356
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 25
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 71
      Top = 194
      Width = 356
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEve: TEditFocus
      Left = 8
      Top = 158
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 5
      OnExit = edtCodEveExit
      OnKeyPress = edtCodEveKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesEve: TEditFocus
      Left = 71
      Top = 158
      Width = 356
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 27
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCodCta: TMaskEditFocus
      Left = 8
      Top = 230
      Width = 62
      Height = 22
      EditMask = '99.99.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 7
      Text = ''
      OnExit = mskCodCtaExit
      OnKeyPress = mskCodCtaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesCta: TEditFocus
      Left = 71
      Top = 230
      Width = 356
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 28
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbOpcao: TGroupBox
      Left = 8
      Top = 327
      Width = 289
      Height = 83
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      object cbxOpcao: TComboBox
        Left = 6
        Top = 16
        Width = 272
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemIndex = 0
        TabOrder = 0
        Text = 'Anal'#237'tico por Atividade'
        OnChange = cbxOpcaoChange
        Items.Strings = (
          'Anal'#237'tico por Atividade'
          'Anal'#237'tico por Data de Vencimento'
          'Anal'#237'tico por Evento'
          'Anal'#237'tico por Fornecedor'
          'Anal'#237'tico por Portador'
          'S'#237'nt'#233'tico por Data de Vencimento'
          'Sint'#233'tico por Fornecedor')
      end
      object chkListaDesmembramento: TCheckBox
        Left = 8
        Top = 61
        Width = 138
        Height = 17
        Caption = 'Listar desmembramentos'
        TabOrder = 2
        OnClick = chkNExiCreditosClick
      end
      object chkNovaPaginaQuebra: TCheckBox
        Left = 8
        Top = 42
        Width = 209
        Height = 17
        Caption = 'Imprimir nova p'#225'gina em cada quebra'
        TabOrder = 1
        OnClick = chkNExiCreditosClick
      end
    end
    object chkResumoEmpresa: TCheckBox
      Left = 8
      Top = 292
      Width = 195
      Height = 17
      Caption = 'Imprimir Resumo por Empresa'
      TabOrder = 15
    end
    object chkAjuDta: TCheckBox
      Left = 8
      Top = 311
      Width = 346
      Height = 17
      Caption = 'Ajustar vencimentos considerando S'#225'bados, Domingos e Feriados'
      TabOrder = 18
    end
    object edtCodAtv: TEditFocus
      Left = 8
      Top = 125
      Width = 62
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodAtvExit
      OnKeyPress = edtCodAtvKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAtv: TEditFocus
      Left = 71
      Top = 124
      Width = 356
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 29
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesPortador: TEditFocus
      Left = 71
      Top = 267
      Width = 357
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 30
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 8
      Top = 267
      Width = 62
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 8
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object chkExiCreditos: TCheckBox
      Left = 242
      Top = 292
      Width = 138
      Height = 17
      Caption = 'Exibir somente cr'#233'ditos'
      TabOrder = 16
      OnClick = chkExiCreditosClick
    end
    object chkNExiCreditos: TCheckBox
      Left = 471
      Top = 292
      Width = 138
      Height = 17
      Caption = 'N'#227'o exibir cr'#233'ditos'
      TabOrder = 17
      OnClick = chkNExiCreditosClick
    end
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 14
      Width = 62
      Height = 22
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object gpbVeioNF: TRadioGroup
      Left = 433
      Top = 7
      Width = 176
      Height = 45
      Caption = 'Veio NF ?'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Sim'
        'N'#227'o')
      TabOrder = 9
    end
    object rdgBoleto: TRadioGroup
      Left = 433
      Top = 54
      Width = 176
      Height = 45
      Caption = 'Veio Boleto ?'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Sim'
        'N'#227'o')
      TabOrder = 10
    end
    object rdgDeposito: TRadioGroup
      Left = 433
      Top = 101
      Width = 176
      Height = 45
      Caption = 'Dep'#243'sito ?'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Sim'
        'N'#227'o')
      TabOrder = 11
    end
    object rdgCheque: TRadioGroup
      Left = 433
      Top = 148
      Width = 176
      Height = 45
      Caption = 'Cheque ?'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Sim'
        'N'#227'o')
      TabOrder = 12
    end
    object rdgForFil: TRadioGroup
      Left = 433
      Top = 196
      Width = 176
      Height = 45
      Caption = 'Fornecedor filial ?'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Sim'
        'N'#227'o')
      TabOrder = 13
    end
    object rdgOrdem: TRadioGroup
      Left = 308
      Top = 327
      Width = 301
      Height = 83
      Caption = 'Ordem Sint'#233'tico por Fornecedor'
      ItemIndex = 0
      Items.Strings = (
        'Nome Fornecedor'
        'C'#243'd. Fornecedor')
      TabOrder = 20
    end
    object rdgOrdemAnalitico: TRadioGroup
      Left = 8
      Top = 418
      Width = 289
      Height = 45
      Caption = 'Ordem Anal'#237'tico'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Nome Fornec.'
        'C'#243'd. Fornec.'
        'Duplicata')
      TabOrder = 21
    end
    object rdgIncPrevis: TRadioGroup
      Left = 308
      Top = 418
      Width = 301
      Height = 45
      Caption = 'Gerar apenas'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Previs'#245'es'
        'Sem Previs'#245'es'
        'Todos')
      TabOrder = 22
    end
    object rdgValorASerExibido: TRadioGroup
      Left = 8
      Top = 472
      Width = 289
      Height = 45
      Caption = 'Valor a ser exibido'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Valor L'#237'quido'
        'Valor Bruto')
      TabOrder = 23
    end
    object rdgImpHistCmp: TRadioGroup
      Left = 308
      Top = 472
      Width = 301
      Height = 45
      Caption = 'Imprimir Hist'#243'rico Completo ?'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 24
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 8
      Top = 50
      Properties.ButtonGlyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000020000
        000A000000100000001100000011000000110000001200000012000000120000
        0012000000120000001300000013000000120000000C000000030000000A8159
        4CC2B47C69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB279
        68FFB27967FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F
        6EFFFBF8F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7ED
        E6FFF6EDE6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB984
        72FFFBF8F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDC
        D4FFBA9283FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC89
        78FFFCFAF8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EF
        EAFFEBDDD5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E
        7DFFFCFAF9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1
        ECFFBE9786FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC394
        82FFFCFAFAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2
        EEFFEDDFD9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC798
        87FFFDFBFAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5
        F1FFC19B8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D
        8CFFFDFCFCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6
        F3FFEEE2DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA1
        90FFFEFCFCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7
        F6FFC49F91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA5
        94FFFEFCFCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9
        F7FFFCF9F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53
        C3FF8D9EECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69
        DCFF5966DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55
        C4FF93A4EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6F
        DEFF5C6CDDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56
        C6FF96A7EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595
        EAFF8291E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A40
        93C14D55C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046
        B7FF3E44B4FF3C41B3FF3A3EB0FF393CAEFF282B80C200000006000000010000
        0004000000060000000600000006000000070000000700000007000000070000
        0007000000070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 186
      Top = 50
      Properties.ButtonGlyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000020000
        000A000000100000001100000011000000110000001200000012000000120000
        0012000000120000001300000013000000120000000C000000030000000A8159
        4CC2B47C69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB279
        68FFB27967FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F
        6EFFFBF8F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7ED
        E6FFF6EDE6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB984
        72FFFBF8F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDC
        D4FFBA9283FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC89
        78FFFCFAF8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EF
        EAFFEBDDD5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E
        7DFFFCFAF9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1
        ECFFBE9786FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC394
        82FFFCFAFAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2
        EEFFEDDFD9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC798
        87FFFDFBFAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5
        F1FFC19B8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D
        8CFFFDFCFCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6
        F3FFEEE2DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA1
        90FFFEFCFCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7
        F6FFC49F91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA5
        94FFFEFCFCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9
        F7FFFCF9F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53
        C3FF8D9EECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69
        DCFF5966DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55
        C4FF93A4EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6F
        DEFF5C6CDDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56
        C6FF96A7EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595
        EAFF8291E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A40
        93C14D55C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046
        B7FF3E44B4FF3C41B3FF3A3EB0FF393CAEFF282B80C200000006000000010000
        0004000000060000000600000006000000070000000700000007000000070000
        0007000000070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      Width = 90
    end
  end
  inherited pnlStatus: TPanel
    Top = 551
    Width = 617
    ExplicitTop = 551
    ExplicitWidth = 617
    inherited pnlNomeForm: TPanel
      Left = 467
      Width = 150
      ExplicitLeft = 467
      ExplicitWidth = 150
    end
    inherited pnlInfo: TPanel
      Width = 467
      ExplicitWidth = 467
      inherited shpMultSel: TShape
        Left = 229
        ExplicitLeft = 229
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 152
    Top = 216
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 120
    Top = 248
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 216
    Top = 216
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 184
    Top = 216
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 312
    Top = 248
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 280
    Top = 248
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 248
    Top = 248
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 184
    Top = 248
  end
  inherited frxGen: TfrxUserDataSet
    Left = 216
    Top = 248
  end
  inherited frxDesigner: TfrxDesigner
    Left = 280
    Top = 216
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 312
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 120
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 248
    Top = 216
  end
  object svdExcel: TSaveDialog
    Filter = 'Planilha Excel|*.xls'
    Left = 152
    Top = 248
  end
  object dtsRelatorio: TDataSource
    Left = 384
    Top = 216
  end
end
