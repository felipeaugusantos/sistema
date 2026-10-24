inherited frmCtaCadDupDDA: TfrmCtaCadDupDDA
  Width = 1230
  Height = 572
  Caption = 'Cadastrar Duplicatas n'#227'o Identificadas'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1230
  ExplicitHeight = 572
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 501
    Width = 1224
    Height = 26
    ExplicitTop = 495
    ExplicitWidth = 1224
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 1137
      Height = 22
      ExplicitWidth = 1137
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
        Width = 120
        Height = 21
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 1
        OnClick = BtnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 244
        Top = 0
        Width = 120
        Height = 21
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 2
        OnClick = btnDesmarcarTodasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 364
        Top = 0
        Width = 120
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 3
        OnClick = btnConfirmaClick
      end
      object btnGeraCSV: TBitBtnLocked
        Left = 484
        Top = 0
        Width = 133
        Height = 21
        Caption = '[ F12 ] Exportar Arq. CSV'
        TabOrder = 4
        OnClick = btnGeraCSVClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1139
      Top = 2
      Width = 83
      Align = alRight
      ExplicitLeft = 1139
      ExplicitTop = 2
      ExplicitWidth = 83
    end
    object Panel1: TPanel
      Left = 1139
      Top = 2
      Width = 0
      Height = 22
      Align = alRight
      Alignment = taRightJustify
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 527
    Width = 1224
    ExplicitTop = 521
    ExplicitWidth = 1224
    inherited pnlNomeForm: TPanel
      Left = 1053
      ExplicitLeft = 1053
    end
    inherited pnlInfo: TPanel
      Width = 1053
      ExplicitWidth = 1053
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1224
    Height = 501
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
    ExplicitHeight = 495
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 1224
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
      TabOrder = 1
    end
    object pnlAux2: TPanel
      Left = 0
      Top = 22
      Width = 1224
      Height = 479
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      ExplicitHeight = 473
      object pnlTotais: TPanel
        Left = 0
        Top = 382
        Width = 1224
        Height = 97
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        ExplicitTop = 376
        object Label5: TLabel
          Left = 459
          Top = 6
          Width = 39
          Height = 14
          Caption = 'Per'#237'odo:'
        end
        object Label11: TLabel
          Left = 553
          Top = 24
          Width = 6
          Height = 14
          Alignment = taRightJustify
          Caption = 'a'
        end
        object rdgFiltrar: TRadioGroup
          Left = 8
          Top = 6
          Width = 337
          Height = 70
          Caption = 'Filtrar Documentos:'
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            'Com Fornecedor'
            'Sem Fornecedor'
            'Todos')
          TabOrder = 0
        end
        object Panel2: TPanel
          Left = 1215
          Top = 2
          Width = 7
          Height = 93
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
        end
        object pnlCamposTotais: TPanel
          Left = 716
          Top = 2
          Width = 318
          Height = 93
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          object Label9: TLabel
            Left = 107
            Top = 40
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
          object Label21: TLabel
            Left = 115
            Top = 16
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
          object Label17: TLabel
            Left = 0
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
            Left = 2
            Top = 37
            Width = 51
            Height = 18
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
          object edtTotalSelecionado: TEditFocus
            Left = 204
            Top = 37
            Width = 103
            Height = 22
            Alignment = taRightJustify
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          object edtTotalDup: TEditFocus
            Left = 204
            Top = 13
            Width = 103
            Height = 22
            Alignment = taRightJustify
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          object edtQtdDup: TEditFocus
            Left = 56
            Top = 10
            Width = 51
            Height = 22
            Alignment = taRightJustify
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
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
            Left = 56
            Top = 35
            Width = 51
            Height = 22
            Alignment = taRightJustify
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        end
        object gpbLegenda: TGroupBox
          Left = 1034
          Top = 2
          Width = 181
          Height = 93
          Align = alRight
          Caption = 'Legenda'
          TabOrder = 3
          object shp1: TShape
            Left = 8
            Top = 16
            Width = 14
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
            Left = 11
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
          object Label1: TLabel
            Left = 28
            Top = 32
            Width = 135
            Height = 14
            Caption = 'Fornecedor n'#227'o cadastrado'
          end
          object Shape1: TShape
            Left = 8
            Top = 32
            Width = 14
            Height = 14
          end
          object Label2: TLabel
            Left = 11
            Top = 32
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label3: TLabel
            Left = 27
            Top = 48
            Width = 134
            Height = 14
            Caption = 'Com diverg'#234'ncia no n'#250'mero'
          end
          object Shape2: TShape
            Left = 8
            Top = 48
            Width = 14
            Height = 14
          end
          object Label4: TLabel
            Left = 11
            Top = 48
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
          object Label6: TLabel
            Left = 27
            Top = 63
            Width = 129
            Height = 14
            Caption = 'Com duplicata de forn. filial'
          end
          object Shape3: TShape
            Left = 8
            Top = 64
            Width = 14
            Height = 14
          end
          object Label7: TLabel
            Left = 11
            Top = 64
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clOlive
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
        end
        object rdgFiltroData: TRadioGroup
          Left = 356
          Top = 6
          Width = 97
          Height = 70
          Caption = 'Filtrar por Data:'
          ItemIndex = 0
          Items.Strings = (
            'Nenhuma'
            'Emiss'#227'o'
            'Vencimento')
          TabOrder = 4
        end
        object mskDtaIni: TcxDateEdit
          Tag = 99
          Left = 459
          Top = 20
          ParentFont = False
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
          Properties.SaveTime = False
          Properties.ShowTime = False
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 5
          Width = 90
        end
        object mskDtaFin: TcxDateEdit
          Tag = 99
          Left = 564
          Top = 20
          ParentFont = False
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
          Properties.SaveTime = False
          Properties.ShowTime = False
          Properties.ValidateOnEnter = False
          Properties.ValidationOptions = []
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          StyleFocused.Color = clInfoBk
          TabOrder = 6
          Width = 90
        end
        object btnConsultar: TBitBtnLocked
          Left = 654
          Top = 20
          Width = 51
          Height = 24
          Caption = '&Filtrar'
          TabOrder = 7
          TabStop = False
          OnClick = btnConsultarClick
        end
        object grpDataArquivos: TGroupBox
          Left = 459
          Top = 44
          Width = 206
          Height = 45
          Caption = 'Data dos arquivos a partir de'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 8
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
            Left = 103
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
        Width = 1224
        Height = 382
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitHeight = 376
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
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdDuplicDadosDDA_NUMDUP: TcxGridDBColumn
            Caption = 'Duplicata'
            DataBinding.FieldName = 'DDA_DUPCOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 96
          end
          object grdDuplicDadosPARCEL: TcxGridDBColumn
            Caption = 'Parcel.'
            DataBinding.FieldName = 'PARCEL'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 42
          end
          object grdDuplicDadosDDA_CODEMP: TcxGridDBColumn
            Caption = 'C'#243'd. Emp.'
            DataBinding.FieldName = 'DDA_CODEMP'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 55
          end
          object grdDuplicDadosEMP_NOMEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'EMP_NOMEMP'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Width = 234
          end
          object grdDuplicDadosFORNECEDOR: TcxGridDBColumn
            Caption = 'Fornecedor'
            DataBinding.FieldName = 'FORNECEDOR'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Caption = '...'
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            Properties.OnButtonClick = grdDuplicDadosFORNECEDORPropertiesButtonClick
            Options.AutoWidthSizable = False
            Width = 207
          end
          object grdDuplicDadosDDA_DTAEMI: TcxGridDBColumn
            Caption = 'Dta. Emi.'
            DataBinding.FieldName = 'DDA_DTAEMI'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.DisplayFormat = 'dd/mm/yyyy'
            Properties.ReadOnly = True
            Options.Editing = False
          end
          object grdDuplicDadosDDA_DTAVEN: TcxGridDBColumn
            Caption = 'Dta. Venc.'
            DataBinding.FieldName = 'DDA_DTAVEN'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.DisplayFormat = 'dd/mm/yyyy'
            Properties.ReadOnly = True
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 60
          end
          object grdDuplicDadosDDA_VALTIT: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'DDA_VALTIT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 79
          end
          object grdDuplicDadosMARDES: TcxGridDBColumn
            DataBinding.FieldName = 'MARDES'
            Visible = False
            Options.Editing = False
          end
          object grdDuplicDadosFOR_CODCTA: TcxGridDBColumn
            Caption = 'Plano de Contas'
            DataBinding.FieldName = 'FOR_CODCTA'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.AutoWidthSizable = False
            Width = 90
          end
          object grdDuplicDadosPORTADOR: TcxGridDBColumn
            Caption = 'Portador'
            DataBinding.FieldName = 'PORTADOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.AutoWidthSizable = False
            Width = 48
          end
          object grdDuplicDadosEVENTO: TcxGridDBColumn
            Caption = 'Ctr. De Custo'
            DataBinding.FieldName = 'EVENTO'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.AutoWidthSizable = False
            Width = 69
          end
          object grdDuplicDadosHISTORICO: TcxGridDBColumn
            Caption = 'Hist'#243'rico'
            DataBinding.FieldName = 'DDA_HIST01'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.CharCase = ecUpperCase
            OnGetCellHint = grdDuplicDadosHISTORICOGetCellHint
            OnGetPropertiesForEdit = grdDuplicDadosHISTORICOGetPropertiesForEdit
            Options.AutoWidthSizable = False
            Width = 153
          end
          object grdDuplicDadosCEDENTE: TcxGridDBColumn
            Caption = 'Cedente'
            DataBinding.FieldName = 'CEDENTE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.HideSelection = False
            Properties.ReadOnly = True
            Width = 199
          end
          object grdDuplicDadosDDA_CODFOR: TcxGridDBColumn
            DataBinding.FieldName = 'DDA_CODFOR'
            Visible = False
          end
          object grdDuplicDadosVEIOBO: TcxGridDBColumn
            Caption = 'Veio Boleto?'
            DataBinding.FieldName = 'VEIOBO'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            OnGetDisplayText = grdDuplicDadosDEPOSIGetDisplayText
            Options.Editing = False
            Width = 66
          end
          object grdDuplicDadosVEIONF: TcxGridDBColumn
            Caption = 'Veio NF?'
            DataBinding.FieldName = 'VEIONF'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            OnGetDisplayText = grdDuplicDadosDEPOSIGetDisplayText
            Options.Editing = False
            Width = 52
          end
          object grdDuplicDadosUSACHQ: TcxGridDBColumn
            Caption = 'Cheque?'
            DataBinding.FieldName = 'USACHQ'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            OnGetDisplayText = grdDuplicDadosDEPOSIGetDisplayText
            Options.Editing = False
            Width = 49
          end
          object grdDuplicDadosPREVIS: TcxGridDBColumn
            Caption = 'Previs'#227'o?'
            DataBinding.FieldName = 'PREVIS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            OnGetDisplayText = grdDuplicDadosDEPOSIGetDisplayText
            Options.Editing = False
            Width = 53
          end
          object grdDuplicDadosDEPOSI: TcxGridDBColumn
            Caption = 'Dep'#243'sito?'
            DataBinding.FieldName = 'DEPOSI'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            OnGetDisplayText = grdDuplicDadosDEPOSIGetDisplayText
            Options.Editing = False
            Width = 54
          end
          object grdDuplicDadosCTP_NUMDUP: TcxGridDBColumn
            DataBinding.FieldName = 'CTP_NUMDUP'
            Visible = False
          end
          object grdDuplicDadosFOR_CODFOR: TcxGridDBColumn
            DataBinding.FieldName = 'FOR_CODFOR'
            Visible = False
          end
          object grdDuplicDadosACAO: TcxGridDBColumn
            Caption = 'A'#231#227'o'
            DataBinding.FieldName = 'ACAO'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 102
          end
          object grdDuplicDadosATUALIZAHISTORICO: TcxGridDBColumn
            PropertiesClassName = 'TcxBlobEditProperties'
            Properties.OnCloseUp = grdDuplicDadosATUALIZAHISTORICOPropertiesCloseUp
            Visible = False
            Options.Editing = False
            Options.Filtering = False
          end
          object grdDuplicDadosDDA_CNPJ_: TcxGridDBColumn
            DataBinding.FieldName = 'DDA_CNPJ__'
            Visible = False
            Options.Editing = False
            Options.Filtering = False
          end
          object grdDuplicDadosFOR_C_G_C_: TcxGridDBColumn
            DataBinding.FieldName = 'CTPFOR'
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
    Top = 88
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Color = clMenuBar
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -12
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = []
    HintStyle.Rounded = True
    Left = 410
    Top = 192
  end
  object lcl: TcxLocalizer
    StorageType = lstResource
    Left = 592
    Top = 296
  end
end
