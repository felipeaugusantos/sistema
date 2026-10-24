inherited frmRcxDigRecebimento: TfrmRcxDigRecebimento
  Left = 335
  Top = 287
  Width = 405
  Height = 292
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o do Recebimento'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 405
  ExplicitHeight = 292
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 219
    Width = 399
    Height = 28
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 219
    ExplicitWidth = 399
    ExplicitHeight = 28
    DesignSize = (
      399
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 395
      TabOrder = 3
      ExplicitWidth = 395
    end
    inherited btnSair: TBitBtnLocked
      Left = 317
      Top = 3
      ExplicitLeft = 317
      ExplicitTop = 3
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 72
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
      OnClick = btnConfirmaClick
    end
    object btnMostraMargem: TBitBtnLocked
      Left = 77
      Top = 3
      Width = 101
      Height = 22
      Caption = '&Margem/Lucro'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300030003
        0003333377737773777333333333333333333FFFFFFFFFFFFFFF770000000000
        0000777777777777777733039993BBB3CCC3337F737F737F737F37039993BBB3
        CCC3377F737F737F737F33039993BBB3CCC33F7F737F737F737F77079997BBB7
        CCC77777737773777377330399930003CCC3337F737F7773737F370399933333
        CCC3377F737F3333737F330399933333CCC33F7F737FFFFF737F770700077777
        CCC77777777777777377330333333333CCC3337F33333333737F370333333333
        0003377F33333333777333033333333333333F7FFFFFFFFFFFFF770777777777
        7777777777777777777733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 2
      Visible = False
      OnClick = btnMostraMargemClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 247
    Width = 399
    TabOrder = 2
    ExplicitTop = 247
    ExplicitWidth = 399
    inherited pnlNomeForm: TPanel
      Left = 228
      ExplicitLeft = 228
    end
    inherited pnlInfo: TPanel
      Width = 228
      ExplicitWidth = 228
    end
  end
  inherited pgcDados: TPageControl
    Width = 399
    Height = 188
    TabOrder = 3
    ExplicitWidth = 399
    ExplicitHeight = 188
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 391
      ExplicitHeight = 156
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 399
    Height = 188
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 399
      Height = 39
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object lblLabel1: TLabel
        Left = 42
        Top = 13
        Width = 47
        Height = 14
        Caption = 'Duplicata:'
      end
      object Label1: TLabel
        Left = 216
        Top = 13
        Width = 74
        Height = 14
        Caption = 'Valor Corrigido:'
      end
      object edtNumDup: TEditFocus
        Left = 91
        Top = 9
        Width = 119
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtValCor: TEditFocus
        Left = 292
        Top = 9
        Width = 98
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
    object pnlValores: TPanel
      Left = 0
      Top = 39
      Width = 399
      Height = 149
      Align = alClient
      Color = 16770261
      TabOrder = 1
      object Label6: TLabel
        Left = 13
        Top = 9
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Recebido:'
      end
      object Label2: TLabel
        Left = 59
        Top = 32
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Juros:'
      end
      object Label3: TLabel
        Left = 40
        Top = 78
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto:'
      end
      object Label4: TLabel
        Left = 43
        Top = 101
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Restante:'
      end
      object lblRomaneio: TLabel
        Left = 241
        Top = 10
        Width = 50
        Height = 14
        Caption = 'Romaneio:'
        Visible = False
      end
      object lblMotivo: TLabel
        Left = 6
        Top = 124
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'Motivo Desconto:'
      end
      object Label12: TLabel
        Left = 8
        Top = 55
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desp. Cobran'#231'a:'
      end
      object edtValRec: TEditFocus
        Tag = 99
        Left = 91
        Top = 5
        Width = 78
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
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
      object edtValJur: TEditFocus
        Tag = 99
        Left = 91
        Top = 28
        Width = 78
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        ReadOnly = True
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
      object edtValDes: TEditFocus
        Tag = 99
        Left = 91
        Top = 74
        Width = 78
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        OnChange = edtValDesChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValRes: TEditFocus
        Tag = 99
        Left = 91
        Top = 97
        Width = 78
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtRomaneio: TEditFocus
        Tag = 99
        Left = 292
        Top = 6
        Width = 98
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 6
        Visible = False
        OnKeyPress = edtRomaneioKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtMotivo: TEditFocus
        Tag = 99
        Left = 91
        Top = 120
        Width = 299
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnExit = edtMotivoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValCob: TEditFocus
        Tag = 99
        Left = 91
        Top = 51
        Width = 78
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 2
        OnChange = edtValDesChange
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
  end
  object pnlJuros: TPanel [4]
    Left = 0
    Top = 188
    Width = 399
    Height = 31
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label5: TLabel
      Left = 8
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vl.Orig:'
    end
    object Label7: TLabel
      Left = 124
      Top = 10
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Juros Cad.:'
    end
    object Label8: TLabel
      Left = 259
      Top = 10
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desc.Cad.:'
    end
    object Label9: TLabel
      Left = 148
      Top = 34
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Juros:'
      Visible = False
    end
    object Label10: TLabel
      Left = 262
      Top = 34
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
      Visible = False
    end
    object Label11: TLabel
      Left = 258
      Top = 58
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Final:'
      Visible = False
    end
    object edtTotalizaValOri: TEditFocus
      Left = 44
      Top = 6
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
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
      EditFormat = '#,##0.00'
    end
    object edtTotalizaJurSuj: TEditFocus
      Left = 179
      Top = 6
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
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
      EditFormat = '#,##0.00'
    end
    object edtTotalizaDesSuj: TEditFocus
      Left = 312
      Top = 6
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
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
      EditFormat = '#,##0.00'
    end
    object edtTotalizaValJur: TEditFocus
      Left = 179
      Top = 30
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtTotalizaValDes: TEditFocus
      Left = 312
      Top = 30
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtTotalizaValFin: TEditFocus
      Left = 312
      Top = 54
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 240
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 248
  end
end
