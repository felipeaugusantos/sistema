inherited frmFatDigDesconto: TfrmFatDigDesconto
  Left = 369
  Top = 225
  Width = 638
  Height = 598
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de Desconto Especial'
  Position = poMainFormCenter
  ExplicitWidth = 638
  ExplicitHeight = 598
  PixelsPerInch = 96
  TextHeight = 14
  object Bevel1: TBevel [0]
    Left = 315
    Top = 0
    Width = 2
    Height = 529
    Align = alLeft
    Shape = bsLeftLine
    ExplicitLeft = 353
    ExplicitHeight = 468
  end
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 632
    TabOrder = 3
    ExplicitTop = 529
    ExplicitWidth = 632
    DesignSize = (
      632
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 628
      ExplicitWidth = 628
    end
    inherited btnSair: TBitBtnLocked
      Left = 164
      ExplicitLeft = 164
    end
  end
  inherited pnlStatus: TPanel
    Top = 553
    Width = 632
    TabOrder = 4
    ExplicitTop = 488
    ExplicitWidth = 632
    inherited pnlNomeForm: TPanel
      Left = 496
      Width = 136
      ExplicitLeft = 496
      ExplicitWidth = 136
    end
    inherited pnlInfo: TPanel
      Width = 496
      ExplicitWidth = 496
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 2
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlConfirma: TPanel [4]
    Left = 0
    Top = 529
    Width = 632
    Height = 24
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 5
    ExplicitTop = 478
    object btnCancelaDados: TBitBtnLocked
      Left = 553
      Top = 2
      Width = 77
      Height = 20
      Align = alRight
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
      TabOrder = 2
      OnClick = btnCancelaClick
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 20
      Align = alLeft
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
    object btnMostraMargem: TBitBtnLocked
      Left = 79
      Top = 2
      Width = 111
      Height = 20
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = '[F4] Margem/Lucro'
      TabOrder = 1
      Visible = False
      OnClick = btnMostraMargemClick
    end
  end
  object pnlEsquerda: TPanel [5]
    Left = 0
    Top = 0
    Width = 315
    Height = 529
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    ExplicitHeight = 478
    object pnlCupomDesconto: TPanel
      Left = 0
      Top = 0
      Width = 315
      Height = 39
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label14: TLabel
        Left = 75
        Top = 13
        Width = 115
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cupom de Desconto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape10: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 311
      end
      object Shape11: TShape
        Left = 0
        Top = 1
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 311
      end
      object edtCupDes: TEditFocus
        Tag = 99
        Left = 196
        Top = 9
        Width = 95
        Height = 22
        Alignment = taCenter
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        OnChange = edtCupDesChange
        OnEnter = edtPorDesEnter
        OnExit = edtPorDesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlSubTotProd: TPanel
      Left = 0
      Top = 333
      Width = 315
      Height = 56
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      object lblSubTotProd: TLabel
        Left = 59
        Top = 14
        Width = 131
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sub Total dos Produtos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape4: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 328
      end
      object lblVlrMinTotalProdutos: TLabel
        Left = 37
        Top = 35
        Width = 153
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor m'#237'nimo total dos produtos:'
      end
      object edtSubTotProd: TEditFocus
        Left = 196
        Top = 8
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtVlrMinTotalProdutos: TEditFocus
        Left = 196
        Top = 31
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlTotalBruto: TPanel
      Left = 0
      Top = 39
      Width = 315
      Height = 39
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object lblTotalBruto: TLabel
        Left = 19
        Top = 12
        Width = 171
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total Bruto dos Produtos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape9: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 311
      end
      object edtTotalBruto: TEditFocus
        Left = 196
        Top = 8
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlTotalComPromocao: TPanel
      Left = 0
      Top = 78
      Width = 315
      Height = 127
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      DesignSize = (
        315
        127)
      object lblTotalComPromocao: TLabel
        Left = 70
        Top = 11
        Width = 120
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produtos com Promo'#231#227'o:'
      end
      object lblValorDescPromocao: TLabel
        Left = 29
        Top = 58
        Width = 161
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total desconto(s) com Promo'#231#227'o:'
      end
      object lblPercDescPromocao: TLabel
        Left = 33
        Top = 34
        Width = 157
        Height = 14
        Alignment = taRightJustify
        Caption = '(%) desconto(s) com Promo'#231#227'o:'
      end
      object lblVlrLiqComPromocao: TLabel
        Left = 9
        Top = 82
        Width = 181
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor l'#237'quido produtos com Promo'#231#227'o:'
      end
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 328
      end
      object lblVlrMinComPromocao: TLabel
        Left = 7
        Top = 105
        Width = 183
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Caption = 'Valor m'#237'nimo produtos com Promo'#231#227'o:'
      end
      object edtTotalComPromocao: TEditFocus
        Left = 196
        Top = 7
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtValorDescPromocao: TEditFocus
        Left = 196
        Top = 53
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtPercDescPromocao: TEditFocus
        Left = 196
        Top = 30
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtVlrLiqComPromocao: TEditFocus
        Left = 196
        Top = 76
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtVlrMinComPromocao: TEditFocus
        Left = 196
        Top = 99
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlTotalSemPromocao: TPanel
      Left = 0
      Top = 205
      Width = 315
      Height = 128
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      DesignSize = (
        315
        128)
      object lblTotalSemPromocao: TLabel
        Left = 70
        Top = 14
        Width = 120
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produtos sem Promo'#231#227'o:'
      end
      object lblPercDescSemPromocao: TLabel
        Left = 33
        Top = 35
        Width = 157
        Height = 14
        Alignment = taRightJustify
        Caption = '(%) desconto(s) sem Promo'#231#227'o:'
      end
      object lblValorDescSemPromocao: TLabel
        Left = 29
        Top = 59
        Width = 161
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total desconto(s) sem Promo'#231#227'o:'
      end
      object lblVlrLiqSemPromocao: TLabel
        Left = 9
        Top = 82
        Width = 181
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor l'#237'quido produtos sem Promo'#231#227'o:'
      end
      object Shape3: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 328
      end
      object lblVlrMinSemPromocao: TLabel
        Left = 7
        Top = 106
        Width = 183
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Caption = 'Valor m'#237'nimo produtos sem Promo'#231#227'o:'
      end
      object edtTotalSemPromocao: TEditFocus
        Left = 196
        Top = 8
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtPercDescSemPromocao: TEditFocus
        Left = 196
        Top = 31
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtValorDescSemPromocao: TEditFocus
        Left = 196
        Top = 54
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtVlrLiqSemPromocao: TEditFocus
        Left = 196
        Top = 77
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtVlrMinSemPromocao: TEditFocus
        Left = 196
        Top = 100
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  object pnlDireita: TPanel [6]
    Left = 317
    Top = 0
    Width = 315
    Height = 529
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    ExplicitHeight = 478
    object pnlDigDescontos: TPanel
      Left = 0
      Top = 87
      Width = 315
      Height = 95
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Label2: TLabel
        Left = 105
        Top = 5
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Caption = '(%) de Desconto:'
      end
      object Label4: TLabel
        Left = 98
        Top = 53
        Width = 92
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto Especial:'
      end
      object Label9: TLabel
        Left = 101
        Top = 29
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total do Desconto:'
      end
      object lblDesCsh: TLabel
        Left = 93
        Top = 77
        Width = 97
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto Cashback'
      end
      object edtPorDes: TEditFocus
        Tag = 99
        Left = 196
        Top = 1
        Width = 95
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnEnter = edtPorDesEnter
        OnExit = edtPorDesExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesEsp: TEditFocus
        Tag = 99
        Left = 196
        Top = 49
        Width = 95
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnEnter = edtDesEspEnter
        OnExit = edtDesEspExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotDesPer: TEditFocus
        Tag = 99
        Left = 196
        Top = 25
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        OnEnter = edtPorDesEnter
        OnExit = edtPorDesExit
        NormalColor = clWindow
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesCsh: TEditFocus
        Tag = 99
        Left = 196
        Top = 73
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        OnEnter = edtPorDesEnter
        OnExit = edtPorDesExit
        NormalColor = clWindow
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlInfDescSemPromocao: TPanel
      Left = 0
      Top = 0
      Width = 315
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblInfDescSemPromocao: TLabel
        Left = 0
        Top = 1
        Width = 315
        Height = 20
        Align = alClient
        Alignment = taCenter
        Caption = 'Digita'#231#227'o descontos (somente produtos s/ promo'#231#227'o)'
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 298
        ExplicitHeight = 14
      end
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitWidth = 328
      end
    end
    object pnlStIpi: TPanel
      Left = 0
      Top = 348
      Width = 315
      Height = 167
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 9
      object Label11: TLabel
        Left = 17
        Top = 5
        Width = 173
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor da Substitui'#231#227'o Tribut'#225'ria:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 126
        Top = 51
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do IPI:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValFcpSt: TLabel
        Left = 21
        Top = 28
        Width = 169
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do Fundo de combate ST:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtValSbt: TEditFocus
        Left = 196
        Top = 1
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtValIPI: TEditFocus
        Left = 196
        Top = 47
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtValFcpSt: TEditFocus
        Left = 196
        Top = 24
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object pnlImpostosReforma: TPanel
        Left = -1
        Top = 70
        Width = 316
        Height = 70
        BevelOuter = bvNone
        TabOrder = 3
        object Label15: TLabel
          Left = 166
          Top = 5
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'CBS:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 178
          Top = 51
          Width = 13
          Height = 14
          Alignment = taRightJustify
          Caption = 'IS:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 171
          Top = 28
          Width = 20
          Height = 14
          Alignment = taRightJustify
          Caption = 'IBS:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtTotCBS: TEditFocus
          Left = 197
          Top = 1
          Width = 95
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtTotIS: TEditFocus
          Left = 197
          Top = 47
          Width = 95
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtTotIBS: TEditFocus
          Left = 197
          Top = 24
          Width = 95
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
      end
      object pnlTotalDaVenda: TPanel
        Left = 0
        Top = 140
        Width = 315
        Height = 27
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 4
        ExplicitLeft = 4
        ExplicitTop = 138
        object Label13: TLabel
          Left = 77
          Top = 9
          Width = 113
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Total da Venda:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtTotVen: TEditFocus
          Left = 196
          Top = 1
          Width = 95
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
      end
    end
    object pnlTotalDescontos: TPanel
      Left = 0
      Top = 269
      Width = 315
      Height = 55
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 7
      object Label8: TLabel
        Left = 60
        Top = 29
        Width = 130
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total dos descontos (-):'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 62
        Top = 5
        Width = 128
        Height = 14
        Alignment = taRightJustify
        Caption = '(%) Total de descontos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTotalDescontos: TEditFocus
        Left = 196
        Top = 25
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtPerTotalDescontos: TEditFocus
        Left = 196
        Top = 1
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlTotalLiquido: TPanel
      Left = 0
      Top = 324
      Width = 315
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 8
      object Label5: TLabel
        Left = 80
        Top = 6
        Width = 110
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total L'#237'quido Venda:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape7: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 311
      end
      object edtTotalLiquido: TEditFocus
        Left = 196
        Top = 2
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlTotBrutoComPromoc: TPanel
      Left = 0
      Top = 214
      Width = 315
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 5
      object Label7: TLabel
        Left = 9
        Top = 11
        Width = 181
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Bruto itens c/ Promo'#231#227'o (+):'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape5: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 328
      end
      object edtTotBrutoComPromoc: TEditFocus
        Left = 196
        Top = 7
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlTotBrutoSemPromoc: TPanel
      Left = 0
      Top = 244
      Width = 315
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 6
      object Label6: TLabel
        Left = 8
        Top = 6
        Width = 182
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Bruto itens s/ Promo'#231#227'o (+):'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTotBrutoSemPromoc: TEditFocus
        Left = 196
        Top = 2
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlTotLiqSemPromoDig: TPanel
      Left = 0
      Top = 182
      Width = 315
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      object Label3: TLabel
        Left = 12
        Top = 7
        Width = 178
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total l'#237'quido produtos sem Promo'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtTotLiqSemPromoDig: TEditFocus
        Tag = 99
        Left = 196
        Top = 3
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnEnter = edtPorDesEnter
        OnExit = edtPorDesExit
        NormalColor = clWindow
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlVlrCheckOut: TPanel
      Left = 0
      Top = 21
      Width = 315
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      Visible = False
      object lblVlrCheckOut: TLabel
        Left = 32
        Top = 12
        Width = 158
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor l'#237'quido produtos check-out:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape8: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 311
      end
      object edtVlrCheckOut: TEditFocus
        Tag = 99
        Left = 196
        Top = 7
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlVlrLiqSemPromoDig: TPanel
      Left = 0
      Top = 56
      Width = 315
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label1: TLabel
        Left = 9
        Top = 12
        Width = 181
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor l'#237'quido produtos sem Promo'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape6: TShape
        Left = 0
        Top = 0
        Width = 315
        Height = 1
        Align = alTop
        Pen.Color = clMedGray
        ExplicitTop = 8
        ExplicitWidth = 311
      end
      object edtVlrLiqSemPromoDig: TEditFocus
        Tag = 99
        Left = 196
        Top = 8
        Width = 95
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnEnter = edtPorDesEnter
        OnExit = edtPorDesExit
        NormalColor = clWindow
        FocusColor = clSilver
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 312
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 308
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 20
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    HintHidePause = 5000
    Left = 696
    Top = 320
  end
end
