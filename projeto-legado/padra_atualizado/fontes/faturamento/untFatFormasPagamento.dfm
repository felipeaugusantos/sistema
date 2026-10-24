inherited frmFatFormasPagamento: TfrmFatFormasPagamento
  Left = 433
  Top = 319
  Width = 673
  Height = 226
  BorderIcons = [biSystemMenu]
  Caption = 'Formas de Pagamento'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 673
  ExplicitHeight = 226
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 153
    Width = 667
    TabOrder = 1
    ExplicitTop = 153
    ExplicitWidth = 667
    inherited FlwBotoes: TFlowPanel
      Width = 663
      TabOrder = 2
      ExplicitWidth = 663
    end
    inherited btnSair: TBitBtnLocked
      Left = 585
      ExplicitLeft = 585
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
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
  end
  inherited pnlStatus: TPanel
    Top = 181
    Width = 667
    TabOrder = 2
    ExplicitTop = 181
    ExplicitWidth = 667
    inherited pnlNomeForm: TPanel
      Left = 496
      ExplicitLeft = 496
    end
    inherited pnlInfo: TPanel
      Width = 496
      ExplicitWidth = 496
    end
  end
  object pnlTotal: TPanel [2]
    Left = 0
    Top = 0
    Width = 667
    Height = 28
    Align = alTop
    Color = 16770261
    TabOrder = 3
    DesignSize = (
      667
      28)
    object lblValTot: TLabel
      Left = 559
      Top = 6
      Width = 86
      Height = 19
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Valor Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlValDig: TPanel [3]
    Left = 0
    Top = 125
    Width = 667
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    DesignSize = (
      667
      28)
    object lblValDig: TLabel
      Left = 14
      Top = 4
      Width = 113
      Height = 19
      Anchors = [akLeft, akBottom]
      Caption = 'Valor Digitado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorRestante: TLabel
      Left = 493
      Top = 4
      Width = 152
      Height = 19
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Valor Restante: 0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      ExplicitLeft = 478
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 28
    Width = 667
    Height = 97
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitTop = 26
    object lblDinheiro: TLabel
      Left = 49
      Top = 18
      Width = 42
      Height = 14
      Caption = 'Dinheiro:'
    end
    object lblChequeVista: TLabel
      Left = 14
      Top = 42
      Width = 77
      Height = 14
      Caption = 'Cheque a Vista:'
    end
    object lblChequePre: TLabel
      Left = 25
      Top = 66
      Width = 66
      Height = 14
      Caption = 'Cheque - Pr'#233':'
    end
    object lblCartao: TLabel
      Left = 288
      Top = 18
      Width = 35
      Height = 14
      Caption = 'Cart'#227'o:'
    end
    object lblFaturado: TLabel
      Left = 277
      Top = 66
      Width = 46
      Height = 14
      Caption = 'Faturado:'
    end
    object lblOrdPag: TLabel
      Left = 217
      Top = 42
      Width = 106
      Height = 14
      Caption = 'Ordem de Pagamento:'
    end
    object lblFinanc: TLabel
      Left = 467
      Top = 17
      Width = 72
      Height = 14
      Caption = 'Financiamento:'
      Enabled = False
    end
    object lblValCre: TLabel
      Left = 461
      Top = 40
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Utilizar Cr'#233'ditos:'
      Visible = False
    end
    object edtDinheiro: TEditFocus
      Tag = 99
      Left = 93
      Top = 13
      Width = 113
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
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
    object edtChqVista: TEditFocus
      Tag = 99
      Left = 93
      Top = 37
      Width = 113
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyPress = edtChqVistaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtChqPre: TEditFocus
      Tag = 99
      Left = 93
      Top = 61
      Width = 113
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 2
      OnKeyPress = edtChqVistaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCartao: TEditFocus
      Tag = 99
      Left = 325
      Top = 13
      Width = 113
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 3
      OnKeyPress = edtChqVistaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtFaturado: TEditFocus
      Tag = 99
      Left = 325
      Top = 61
      Width = 113
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 7
      OnExit = edtFaturadoExit
      OnKeyPress = edtChqVistaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtOrdPag: TEditFocus
      Tag = 99
      Left = 325
      Top = 37
      Width = 78
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 4
      OnChange = edtOrdPagChange
      OnKeyPress = edtChqVistaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtFinanc: TEditFocus
      Tag = 99
      Left = 541
      Top = 13
      Width = 113
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 8
      OnKeyPress = edtChqVistaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValCre: TEditFocus
      Tag = 99
      Left = 541
      Top = 37
      Width = 113
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 9
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnReceberPix: TBitBtnLocked
      Left = 407
      Top = 37
      Width = 31
      Height = 22
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000002124003068710098757F00AC262A
        0038000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000001A1C0026A7B600F5AEBD00FFAEBD00FFA3B1
        00EF373B00500000000000000000000000000000000000000000000000000000
        0000000000000000000021240030A7B600F5AEBD00FFAEBD00FFAEBD00FFAEBD
        00FFA3B100EF373B005000000000000000000000000000000000000000000000
        0000000000001B1E00289CAA00E5AEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD
        00FFAEBD00FFA3B100EF262A0038000000000000000000000000000000000000
        0000212400304C5300703A3F005568710099AEBD00FFAEBD00FFAEBD00FFAEBD
        00FF8D9900CF373C00514A50006C2F3300450000000000000000000000002124
        0030A7B600F5AEBD00FFAEBD00FF6068008C6069008DAEBD00FFAEBD00FF8D99
        00CF272A0039AEBD00FFAEBD00FFA3B100EF373B0050000000001416001EA3B1
        00EFAEBD00FFAEBD00FFAEBD00FFAEBD00FF5D6600895D6600898D9900CF363B
        004FADBC00FEAEBD00FFAEBD00FFAEBD00FFA3B100EF2C300041626A008FAEBD
        00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FF6A74009C444A0064ADBC
        00FEAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FF7B8500B458600081AEBD
        00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FF626B00904E550073A3B1
        00EFAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD00FF768000AD1B1E0028A3B1
        00EFAEBD00FFAEBD00FFAEBD00FFAEBD00FF545B007B677000978D9900CE383D
        0052A3B100EFAEBD00FFAEBD00FFAEBD00FFAEBD00FF272A0039000000002124
        0030A3B100EFAEBD00FFAEBD00FF565D007E68710099AEBD00FFAEBD00FF8D99
        00CF383D0052A3B100EFAEBD00FFAEBD00FF3034004600000000000000000000
        0000212400304C530070373B0050646D0093AEBD00FFAEBD00FFAEBD00FFAEBD
        00FF8D9900CF4146005F4A50006C212400300000000000000000000000000000
        00000000000016180020A3B100EFAEBD00FFAEBD00FFAEBD00FFAEBD00FFAEBD
        00FFAEBD00FF9EAC00E8262A0038000000000000000000000000000000000000
        0000000000000000000021240030A3B100EFAEBD00FFAEBD00FFAEBD00FFAEBD
        00FFAEBD00FF2C2F004000000000000000000000000000000000000000000000
        0000000000000000000000000000212400309CAA00E5AEBD00FFAEBD00FFAEBD
        00FF2C2F00400000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000021240030636B0091778200AF1E21
        002C000000000000000000000000000000000000000000000000}
      TabOrder = 5
      Visible = False
      OnClick = btnReceberPixClick
    end
    object chkPixAvulso: TCheckBox
      Left = 444
      Top = 74
      Width = 73
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = 'Pix Avulso:'
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 6
      Visible = False
      OnClick = chkPixAvulsoClick
    end
    object pnlBoleto: TPanel
      Left = 469
      Top = 61
      Width = 185
      Height = 22
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 10
      Visible = False
      object lblBoleto: TLabel
        Left = 35
        Top = 3
        Width = 33
        Height = 14
        Caption = 'Boleto:'
      end
      object edtValorBoleto: TEditFocus
        Tag = 99
        Left = 72
        Top = 0
        Width = 113
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
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
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 576
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 160
  end
end
