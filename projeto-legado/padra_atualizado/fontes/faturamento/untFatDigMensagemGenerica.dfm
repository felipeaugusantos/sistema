inherited frmFatDigMensagemGenerica: TfrmFatDigMensagemGenerica
  Left = 225
  Top = 262
  Width = 649
  Height = 729
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Observa'#231#245'es'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 649
  ExplicitHeight = 729
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 656
    Width = 643
    TabOrder = 4
    ExplicitTop = 656
    ExplicitWidth = 643
    DesignSize = (
      643
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 639
      ExplicitWidth = 639
    end
    inherited btnSair: TBitBtnLocked
      Left = 289
      ExplicitLeft = 289
    end
  end
  inherited pnlStatus: TPanel
    Top = 684
    Width = 643
    TabOrder = 3
    ExplicitTop = 684
    ExplicitWidth = 643
    inherited pnlNomeForm: TPanel
      Left = 471
      Width = 172
      ExplicitLeft = 471
      ExplicitWidth = 172
    end
    inherited pnlInfo: TPanel
      Width = 471
      ExplicitWidth = 471
    end
  end
  inherited pgcDados: TPageControl
    Width = 643
    Height = 656
    TabOrder = 2
    Visible = False
    ExplicitWidth = 643
    ExplicitHeight = 656
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 635
      ExplicitHeight = 624
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 656
    Width = 643
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 1
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 102
      Height = 24
      Align = alLeft
      Caption = '[F10] Confirma'
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
      Left = 543
      Top = 2
      Width = 98
      Height = 24
      Align = alRight
      Caption = '[Esc] Cancelar'
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
    object btnMostraMargem: TBitBtnLocked
      Left = 104
      Top = 2
      Width = 103
      Height = 24
      Align = alLeft
      Caption = '[ F4 ] Margem/Lucro'
      TabOrder = 2
      OnClick = btnMostraMargemClick
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 643
    Height = 656
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object pnlTransportadora: TPanel
      Left = 2
      Top = 125
      Width = 639
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Label2: TLabel
        Left = 63
        Top = 4
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transportadora:'
      end
      object edtNomTra: TEditFocus
        Left = 205
        Top = 0
        Width = 343
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
      object edtCodTra: TEditFocus
        Tag = 99
        Left = 142
        Top = 0
        Width = 62
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
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
    end
    object pnlDadosFrete: TPanel
      Left = 2
      Top = 171
      Width = 639
      Height = 92
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 5
      object lblValFre: TLabel
        Left = 65
        Top = 4
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor do Frete:'
      end
      object Label4: TLabel
        Left = 54
        Top = 50
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Caption = 'Frete para Conta:'
      end
      object Label7: TLabel
        Left = 40
        Top = 73
        Width = 98
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#250'mero do Registro:'
      end
      object btnCalcFreSug: TSpeedButton
        Left = 205
        Top = 0
        Width = 24
        Height = 22
        Hint = 'Carregar o valor do frete sugest'#227'o'
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000330B0000330B00000001000000010000BD4D0100CB57
          0000CC5A2A00A4676900D2851A00E7AC1D00E89B2700CF8E6800FF00FF00F3BB
          9F00FFCFA500FFD6B500FFDFC300FEEBD800FFEFDE0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000080808080808
          0808080808080808080808080808080808080808080808080808080101010101
          0101010101010101010805090909090909090909090909090901050C09090B09
          090A09090B09090A0901050D02000B01000A01000A01000A0901050D09090C09
          090B09090A09090A0901050D02000D01000B01000A01000A0901050D0D0D0D0D
          0C0B0B0B0B0A0A0A0901050D0707070707070707070B0A0A0901050D030E0E0E
          0E0E0E0E070B0B0A0901050D0303030303030303030C0B0B0901050D0D0D0D0D
          0D0D0D0D0D0D0D0C090108060606060606060606060606060408080808080808
          0808080808080808080808080808080808080808080808080808}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnCalcFreSugClick
      end
      object lblFreCot: TLabel
        Left = 43
        Top = 27
        Width = 93
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Frete Cotado:'
      end
      object edtValFre: TEditFocus
        Tag = 99
        Left = 142
        Top = 0
        Width = 62
        Height = 22
        Alignment = taRightJustify
        MaxLength = 7
        TabOrder = 0
        OnEnter = edtValFreEnter
        OnExit = edtValFreExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtNumReg: TEditFocus
        Tag = 99
        Left = 142
        Top = 69
        Width = 171
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 20
        TipoTexto = ttAlfanumerico
      end
      object cmbTipFre: TComboBoxFocus
        Tag = 99
        Left = 142
        Top = 46
        Width = 171
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtValFreCot: TEditFocus
        Tag = 99
        Left = 142
        Top = 23
        Width = 62
        Height = 22
        Alignment = taRightJustify
        MaxLength = 7
        TabOrder = 1
        OnEnter = edtValFreEnter
        OnExit = edtValFreExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlVolumes: TPanel
      Left = 2
      Top = 286
      Width = 639
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 7
      object Label3: TLabel
        Left = 94
        Top = 4
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Volumes:'
      end
      object btnCalcVolume: TSpeedButton
        Left = 205
        Top = 0
        Width = 24
        Height = 22
        Hint = 'Calcular a quantidade de volumes'
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000330B0000330B00000001000000010000BD4D0100CB57
          0000CC5A2A00A4676900D2851A00E7AC1D00E89B2700CF8E6800FF00FF00F3BB
          9F00FFCFA500FFD6B500FFDFC300FEEBD800FFEFDE0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000080808080808
          0808080808080808080808080808080808080808080808080808080101010101
          0101010101010101010805090909090909090909090909090901050C09090B09
          090A09090B09090A0901050D02000B01000A01000A01000A0901050D09090C09
          090B09090A09090A0901050D02000D01000B01000A01000A0901050D0D0D0D0D
          0C0B0B0B0B0A0A0A0901050D0707070707070707070B0A0A0901050D030E0E0E
          0E0E0E0E070B0B0A0901050D0303030303030303030C0B0B0901050D0D0D0D0D
          0D0D0D0D0D0D0D0C090108060606060606060606060606060408080808080808
          0808080808080808080808080808080808080808080808080808}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnCalcVolumeClick
      end
      object edtQtdTra: TEditFocus
        Tag = 99
        Left = 142
        Top = 0
        Width = 62
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        MaxLength = 8
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlEventos: TPanel
      Left = 2
      Top = 331
      Width = 639
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 9
      inline fraCentroCusto: TfraCentroCustoEditFocus
        Left = 48
        Top = 0
        Width = 513
        Height = 22
        TabOrder = 0
        ExplicitLeft = 48
        ExplicitWidth = 513
        inherited lblEventos: TLabel
          Left = 3
          Width = 87
          Height = 14
          ExplicitLeft = 3
          ExplicitWidth = 87
          ExplicitHeight = 14
        end
        inherited edtCodEve: TEditFocus
          Width = 62
          Height = 22
          ExplicitWidth = 62
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Left = 157
          Width = 343
          Height = 22
          ExplicitLeft = 157
          ExplicitWidth = 343
          ExplicitHeight = 22
        end
      end
    end
    object pnlMenExp: TPanel
      Left = 2
      Top = 354
      Width = 639
      Height = 92
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 10
      Visible = False
      object lbl1: TLabel
        Left = 8
        Top = 4
        Width = 130
        Height = 14
        Alignment = taRightJustify
        Caption = 'Observa'#231#245'es (Expedi'#231#227'o):'
      end
      object edtMenExp: TEditFocus
        Tag = 99
        Left = 142
        Top = 0
        Width = 406
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 70
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMenEx2: TEditFocus
        Tag = 99
        Left = 142
        Top = 23
        Width = 406
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 70
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMenEx3: TEditFocus
        Tag = 99
        Left = 142
        Top = 46
        Width = 406
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 70
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMenEx4: TEditFocus
        Tag = 99
        Left = 142
        Top = 69
        Width = 406
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 70
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlDesAce: TPanel
      Left = 2
      Top = 446
      Width = 639
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 11
      object Label23: TLabel
        Left = 42
        Top = 4
        Width = 97
        Height = 14
        Alignment = taRightJustify
        Caption = 'Despesa acess'#243'ria:'
      end
      object edtDesAce: TEditFocus
        Tag = 99
        Left = 142
        Top = 0
        Width = 62
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object btnDespesasFaturamento: TBitBtnLocked
        Left = 204
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Despesas para Faturamento'
        Glyph.Data = {
          06030000424D060300000000000036000000280000000F0000000F0000000100
          180000000000D0020000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          9E9E9EADADADAFAFAFABAAABACAFABB2AEAEA5AAACB2AEAFB2AFB0A8ACABA4A6
          A5FFFFFFFFFFFF000000FFFFFFF2F2F2A0A0A0BFBFBFAFAFAFD2CFD0B1B6B5B0
          ADAFD8D8D5C5AA9ECCA294E3D1CBA3A1A2FFFEFEFFFFFF000000FFFFFFF3F3F3
          A2A2A2A4A4A4939393BFBEBC989B9E949298CFCAC3B6866EBB8062D3BAADA4A4
          A6FFFEFFFFFFFF000000FFFFFFF4F4F49F9F9FC4C4C4B5B5B5D2D2D1BDBBBDB7
          B4B9DEDCD4BC8871BB8565D1BEACA2A7A5FEFEFFFFFFFF000000FFFFFFF4F4F4
          A4A4A49B9B9B8A8A89B6B7B79791918B898AC3C5BDB5826FBA7A5DD6BAAAA6A5
          A1FFFEFFFFFFFF000000FFFFFFF4F4F49E9E9ECFCFCFC2C2C2DAD6D8CDCAC4B9
          C3C6E0DED699BFF582B9F7C4DDF1A49FA3FDFFFFFFFFFF000000FFFFFFF4F4F4
          A3A3A39A9A9A8A8A8AB6B9B6909195918787B8BFC70974ED0064FF70AEF1ACA3
          A5FFFFFEFFFFFF000000FFFFFFF4F4F4A0A0A0CCCBCBBDBEBED4D6D9CCC6BFBC
          BEBED5DBDFA6BEDA9BB7D6CDDBE5AAA1A0FFFFFFFFFFFF000000FFFFFFF4F4F4
          A3A2A39A999A888788B6B4BD8E9193818986BFC0BB99908E8C8885B5BDC0A4A1
          A8FEFFFFFFFFFF000000FFFFFFF4F4F49F9F9FE2E2E3D5D4D6E6E4E1D6D5D9D9
          D2D5E4E4E8D4D4D3D6D1CFE8ECEBA8A09FFFFFFFFFFFFF000000FFFFFFF5F5F6
          9A9E974C741B598E2B5E8E2965952F6B9937709C4378A15179A85960813DABAA
          AAFFFEFFFFFFFF000000FFFFFFF6F5F7949891648F298ACA3983CB498BD44E92
          DA579ADF61A4E971BFFA89799F56A4A3AFFFFFFFFFFFFF000000FFFFFFF4F4F5
          9FA29B5A7537567D23587B20577C1E577C1D577B1D557A1D4C781863803CAEAF
          A8FFFEFFFFFFFF000000FFFFFFFBFBFB757775B6B9B5AFB2AFB0B0B5B0B1B3B0
          B1B4B0B2B1B0B2B2AFAEB5B8B7B3837F7FFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFBFAFBFBFAFCFBFBFBFBFAFBFBFAFBFBFBFBFBFBFBFBFAFBFAF9FBFFFF
          FFFFFFFFFFFFFF000000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Visible = False
        OnClick = btnDespesasFaturamentoClick
      end
    end
    object pnlContato: TPanel
      Left = 2
      Top = 469
      Width = 639
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 12
      object lblCliCtt: TLabel
        Left = 63
        Top = 3
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'Contato Cliente:'
      end
      object edtCliCtt: TEditFocus
        Left = 142
        Top = 0
        Width = 360
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnPesquisarContato: TBitBtnLocked
        Left = 503
        Top = 0
        Width = 22
        Height = 22
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000265EB219376EF52C130E67000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000033571C2008EECFF009AF4FF1F4B80FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000010108468AD82BA7F5FF16C0FFFF00A0F3FF01356EAA000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          01010C579EE268C4F8FF6BD4FFFF279CE6FF0434679E00000000000000000000
          000000000000000000000000000000000000000000000000000000000000186A
          B1DBA4E3FEFFB5EEFFFF4CAAE7FF01386C9A0000000000000000000000000000
          000001000002270F0F86482727BD65443FD1482728C12C10107B57464F9D359E
          E8FFBDF5FFFF77C4EFFF003E779C000000000000000000000000000000001207
          073A7B5554FCDFD3CBFFFFFFF7FFFFFFE7FFFFFEDBFFD6BB9EFF90584DFF817B
          8EFF1794E4FF014B7F95000000000000000000000000000000000904041B8865
          65FFFFFFFFFFFFFFFFFFFDF8E8FFFAF2DCFFF8EDCFFFFFF1CFFFF6DEBAFF9F59
          45FF1A21305A00000000000000000000000000000000000000003F24249BF6EF
          EAFFFFFFFFFFFEFBF5FFFBF7E8FFF9F4DAFFF5EBCCFFE6CEACFFF3DAB8FFE2BD
          99FF513134A60000000000000000000000000000000000000000886A68F4FFFF
          FFFFFDFBF1FFFCF8EEFFFAF3E1FFFCF5E3FFF7F0D7FFF0DFC1FFE7C9A9FFF0D1
          ABFF946A61EC0806060F00000000000000000000000000000000907471F7FFFF
          FCFFF9F2E1FFFAF3DEFFFAF7E5FFFAF1DCFFF1DFC0FFEDD9BAFFECD8B9FFEDCA
          A5FFAF8679FF1510122800000000000000000000000000000000957974F9FFFF
          EBFFF9EED5FFFAF1D7FFF9F2DAFFF2E3C6FFFEFBF9FFFFFFF0FFEFDFC0FFE9C6
          9EFFA57A70F40F0C0D1A00000000000000000000000000000000604646B0F7EA
          C8FFF9EBCCFFEFDCBEFFF4E4C7FFF0E1C5FFFDFCECFFFAF5DDFFEFDCBCFFDFB0
          87FF816565CB000000000000000000000000000000000000000021181A43BA99
          8CFFFDECC4FFEDD4B0FFE5CAA8FFEFDBBFFFF2E3C4FFF2DEBCFFEABF93FFBB8E
          7DFF2E2729470000000000000000000000000000000000000000000000003A2A
          316BBE9A8DFFE6C7A5FFEFCBA3FFECC8A2FFE8BE94FFDCAA86FFBE9585FF433A
          3C64000000000000000000000000000000000000000000000000000000000000
          0000201A1C366D5758A3B3958DF9B7948AF3B6968DF7776563AB1F1C1E2E0000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 1
        TabStop = False
        OnClick = btnPesquisarContatoClick
      end
      object btnAdicionarContato: TBitBtnLocked
        Left = 525
        Top = 0
        Width = 22
        Height = 22
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000100010E1A06261D350C4D1D340C4C0E19
          0625000100010000000000000000000000000000000000000000000000000000
          000000000000000000001F390D53559A23DC68BD2AFF6AC12BFF6BC12CFF68BC
          2AFF559720DA1E360C4F00000000000000000000000000000000000000000000
          000000010001396917976BC22BFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC
          2EFF71CC2EFF6BC12BFF38651792000100010000000000000000000000000000
          00003056137B6EC72DFF71CC2EFF71CC2EFF71CC2EFF69BE2BFF69BF2BFF71CC
          2EFF71CC2EFF71CC2EFF6EC62DFF2D501273000000000000000000000000070D
          031369BF2AFC71CC2EFF71CC2EFF71CC2EFF71CC2EFFC4DEACFFC2DDA9FF71CC
          2EFF71CC2EFF71CC2EFF71CC2EFF68BB28FA060B021000000000000000003560
          158471CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFFC4DEACFFC2DDA9FF71CC
          2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF3158147B0000000000000000559C
          23CE71CC2EFF71CC2EFF6CC22CFF6CC22CFF6CC22CFFC4DDACFFC1DCA9FF6CC2
          2CFF6CC22CFF6CC22CFF71CC2EFF71CC2EFF549722C900000000000000005EAD
          27E171CC2EFF71CC2EFFC0D9A8FFC0D9A8FFC0D9A8FFE2E9D6FFE0E8D5FFC0D9
          A8FFC0D9A8FFC0D9A8FF71CC2EFF71CC2EFF5EAA24DD00000000000000005DA8
          25D971CC2EFF71CC2EFFC8E4AEFFC8E4AEFFC8E4AEFFE2EAD7FFE2EAD7FFC8E4
          AEFFC8E4AEFFC8E4AEFF71CC2EFF71CC2EFF5AA425D400000000000000004780
          1DA771CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFFC4DEACFFC2DDA9FF71CC
          2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF447C1CA000000000000000001728
          0A3371CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFFC4DEACFFC2DDA9FF71CC
          2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF1424082D00000000000000000000
          0000529721C171CC2EFF71CC2EFF71CC2EFF71CC2EFFC6E2ADFFC4E1AAFF71CC
          2EFF71CC2EFF71CC2EFF71CC2EFF519321BA0000000000000000000000000000
          00000910041461B429E271CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC
          2EFF71CC2EFF71CC2EFF62B226DF080E03110000000000000000000000000000
          000000000000091004144F8F20B571CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC
          2EFF71CC2EFF4E8D20B1080E0312000000000000000000000000000000000000
          000000000000000000000000000015260930396617804A851EA648831EA53866
          177F1425082E0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 2
        TabStop = False
        OnClick = btnAdicionarContatoClick
      end
    end
    object pnlPlanoContas: TPanel
      Left = 2
      Top = 79
      Width = 639
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
        Left = 51
        Top = 0
        Width = 510
        Height = 22
        TabOrder = 0
        ExplicitLeft = 51
        ExplicitWidth = 510
        inherited lblPlaContas: TLabel
          Left = 6
          Width = 81
          Height = 14
          ExplicitLeft = 6
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 154
          Width = 343
          Height = 22
          ExplicitLeft = 154
          ExplicitWidth = 343
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 91
          Width = 62
          Height = 22
          OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
          ExplicitLeft = 91
          ExplicitWidth = 62
          ExplicitHeight = 22
        end
      end
    end
    object pnlGeral: TPanel
      Left = 2
      Top = 2
      Width = 639
      Height = 77
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 86
        Top = 12
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Mensagem:'
      end
      object edtMens01: TEditFocus
        Left = 142
        Top = 8
        Width = 406
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = clWhite
        MaxLength = 80
        TabOrder = 0
        NormalColor = clWhite
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMens02: TEditFocus
        Left = 142
        Top = 31
        Width = 406
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = clWhite
        MaxLength = 80
        TabOrder = 1
        NormalColor = clWhite
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkEntUrg: TCheckBox
        Left = 481
        Top = 57
        Width = 67
        Height = 17
        Caption = 'Urgente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
    end
    object pnlTraRedesp: TPanel
      Left = 2
      Top = 147
      Width = 639
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      object Label5: TLabel
        Left = -1
        Top = 5
        Width = 142
        Height = 14
        Caption = 'Transportadora Redespacho:'
      end
      object edtTraRedNom: TEditFocus
        Left = 205
        Top = 1
        Width = 343
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
      object edtTraRedCod: TEditFocus
        Tag = 99
        Left = 142
        Top = 1
        Width = 62
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtTraRedCodKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
    end
    object pnlProjeto: TPanel
      Left = 2
      Top = 492
      Width = 639
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 13
      Visible = False
      object Label8: TLabel
        Left = 54
        Top = 3
        Width = 86
        Height = 14
        Caption = 'Projeto do Cliente:'
      end
      object edtDesPrj: TEditFocus
        Left = 198
        Top = 0
        Width = 350
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodPrj: TEditFocus
        Tag = 99
        Left = 142
        Top = 0
        Width = 55
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
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodPrjKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlNotPau: TPanel
      Left = 2
      Top = 263
      Width = 639
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      object lblNotPau: TLabel
        Left = 40
        Top = 4
        Width = 96
        Height = 13
        Caption = 'Nota Fiscal Paulista:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtNotPau: TEditFocus
        Tag = 99
        Left = 142
        Top = 0
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'S'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlRota: TPanel
      Left = 2
      Top = 102
      Width = 639
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object lblRota: TLabel
        Left = 93
        Top = 4
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Seq.Rota:'
      end
      object edtCodRot: TEditFocus
        Tag = 99
        Left = 142
        Top = 0
        Width = 63
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
        ReadOnly = True
        TabOrder = 0
        OnKeyPress = edtCodRotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
    end
    object pnlTipAte: TPanel
      Left = 2
      Top = 515
      Width = 639
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 14
      Visible = False
      object lblTipAte: TLabel
        Left = 41
        Top = 3
        Width = 100
        Height = 14
        Caption = 'Tipo de Atendimento:'
      end
      object edtDesTpa: TEditFocus
        Left = 198
        Top = 1
        Width = 350
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodTpa: TEditFocus
        Tag = 99
        Left = 142
        Top = 1
        Width = 55
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
        TabOrder = 0
        OnKeyPress = edtCodTpaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlVolumeSepExc: TPanel
      Left = 2
      Top = 309
      Width = 639
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 8
      object lblQtdTraSepExc: TLabel
        Left = 23
        Top = 3
        Width = 115
        Height = 13
        Alignment = taRightJustify
        Caption = 'Volumes Sep. Exclusiva:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblQtdTraSepNExc: TLabel
        Left = 216
        Top = 3
        Width = 137
        Height = 13
        Alignment = taRightJustify
        Caption = 'Volumes Sep. N'#227'o Exclusiva:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtQtdTraSepExc: TEditFocus
        Left = 142
        Top = 0
        Width = 62
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtQtdTraSepNExc: TEditFocus
        Left = 357
        Top = 0
        Width = 62
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlEmpFat: TPanel
      Left = 2
      Top = 540
      Width = 639
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 15
      object lblEmpFat: TLabel
        Left = 47
        Top = 3
        Width = 93
        Height = 13
        Caption = 'Emp. Faturamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodEmpFat: TEditFocus
        Tag = 99
        AlignWithMargins = True
        Left = 142
        Top = 0
        Width = 56
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
        TabOrder = 0
        OnKeyPress = edtCodEmpFatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpFat: TEditFocus
        Left = 199
        Top = 0
        Width = 349
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 592
    Top = 24
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 320
    Top = 16
  end
  object tmrHideHints: TTimer
    OnTimer = tmrHideHintsTimer
    Left = 368
    Top = 16
  end
end
