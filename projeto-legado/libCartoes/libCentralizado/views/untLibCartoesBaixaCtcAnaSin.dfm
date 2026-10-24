inherited frmLibCartoesBaixaCtcAnaSin: TfrmLibCartoesBaixaCtcAnaSin
  Left = 323
  Top = 233
  Width = 520
  Height = 436
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poScreenCenter
  ExplicitWidth = 520
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 363
    Width = 514
    ExplicitTop = 363
    ExplicitWidth = 514
    DesignSize = (
      514
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 510
      ExplicitWidth = 510
    end
    inherited btnSair: TBitBtnLocked
      Left = 346
      ExplicitLeft = 346
    end
  end
  inherited pnlStatus: TPanel
    Top = 391
    Width = 514
    TabOrder = 3
    ExplicitTop = 391
    ExplicitWidth = 514
    inherited pnlNomeForm: TPanel
      Left = 332
      Width = 182
      ExplicitLeft = 332
      ExplicitWidth = 182
    end
    inherited pnlInfo: TPanel
      Width = 332
      ExplicitWidth = 332
    end
  end
  inherited pgcDados: TPageControl
    Width = 514
    Height = 363
    TabOrder = 1
    Visible = False
    ExplicitWidth = 514
    ExplicitHeight = 363
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 506
      ExplicitHeight = 331
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 363
    Width = 514
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 4
    DesignSize = (
      514
      28)
    object btnConfirmaDados: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
      OnClick = btnConfirmaDadosClick
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 431
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = 'C&ancelar'
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
      OnClick = btnCancelaDadosClick
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 514
    Height = 363
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 510
      Height = 183
      Align = alTop
      BevelInner = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label4: TLabel
        Left = 26
        Top = 90
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador Taxa:'
      end
      object Label1: TLabel
        Left = 17
        Top = 24
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador Cart'#227'o:'
      end
      object Label3: TLabel
        Left = 9
        Top = 112
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor Taxa:'
      end
      object Label6: TLabel
        Left = 2
        Top = 2
        Width = 506
        Height = 14
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'CR'#201'DITO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 3
        ExplicitWidth = 426
      end
      object edtDesPorTax: TEditFocus
        Left = 165
        Top = 87
        Width = 334
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
      object edtDesPorCar: TEditFocus
        Left = 165
        Top = 21
        Width = 334
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
      object edtPorTax: TEditFocus
        Tag = 99
        Left = 98
        Top = 87
        Width = 67
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 3
        OnKeyPress = edtPorTaxKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtPorCar: TEditFocus
        Tag = 99
        Left = 98
        Top = 21
        Width = 67
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtPorCarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesCodFor: TEditFocus
        Left = 165
        Top = 109
        Width = 334
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 98
        Top = 109
        Width = 67
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 8
        TabOrder = 4
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      inline fraCentroCustoCartaoC: TfraCentroCustoEditFocus
        Left = 4
        Top = 65
        Width = 501
        Height = 22
        TabOrder = 2
        ExplicitLeft = 4
        ExplicitTop = 65
        ExplicitWidth = 501
        inherited lblEventos: TLabel
          Left = 1
          Width = 91
          Height = 14
          Caption = 'Ctr. Custos Cart'#227'o:'
          ExplicitLeft = 1
          ExplicitWidth = 91
          ExplicitHeight = 14
        end
        inherited edtCodEve: TEditFocus
          Width = 67
          Height = 22
          ExplicitWidth = 67
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Left = 161
          Width = 334
          Height = 22
          ExplicitLeft = 161
          ExplicitWidth = 334
          ExplicitHeight = 22
        end
      end
      inline fraCentroCustoTaxaC: TfraCentroCustoEditFocus
        Left = 4
        Top = 153
        Width = 501
        Height = 22
        TabOrder = 9
        ExplicitLeft = 4
        ExplicitTop = 153
        ExplicitWidth = 501
        inherited lblEventos: TLabel
          Left = 10
          Width = 82
          Height = 14
          Caption = 'Ctr. Custos Taxa:'
          ExplicitLeft = 10
          ExplicitWidth = 82
          ExplicitHeight = 14
        end
        inherited edtCodEve: TEditFocus
          Width = 67
          Height = 22
          ExplicitWidth = 67
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Left = 161
          Width = 334
          Height = 22
          ExplicitLeft = 161
          ExplicitWidth = 334
          ExplicitHeight = 22
        end
      end
      inline fraPlanoDeContasCar: TfraPlanoDeContasMskEdit
        Left = 5
        Top = 43
        Width = 497
        Height = 22
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        ExplicitLeft = 5
        ExplicitTop = 43
        ExplicitWidth = 497
        inherited lblPlaContas: TLabel
          Top = 5
          Width = 86
          Height = 14
          Caption = 'Pl. Contas Cart'#227'o:'
          ExplicitTop = 5
          ExplicitWidth = 86
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 160
          Width = 334
          Height = 22
          ExplicitLeft = 160
          ExplicitWidth = 334
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 93
          Width = 67
          Height = 22
          OnKeyPress = fraPlanoDeContasCarMskCodCtaKeyPress
          ExplicitLeft = 93
          ExplicitWidth = 67
          ExplicitHeight = 22
        end
      end
      inline fraPlanoDeContasTax: TfraPlanoDeContasMskEdit
        Left = 13
        Top = 131
        Width = 489
        Height = 22
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 5
        ExplicitLeft = 13
        ExplicitTop = 131
        ExplicitWidth = 489
        inherited lblPlaContas: TLabel
          Left = 4
          Width = 77
          Height = 14
          Caption = 'Pl. Contas Taxa:'
          ExplicitLeft = 4
          ExplicitWidth = 77
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 152
          Width = 334
          Height = 22
          ExplicitLeft = 152
          ExplicitWidth = 334
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Width = 67
          Height = 22
          OnKeyPress = fraPlanoDeContasTaxMskCodCtaKeyPress
          ExplicitWidth = 67
          ExplicitHeight = 22
        end
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 185
      Width = 510
      Height = 92
      Align = alTop
      BevelInner = bvLowered
      Color = 16770261
      TabOrder = 1
      object Label7: TLabel
        Left = 2
        Top = 2
        Width = 506
        Height = 14
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'D'#201'BITO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 3
        ExplicitWidth = 426
      end
      object Label8: TLabel
        Left = 17
        Top = 23
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador Cart'#227'o:'
      end
      object edtPorDeb: TEditFocus
        Tag = 99
        Left = 98
        Top = 20
        Width = 67
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnChange = edtPorDebChange
        OnKeyPress = edtPorDebKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesPorDeb: TEditFocus
        Left = 165
        Top = 20
        Width = 334
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
      inline fraCentroCustoCartaoD: TfraCentroCustoEditFocus
        Left = 4
        Top = 64
        Width = 501
        Height = 22
        TabOrder = 3
        ExplicitLeft = 4
        ExplicitTop = 64
        ExplicitWidth = 501
        inherited lblEventos: TLabel
          Left = 1
          Width = 91
          Height = 14
          Caption = 'Ctr. Custos Cart'#227'o:'
          ExplicitLeft = 1
          ExplicitWidth = 91
          ExplicitHeight = 14
        end
        inherited edtCodEve: TEditFocus
          Width = 67
          Height = 22
          ExplicitWidth = 67
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Left = 161
          Width = 334
          Height = 22
          ExplicitLeft = 161
          ExplicitWidth = 334
          ExplicitHeight = 22
        end
      end
      inline fraPlanoDeContasDeb: TfraPlanoDeContasMskEdit
        Left = 6
        Top = 42
        Width = 495
        Height = 22
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        ExplicitLeft = 6
        ExplicitTop = 42
        ExplicitWidth = 495
        inherited lblPlaContas: TLabel
          Width = 86
          Height = 14
          Caption = 'Pl. Contas Cart'#227'o:'
          ExplicitWidth = 86
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 159
          Width = 334
          Height = 22
          ExplicitLeft = 159
          ExplicitWidth = 334
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 92
          Width = 67
          Height = 22
          OnKeyPress = fraPlanoDeContasDebMskCodCtaKeyPress
          ExplicitLeft = 92
          ExplicitWidth = 67
          ExplicitHeight = 22
        end
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 277
      Width = 510
      Height = 84
      Align = alClient
      BevelInner = bvLowered
      Color = 16770261
      TabOrder = 2
      object Label10: TLabel
        Left = 51
        Top = 58
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label11: TLabel
        Left = 39
        Top = 36
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object Label12: TLabel
        Left = 71
        Top = 13
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data:'
      end
      object edtHistor: TEditFocus
        Tag = 99
        Left = 98
        Top = 55
        Width = 399
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 98
        Top = 33
        Width = 97
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 13
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object mskDtaDoc: TcxDateEdit
        Tag = 99
        Left = 98
        Top = 9
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
        Width = 97
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 65528
  end
end
