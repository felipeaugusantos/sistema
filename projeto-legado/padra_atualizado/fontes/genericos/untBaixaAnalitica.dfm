inherited frmBaixaAnalitica: TfrmBaixaAnalitica
  Left = 574
  Top = 285
  Width = 480
  Height = 455
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Baixa Anal'#237'tica'
  Position = poMainFormCenter
  ExplicitWidth = 480
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 382
    Width = 474
    TabOrder = 4
    ExplicitTop = 382
    ExplicitWidth = 474
    DesignSize = (
      474
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 470
      ExplicitWidth = 470
    end
    inherited btnSair: TBitBtnLocked
      Left = 305
      ExplicitLeft = 305
    end
  end
  inherited pnlStatus: TPanel
    Top = 410
    Width = 474
    TabOrder = 3
    ExplicitTop = 410
    ExplicitWidth = 474
    inherited pnlNomeForm: TPanel
      Left = 344
      Width = 130
      ExplicitLeft = 344
      ExplicitWidth = 130
    end
    inherited pnlInfo: TPanel
      Width = 344
      ExplicitWidth = 344
    end
  end
  inherited pgcDados: TPageControl
    Top = 136
    Width = 381
    Height = 72
    Align = alNone
    TabOrder = 2
    Visible = False
    ExplicitTop = 136
    ExplicitWidth = 381
    ExplicitHeight = 72
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 373
      ExplicitHeight = 40
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 382
    Width = 474
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 5
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
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
    object btnCancelaDados: TBitBtnLocked
      Left = 395
      Top = 2
      Width = 77
      Height = 24
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
      TabOrder = 1
      OnClick = btnCancelaClick
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 474
    Height = 282
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblPorBa1: TLabel
      Left = 48
      Top = 28
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label5: TLabel
      Left = 2
      Top = 2
      Width = 470
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
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 375
    end
    object edtCodPorBai: TEditFocus
      Left = 157
      Top = 23
      Width = 303
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
    object edtPorBai: TEditFocus
      Tag = 99
      Left = 93
      Top = 23
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnChange = edtPorBaiChange
      OnKeyPress = edtPorBaiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object gpbDescontoAntecipacao: TGroupBox
      Left = 2
      Top = 108
      Width = 470
      Height = 172
      Align = alBottom
      Caption = 'Desconto por Antecipa'#231#227'o'
      TabOrder = 3
      object lblTaxaBancaria: TLabel
        Left = 16
        Top = 21
        Width = 99
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Taxa Banc'#225'ria (%):'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 16
        Top = 71
        Width = 99
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Valor Tarifa:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 16
        Top = 48
        Width = 99
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Valor Total Cheques:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 16
        Top = 94
        Width = 99
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Valor L'#237'quido:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object Label31: TLabel
        Left = 26
        Top = 144
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor Tarifa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtTaxaBancaria: TEditFocus
        Tag = 99
        Left = 118
        Top = 18
        Width = 38
        Height = 22
        Hint = 'Percentual de juros ao m'#234's'
        Alignment = taLeftJustify
        TabOrder = 0
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###,##0.00'
      end
      object edtValorTarifa: TEditFocus
        Tag = 99
        Left = 118
        Top = 68
        Width = 94
        Height = 22
        Hint = 'Percentual de juros ao m'#234's'
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###,##0.00'
      end
      object edtValorTotalCheques: TEditFocus
        Tag = 99
        Left = 118
        Top = 45
        Width = 94
        Height = 22
        Hint = 'Percentual de juros ao m'#234's'
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###,##0.00'
      end
      object edtValorLiquido: TEditFocus
        Tag = 99
        Left = 118
        Top = 91
        Width = 94
        Height = 22
        Hint = 'Percentual de juros ao m'#234's'
        Alignment = taLeftJustify
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '###,##0.00'
      end
      object edtDesFornecedorTarifa: TEditFocus
        Left = 184
        Top = 141
        Width = 274
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        Color = 16768952
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
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
      object edtFornecedorTarifa: TEditFocus
        Tag = 99
        Left = 118
        Top = 141
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 5
        OnKeyPress = edtFornecedorTarifaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      inline fraPlanoDeContasTar: TfraPlanoDeContasMskEdit
        Left = 2
        Top = 116
        Width = 458
        Height = 22
        TabOrder = 4
        ExplicitLeft = 2
        ExplicitTop = 116
        ExplicitWidth = 458
        inherited lblPlaContas: TLabel
          Left = 2
          Top = 3
          Width = 111
          Height = 14
          Caption = 'Plano de Contas Tarifa:'
          ExplicitLeft = 2
          ExplicitTop = 3
          ExplicitWidth = 111
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 182
          Width = 274
          Height = 22
          ExplicitLeft = 182
          ExplicitWidth = 274
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 116
          Width = 64
          Height = 22
          OnKeyPress = fraPlanoDeContasTarMskCodCtaKeyPress
          ExplicitLeft = 116
          ExplicitWidth = 64
          ExplicitHeight = 22
        end
      end
    end
    inline fraPlanoDeContasCre: TfraPlanoDeContasMskEdit
      Left = 9
      Top = 71
      Width = 457
      Height = 22
      TabOrder = 1
      ExplicitLeft = 9
      ExplicitTop = 71
      ExplicitWidth = 457
      inherited lblPlaContas: TLabel
        Width = 81
        Height = 14
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 148
        Width = 303
        Height = 22
        ExplicitLeft = 148
        ExplicitWidth = 303
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 84
        Width = 64
        Height = 22
        OnKeyPress = fraPlanoDeContasCreMskCodCtaKeyPress
        ExplicitLeft = 84
        ExplicitWidth = 64
        ExplicitHeight = 22
      end
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 3
      Top = 47
      Width = 461
      Height = 22
      TabOrder = 4
      Visible = False
      ExplicitLeft = 3
      ExplicitTop = 47
      ExplicitWidth = 461
      inherited lblEventos: TLabel
        Left = 2
        Width = 87
        Height = 14
        ExplicitLeft = 2
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Left = 90
        Width = 64
        Height = 22
        ExplicitLeft = 90
        ExplicitWidth = 64
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 154
        Width = 303
        Height = 22
        ExplicitLeft = 154
        ExplicitWidth = 303
        ExplicitHeight = 22
      end
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 282
    Width = 474
    Height = 100
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    object lblPorDeb: TLabel
      Left = 47
      Top = 30
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label6: TLabel
      Left = 2
      Top = 2
      Width = 470
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
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 375
    end
    object edtCodPorDeb: TEditFocus
      Left = 158
      Top = 23
      Width = 303
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
    object edtPorDeb: TEditFocus
      Tag = 99
      Left = 94
      Top = 23
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtPorDebKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    inline fraPlanoDeContasDeb: TfraPlanoDeContasMskEdit
      Left = 8
      Top = 67
      Width = 455
      Height = 22
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 67
      ExplicitWidth = 455
      inherited lblPlaContas: TLabel
        Left = 5
        Width = 81
        Height = 14
        ExplicitLeft = 5
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 150
        Width = 303
        Height = 22
        ExplicitLeft = 150
        ExplicitWidth = 303
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 86
        Width = 64
        Height = 22
        OnKeyPress = fraPlanoDeContasDebMskCodCtaKeyPress
        ExplicitLeft = 86
        ExplicitWidth = 64
        ExplicitHeight = 22
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 156
    Top = 388
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 116
    Top = 392
  end
end
