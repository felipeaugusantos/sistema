inherited frmRcxTrasfValoresPar: TfrmRcxTrasfValoresPar
  Left = 220
  Top = 271
  Width = 657
  Height = 478
  BorderIcons = [biSystemMenu]
  Caption = 'Transfer'#234'ncia de Valores'
  Position = poMainFormCenter
  ExplicitWidth = 657
  ExplicitHeight = 478
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 405
    Width = 651
    TabOrder = 2
    ExplicitTop = 405
    ExplicitWidth = 651
    DesignSize = (
      651
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 647
      TabOrder = 3
      ExplicitTop = 2
      ExplicitWidth = 647
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 569
      TabOrder = 2
      ExplicitLeft = 569
    end
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
    object btnAltSeqFec: TBitBtnLocked
      Left = 84
      Top = 3
      Width = 198
      Height = 22
      Caption = '[ F9 ] Alterar seq. fechamento parcial'
      TabOrder = 1
      OnClick = btnAltSeqFecClick
    end
  end
  object pnlPortador: TPanel [2]
    Left = 0
    Top = 0
    Width = 651
    Height = 57
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label10: TLabel
      Left = 30
      Top = 10
      Width = 49
      Height = 14
      Caption = 'Operador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 20
      Top = 34
      Width = 59
      Height = 14
      Caption = 'Grupo Ope.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 80
      Top = 6
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      OnEnter = edtCodVendedorEnter
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 117
      Top = 6
      Width = 325
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtGruGpo: TEditFocus
      Tag = 99
      Left = 80
      Top = 30
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnEnter = edtGruGpoEnter
      OnKeyPress = edtGruGpoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGpo: TEditFocus
      Left = 117
      Top = 30
      Width = 325
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlTotal: TPanel [3]
    Left = 0
    Top = 375
    Width = 651
    Height = 30
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label5: TLabel
      Left = 48
      Top = 8
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Totais:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtTotalAtu: TEditFocus
      Left = 352
      Top = 4
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotalTra: TEditFocus
      Left = 466
      Top = 4
      Width = 85
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotalTra2: TEditFocus
      Left = 552
      Top = 4
      Width = 85
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 57
    Width = 651
    Height = 318
    Align = alClient
    Color = 16770261
    TabOrder = 1
    object Label3: TLabel
      Left = 10
      Top = 196
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque-Vista:'
    end
    object Label1: TLabel
      Left = 13
      Top = 220
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque - Pr'#233':'
    end
    object Label4: TLabel
      Left = 44
      Top = 244
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cart'#227'o:'
    end
    object Label6: TLabel
      Left = 11
      Top = 268
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ordem Pagto.:'
    end
    object Label7: TLabel
      Left = 352
      Top = 5
      Width = 41
      Height = 14
      Caption = 'Vr. Atual'
    end
    object Label8: TLabel
      Left = 80
      Top = 5
      Width = 41
      Height = 14
      Caption = 'Portador'
    end
    object lblTransf1: TLabel
      Left = 466
      Top = 5
      Width = 61
      Height = 14
      Caption = 'Vr. Transf. 1'
    end
    object lblTransf2: TLabel
      Left = 552
      Top = 5
      Width = 61
      Height = 14
      Caption = 'Vr. Transf. 2'
    end
    object Label11: TLabel
      Left = 7
      Top = 292
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Financiamento:'
    end
    object edtChqVistaAtu: TEditFocus
      Left = 352
      Top = 193
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtChqPreAtu: TEditFocus
      Left = 352
      Top = 217
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCartaoAtu: TEditFocus
      Left = 352
      Top = 241
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object EdtOrdPagAtu: TEditFocus
      Left = 352
      Top = 265
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 21
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesPortadorChv: TEditFocus
      Left = 117
      Top = 193
      Width = 234
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPorChv: TEditFocus
      Tag = 99
      Left = 80
      Top = 193
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      OnExit = edtCodPorChvExit
      OnKeyPress = edtCodPorChvKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtCodPorChp: TEditFocus
      Tag = 99
      Left = 80
      Top = 217
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 7
      OnExit = edtCodPorChpExit
      OnKeyPress = edtCodPorChpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPortadorChp: TEditFocus
      Left = 117
      Top = 217
      Width = 234
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesPortadorCrt: TEditFocus
      Left = 117
      Top = 241
      Width = 234
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPorCrt: TEditFocus
      Tag = 99
      Left = 80
      Top = 241
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 13
      OnExit = edtCodPorCrtExit
      OnKeyPress = edtCodPorCrtKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtCodPorOrd: TEditFocus
      Tag = 99
      Left = 80
      Top = 265
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 19
      OnExit = edtCodPorOrdExit
      OnKeyPress = edtCodPorOrdKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPortadorOrd: TEditFocus
      Left = 117
      Top = 265
      Width = 234
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtChqVistaTra: TEditFocus
      Tag = 99
      Left = 466
      Top = 193
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtChqPreTra: TEditFocus
      Tag = 99
      Left = 466
      Top = 217
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCartaoTra: TEditFocus
      Tag = 99
      Left = 466
      Top = 241
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtOrdPagTra: TEditFocus
      Tag = 99
      Left = 466
      Top = 265
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 22
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtChqVistaTra2: TEditFocus
      Tag = 99
      Left = 552
      Top = 193
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtChqPreTra2: TEditFocus
      Tag = 99
      Left = 552
      Top = 217
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCartaoTra2: TEditFocus
      Tag = 99
      Left = 552
      Top = 241
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 18
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtOrdPagTra2: TEditFocus
      Tag = 99
      Left = 552
      Top = 265
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 23
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCodPorFin: TEditFocus
      Tag = 99
      Left = 80
      Top = 289
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 24
      OnExit = edtCodPorFinExit
      OnKeyPress = edtCodPorFinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPortadorFin: TEditFocus
      Left = 117
      Top = 289
      Width = 234
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 25
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValFinAtu: TEditFocus
      Left = 352
      Top = 289
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValFinTra: TEditFocus
      Tag = 99
      Left = 466
      Top = 289
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 27
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValFinTra2: TEditFocus
      Tag = 99
      Left = 552
      Top = 289
      Width = 85
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 28
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object GroupBox1: TGroupBox
      Left = 15
      Top = 19
      Width = 631
      Height = 170
      Caption = 'Dinheiro'
      TabOrder = 0
      object Label12: TLabel
        Left = 9
        Top = 45
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Guaranie:'
      end
      object Label13: TLabel
        Left = 28
        Top = 69
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dolar:'
      end
      object Label14: TLabel
        Left = 31
        Top = 93
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Euro:'
      end
      object Label15: TLabel
        Left = 29
        Top = 117
        Width = 27
        Height = 14
        Alignment = taRightJustify
        Caption = 'Peso:'
      end
      object Label16: TLabel
        Left = 32
        Top = 141
        Width = 24
        Height = 14
        Alignment = taRightJustify
        Caption = 'Real:'
      end
      object edtDinheiroAtu: TEditFocus
        Left = 337
        Top = 13
        Width = 89
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDinheiroTra: TEditFocus
        Tag = 99
        Left = 451
        Top = 13
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
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
      object edtCodPorGua: TEditFocus
        Tag = 99
        Left = 64
        Top = 42
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 3
        OnExit = edtCodPorGuaExit
        OnKeyPress = edtCodPorGuaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesPortadorGua: TEditFocus
        Left = 102
        Top = 42
        Width = 234
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtGuaAtu: TEditFocus
        Left = 337
        Top = 42
        Width = 89
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtGuaTra: TEditFocus
        Tag = 99
        Left = 451
        Top = 42
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtCodPorDol: TEditFocus
        Tag = 99
        Left = 64
        Top = 66
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 8
        OnExit = edtCodPorDolExit
        OnKeyPress = edtCodPorDolKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesPortadorDol: TEditFocus
        Left = 102
        Top = 66
        Width = 234
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDolAtu: TEditFocus
        Left = 337
        Top = 66
        Width = 89
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDolTra: TEditFocus
        Tag = 99
        Left = 451
        Top = 66
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtCodPorEur: TEditFocus
        Tag = 99
        Left = 64
        Top = 90
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 13
        OnExit = edtCodPorEurExit
        OnKeyPress = edtCodPorEurKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesPortadorEur: TEditFocus
        Left = 102
        Top = 90
        Width = 234
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 14
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEurAtu: TEditFocus
        Left = 337
        Top = 90
        Width = 89
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        ReadOnly = True
        TabOrder = 15
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtEurTra: TEditFocus
        Tag = 99
        Left = 451
        Top = 90
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtCodPorPes: TEditFocus
        Tag = 99
        Left = 64
        Top = 114
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 18
        OnExit = edtCodPorPesExit
        OnKeyPress = edtCodPorPesKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesPortadorPes: TEditFocus
        Left = 102
        Top = 114
        Width = 234
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 19
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPesAtu: TEditFocus
        Left = 337
        Top = 114
        Width = 89
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        ReadOnly = True
        TabOrder = 20
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPesTra: TEditFocus
        Tag = 99
        Left = 451
        Top = 114
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtCodPorRea: TEditFocus
        Tag = 99
        Left = 64
        Top = 138
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 23
        OnExit = edtCodPorReaExit
        OnKeyPress = edtCodPorReaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesPortadorRea: TEditFocus
        Left = 102
        Top = 138
        Width = 234
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 24
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtReaAtu: TEditFocus
        Left = 337
        Top = 138
        Width = 89
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        ReadOnly = True
        TabOrder = 25
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtReaTra: TEditFocus
        Tag = 99
        Left = 451
        Top = 138
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 26
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDinheiroTra2: TEditFocus
        Tag = 99
        Left = 537
        Top = 13
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtGuaTra2: TEditFocus
        Tag = 99
        Left = 537
        Top = 42
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDolTra2: TEditFocus
        Tag = 99
        Left = 537
        Top = 66
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtEurTra2: TEditFocus
        Tag = 99
        Left = 537
        Top = 90
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPesTra2: TEditFocus
        Tag = 99
        Left = 537
        Top = 114
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 22
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtReaTra2: TEditFocus
        Tag = 99
        Left = 537
        Top = 138
        Width = 85
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        TabOrder = 27
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
    object btnSelChAvi: TBitBtnLocked
      Left = 442
      Top = 193
      Width = 24
      Height = 21
      Hint = 'Selecionar Documentos...'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnSelChAviClick
    end
    object btnSelChPre: TBitBtnLocked
      Left = 442
      Top = 217
      Width = 23
      Height = 21
      Hint = 'Selecionar Documentos...'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btnSelChPreClick
    end
    object btnSelCartao: TBitBtnLocked
      Left = 442
      Top = 241
      Width = 24
      Height = 21
      Hint = 'Selecionar Documentos...'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      OnClick = btnSelCartaoClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 433
    Width = 651
    TabOrder = 4
    ExplicitTop = 433
    ExplicitWidth = 651
    inherited pnlNomeForm: TPanel
      Left = 480
      ExplicitLeft = 480
    end
    inherited pnlInfo: TPanel
      Width = 480
      ExplicitWidth = 480
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 65535
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 576
    Top = 65535
  end
  object cdsChqAVi: TUniClientDataSet
    Aggregates = <>
    Filter = 'MARDES = '#39'M'#39
    Params = <>
    Left = 444
    Top = 65535
  end
  object cdsChqPre: TUniClientDataSet
    Aggregates = <>
    Filter = 'MARDES = '#39'M'#39
    Params = <>
    Left = 476
    Top = 65535
  end
  object cdsCarCre: TUniClientDataSet
    Aggregates = <>
    Filter = 'MARDES = '#39'M'#39
    Params = <>
    Left = 508
    Top = 65535
  end
end
