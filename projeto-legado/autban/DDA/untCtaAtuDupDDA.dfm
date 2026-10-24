inherited frmCtaAtuDupDDA: TfrmCtaAtuDupDDA
  Width = 987
  Height = 542
  BorderStyle = bsNone
  Caption = 'frmCtaAtuDupDDA'
  Position = poMainFormCenter
  ExplicitWidth = 987
  ExplicitHeight = 542
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 500
    Width = 987
    Height = 26
    ExplicitTop = 500
    ExplicitWidth = 987
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 906
      Height = 22
      ExplicitWidth = 906
      ExplicitHeight = 22
      object btnBaixarDDA: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 124
        Height = 21
        Caption = '[ F4 ] Baixa Direta DDA'
        TabOrder = 0
        OnClick = btnBaixarDDAClick
      end
      object BtnMarcarTodas: TBitBtnLocked
        Left = 124
        Top = 0
        Width = 103
        Height = 22
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 1
        OnClick = BtnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 227
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 2
        OnClick = btnDesmarcarTodasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 347
        Top = 0
        Width = 103
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 3
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 908
      Top = 2
      Align = alRight
      ExplicitLeft = 908
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 538
    Width = 987
    ExplicitTop = 526
    ExplicitWidth = 987
    inherited pnlNomeForm: TPanel
      Left = 816
      ExplicitLeft = 816
    end
    inherited pnlInfo: TPanel
      Width = 816
      ExplicitWidth = 816
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 987
    Height = 512
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    ExplicitHeight = 500
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 987
      Height = 22
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Atualiza'#231#227'o de Dados de Duplicatas Encontradas'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object pnlDadosDup: TPanel
      Left = 589
      Top = 22
      Width = 398
      Height = 490
      Align = alRight
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      ExplicitHeight = 478
      object grpArquivo: TGroupBox
        Left = 5
        Top = 0
        Width = 389
        Height = 272
        Caption = 'Dados do Arquivo:'
        TabOrder = 0
        object lblFornecedor: TLabel
          Left = 26
          Top = 21
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cedente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Nome: TLabel
          Left = 16
          Top = 63
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dta. Venc.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 38
          Top = 209
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 7
          Top = 230
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dta. Arquivo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 19
          Top = 42
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'CPF/CNPJ:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 4
          Top = 84
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dta. Emiss'#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 41
          Top = 105
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'T'#237'tulo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 6
          Top = 147
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Lin. Digit'#225'vel:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 26
          Top = 188
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ag'#234'ncia:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 12
          Top = 251
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ocorr'#234'ncia:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 41
          Top = 126
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 8
          Top = 168
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd. Barras:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCedente: TEdit
          Left = 74
          Top = 18
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 0
        end
        object edtDtaVenArq: TEdit
          Left = 74
          Top = 60
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 2
        end
        object edtConta: TEdit
          Left = 74
          Top = 206
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 9
        end
        object edtDtaArq: TEdit
          Left = 74
          Top = 227
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 10
        end
        object edtCNPJArq: TEdit
          Left = 74
          Top = 39
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
        end
        object edtDtaEmiArq: TEdit
          Left = 74
          Top = 81
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
        end
        object edtNumDupArq: TEdit
          Left = 74
          Top = 102
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
        end
        object edtLinDigArq: TEdit
          Left = 74
          Top = 144
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 6
        end
        object edtCodAge: TEdit
          Left = 74
          Top = 185
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 8
        end
        object edtOcorre: TEdit
          Left = 74
          Top = 248
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 11
        end
        object edtValorArq: TEdit
          Left = 74
          Top = 123
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
        end
        object edtCodBarArq: TEdit
          Left = 74
          Top = 165
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 7
        end
      end
      object grpSistema: TGroupBox
        Left = 6
        Top = 278
        Width = 389
        Height = 183
        Caption = 'Dados do Sistema:'
        TabOrder = 1
        object lblCodBar: TLabel
          Left = 23
          Top = 100
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'Duplicata:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblLinDig: TLabel
          Left = 6
          Top = 142
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Lin. Digit'#225'vel:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 17
          Top = 59
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dta. Venc.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblProtesta: TLabel
          Left = 22
          Top = 80
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dta. Cad.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 10
          Top = 17
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
        object Label8: TLabel
          Left = 16
          Top = 38
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'CPF/CNPJ:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 42
          Top = 121
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 8
          Top = 163
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd. Barras:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtFornecedor: TEdit
          Left = 74
          Top = 14
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 0
        end
        object edtNumDupSis: TEdit
          Left = 74
          Top = 97
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
        end
        object edtLinDigSis: TEdit
          Left = 74
          Top = 139
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 6
        end
        object edtDtaVenSis: TEdit
          Left = 74
          Top = 56
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 2
        end
        object edtDtaCadSis: TEdit
          Left = 74
          Top = 77
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
        end
        object edtCNPJSis: TEdit
          Left = 74
          Top = 35
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
        end
        object edtValorSis: TEdit
          Left = 74
          Top = 118
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
        end
        object edtCodBarSis: TEdit
          Left = 74
          Top = 160
          Width = 309
          Height = 19
          AutoSize = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 7
        end
      end
    end
    object pnlAux2: TPanel
      Left = 0
      Top = 22
      Width = 589
      Height = 490
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      ExplicitHeight = 478
      object pnlTotais: TPanel
        Left = 0
        Top = 381
        Width = 589
        Height = 109
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label21: TLabel
          Left = 116
          Top = 14
          Width = 83
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total duplicatas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 108
          Top = 36
          Width = 91
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total Selecionado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 2
          Top = 14
          Width = 53
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Qtde.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 4
          Top = 36
          Width = 51
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Qtde. Sel.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtTotalDup: TEditFocus
          Left = 201
          Top = 10
          Width = 99
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtTotalSelecionado: TEditFocus
          Left = 201
          Top = 33
          Width = 99
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object gpbLegenda: TGroupBox
          Left = 306
          Top = 6
          Width = 165
          Height = 51
          Caption = 'Legenda'
          TabOrder = 2
          object shp1: TShape
            Left = 8
            Top = 16
            Width = 15
            Height = 14
          end
          object lbl1: TLabel
            Left = 27
            Top = 16
            Width = 65
            Height = 14
            Caption = 'Selecionadas'
          end
          object lbl3: TLabel
            Left = 12
            Top = 16
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Shape1: TShape
            Left = 8
            Top = 32
            Width = 15
            Height = 14
          end
          object Label15: TLabel
            Left = 27
            Top = 32
            Width = 134
            Height = 14
            Caption = 'Com diverg'#234'ncia no n'#250'mero'
          end
          object Label16: TLabel
            Left = 12
            Top = 32
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
        end
        object edtQtdDup: TEditFocus
          Left = 58
          Top = 10
          Width = 51
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtSelDup: TEditFocus
          Left = 58
          Top = 33
          Width = 51
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object rdgFiltrar: TRadioGroup
          Left = 473
          Top = 5
          Width = 111
          Height = 69
          Caption = 'Filtrar:'
          ItemIndex = 0
          Items.Strings = (
            'Todos'
            'Conciliados'
            'Divergentes')
          TabOrder = 5
          OnClick = rdgFiltrarClick
        end
        object grpDataArquivos: TGroupBox
          Left = 8
          Top = 57
          Width = 209
          Height = 45
          Caption = 'Data dos arquivos a partir de'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          object edtDataInicial: TcxDateEdit
            Tag = 99
            Left = 7
            Top = 16
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
            TabOrder = 0
            Width = 90
          end
          object btnReprocessar: TBitBtnLocked
            Left = 105
            Top = 16
            Width = 93
            Height = 24
            Caption = 'Reprocessar'
            TabOrder = 1
            TabStop = False
            OnClick = btnReprocessarClick
          end
        end
      end
      object grdDuplic: TcxGridCitel
        Left = 0
        Top = 0
        Width = 589
        Height = 381
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitHeight = 397
        object grdDuplicDados: TcxGridDBTableViewCitel
          OnDblClick = grdDuplicDadosDblClick
          OnKeyDown = grdDuplicDadosKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdDuplicDadosCustomDrawCell
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdDuplicDadosDDA_NUMDUP: TcxGridDBColumn
            Caption = 'Duplicata'
            DataBinding.FieldName = 'CTP_NUMDUP'
            Width = 96
          end
          object grdDuplicDadosCTP_PARCEL: TcxGridDBColumn
            Caption = 'Parcel.'
            DataBinding.FieldName = 'CTP_PARCEL'
            Width = 42
          end
          object grdDuplicDadosDDA_CODEMP: TcxGridDBColumn
            Caption = 'C'#243'd. Emp.'
            DataBinding.FieldName = 'CTP_CODEMP'
            Width = 55
          end
          object grdDuplicDadosCTP_CODFOR: TcxGridDBColumn
            Caption = 'C'#243'd. For.'
            DataBinding.FieldName = 'CTP_CODFOR'
            Width = 58
          end
          object grdDuplicDadosDDA_DTAVEN: TcxGridDBColumn
            Caption = 'Dta. Venc.'
            DataBinding.FieldName = 'DDA_DTAVEN'
            Width = 60
          end
          object grdDuplicDadosDDA_DTAEMI: TcxGridDBColumn
            Caption = 'Dta. Emi.'
            DataBinding.FieldName = 'DDA_DTAEMI'
            Width = 67
          end
          object grdDuplicDadosDDA_VALTIT: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'DDA_VALTIT'
            HeaderAlignmentHorz = taRightJustify
            Width = 79
          end
          object grdDuplicDadosMARDES: TcxGridDBColumn
            DataBinding.FieldName = 'MARDES'
            Visible = False
          end
          object grdDuplicDadosDDA_DUPCOR: TcxGridDBColumn
            DataBinding.FieldName = 'DDA_DUPCOR'
            Visible = False
          end
          object grdDuplicDadosDDA_AUTCTP: TcxGridDBColumn
            DataBinding.FieldName = 'DDA_AUTCTP'
            Visible = False
          end
          object grdDuplicDadosACAO: TcxGridDBColumn
            Caption = 'A'#231#227'o'
            DataBinding.FieldName = 'ACAO'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 97
          end
          object grdDuplicDadosDIVERGENCIA: TcxGridDBColumn
            DataBinding.FieldName = 'DIVERGENCIA'
            Visible = False
            Options.Editing = False
            Options.Filtering = False
          end
        end
        object grdDuplicNivel: TcxGridLevel
          GridView = grdDuplicDados
        end
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 40
  end
end
