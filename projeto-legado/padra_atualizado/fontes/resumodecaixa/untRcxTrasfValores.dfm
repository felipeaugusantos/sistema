inherited frmRcxTrasfValores: TfrmRcxTrasfValores
  Left = 220
  Top = 271
  Width = 739
  Height = 518
  BorderIcons = [biSystemMenu]
  Caption = 'Transfer'#234'ncia de Valores'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 739
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 426
    Width = 733
    Height = 47
    TabOrder = 9
    ExplicitTop = 423
    ExplicitWidth = 733
    ExplicitHeight = 47
    DesignSize = (
      733
      47)
    inherited FlwBotoes: TFlowPanel
      Width = 729
      Height = 43
      TabOrder = 5
      ExplicitLeft = 3
      ExplicitTop = -1
      ExplicitWidth = 729
      ExplicitHeight = 47
    end
    inherited btnSair: TBitBtnLocked
      Left = 652
      Width = 75
      Height = 40
      TabOrder = 4
      ExplicitLeft = 652
      ExplicitWidth = 75
      ExplicitHeight = 40
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 75
      Height = 40
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
      Left = 78
      Top = 3
      Width = 116
      Height = 40
      Caption = '[ F9 ] Alterar seq. fechamento parcial'
      TabOrder = 1
      WordWrap = True
      OnClick = btnAltSeqFecClick
    end
    object btnCancTranf: TBitBtnLocked
      Left = 194
      Top = 3
      Width = 126
      Height = 40
      Caption = '[ F8 ] Cancelamento de transfer'#234'ncias'
      TabOrder = 2
      WordWrap = True
      OnClick = btnCancTranfClick
    end
    object btnConsTran: TBitBtnLocked
      Left = 320
      Top = 3
      Width = 142
      Height = 40
      Caption = '[ F7 ] Consulta Transfer'#234'ncias Pendentes'
      TabOrder = 3
      WordWrap = True
      OnClick = btnConsTranClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 473
    Width = 733
    TabOrder = 4
    ExplicitTop = 416
    ExplicitWidth = 733
    inherited pnlNomeForm: TPanel
      Left = 562
      ExplicitLeft = 562
    end
    inherited pnlInfo: TPanel
      Width = 562
      ExplicitWidth = 562
    end
  end
  object pnlPortador: TPanel [2]
    Left = 0
    Top = 0
    Width = 733
    Height = 73
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label10: TLabel
      Left = 39
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
      Left = 29
      Top = 34
      Width = 59
      Height = 14
      Alignment = taRightJustify
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
      Left = 89
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
      Left = 126
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
      Left = 89
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
      Left = 126
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
    object chkFechamento: TCheckBox
      Left = 89
      Top = 52
      Width = 190
      Height = 17
      Caption = 'Transfer'#234'ncia de Fechamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkFechamentoClick
    end
  end
  object pnlTotal: TPanel [3]
    Left = 0
    Top = 273
    Width = 733
    Height = 36
    Align = alClient
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    ExplicitHeight = 30
    object Label5: TLabel
      Left = 57
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
      Left = 361
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
      Left = 475
      Top = 4
      Width = 80
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
      Left = 561
      Top = 4
      Width = 80
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
    Top = 73
    Width = 733
    Height = 170
    Align = alTop
    Color = 16770261
    TabOrder = 1
    ExplicitTop = 71
    object Label2: TLabel
      Left = 46
      Top = 22
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dinheiro:'
    end
    object Label3: TLabel
      Left = 19
      Top = 46
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque-Vista:'
    end
    object Label1: TLabel
      Left = 22
      Top = 70
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque - Pr'#233':'
    end
    object Label4: TLabel
      Left = 53
      Top = 94
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cart'#227'o:'
    end
    object Label6: TLabel
      Left = 20
      Top = 118
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ordem Pagto.:'
    end
    object Label7: TLabel
      Left = 361
      Top = 4
      Width = 41
      Height = 14
      Caption = 'Vr. Atual'
    end
    object Label8: TLabel
      Left = 89
      Top = 4
      Width = 41
      Height = 14
      Caption = 'Portador'
    end
    object lblTransf1: TLabel
      Left = 475
      Top = 4
      Width = 61
      Height = 14
      Caption = 'Vr. Transf. 1'
    end
    object lblTransf2: TLabel
      Left = 561
      Top = 4
      Width = 61
      Height = 14
      Caption = 'Vr. Transf. 2'
    end
    object Label11: TLabel
      Left = 16
      Top = 142
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Financiamento:'
    end
    object edtDinheiroAtu: TEditFocus
      Left = 361
      Top = 18
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtChqVistaAtu: TEditFocus
      Left = 361
      Top = 42
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
    object edtChqPreAtu: TEditFocus
      Left = 361
      Top = 66
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
    object edtCartaoAtu: TEditFocus
      Left = 361
      Top = 90
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 22
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
      Left = 361
      Top = 114
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 23
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtCodPorDin: TEditFocus
      Tag = 99
      Left = 89
      Top = 18
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
      TabOrder = 0
      OnExit = edtCodPorDinExit
      OnKeyPress = edtCodPorDinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPortadorDin: TEditFocus
      Left = 126
      Top = 18
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
    object edtDesPortadorChv: TEditFocus
      Left = 126
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
      TabOrder = 25
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
      Left = 89
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
      Left = 89
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
      Left = 126
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
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesPortadorCrt: TEditFocus
      Left = 126
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
      TabOrder = 27
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
      Left = 89
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
      TabOrder = 11
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
      Left = 89
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
      TabOrder = 15
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
      Left = 126
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
      TabOrder = 28
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDinheiroTra: TEditFocus
      Tag = 99
      Left = 475
      Top = 18
      Width = 80
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
    object edtChqVistaTra: TEditFocus
      Tag = 99
      Left = 475
      Top = 42
      Width = 80
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
      Left = 475
      Top = 66
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 9
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
      Left = 475
      Top = 90
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 13
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
      Left = 475
      Top = 114
      Width = 80
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
    object edtDinheiroTra2: TEditFocus
      Tag = 99
      Left = 561
      Top = 18
      Width = 80
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
    object edtChqVistaTra2: TEditFocus
      Tag = 99
      Left = 561
      Top = 42
      Width = 80
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
      Left = 561
      Top = 66
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 10
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
      Left = 561
      Top = 90
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 14
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
      Left = 561
      Top = 114
      Width = 80
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
    object edtCodPorFin: TEditFocus
      Tag = 99
      Left = 89
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
      TabOrder = 29
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
      Left = 126
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
      TabOrder = 30
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValFinAtu: TEditFocus
      Left = 361
      Top = 138
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 31
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
      Left = 475
      Top = 138
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 32
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
      Left = 561
      Top = 138
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 33
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnSelChAvi: TBitBtnLocked
      Left = 451
      Top = 42
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
      TabOrder = 4
      OnClick = btnSelChAviClick
    end
    object btnSelChPre: TBitBtnLocked
      Left = 451
      Top = 66
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
      Left = 451
      Top = 90
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
      TabOrder = 12
      OnClick = btnSelCartaoClick
    end
    object chkPixAvulso: TCheckBox
      Left = 646
      Top = 118
      Width = 73
      Height = 17
      Hint = 'Filtrar saldo dos lan'#231'amentos feitos por Pix Avulso.'
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = 'Pix Avulso:'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      OnClick = chkPixAvulsoClick
    end
  end
  object pnlMensagem: TPanel [5]
    Left = 0
    Top = 309
    Width = 733
    Height = 22
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    ExplicitTop = 303
    object Label12: TLabel
      Left = 1
      Top = 1
      Width = 731
      Height = 20
      Align = alClient
      Alignment = taCenter
      Caption = 
        'O valor atual da transfer'#234'ncia em dinheiro est'#225' oculto, pois o s' +
        'istema est'#225' configurado para utilizar Transfer'#234'ncia Cega.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqAntialiased
      ParentFont = False
      Layout = tlCenter
      ExplicitTop = -3
    end
  end
  object pnlFundoDeCaixa: TPanel [6]
    Left = 0
    Top = 243
    Width = 733
    Height = 30
    Align = alTop
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label13: TLabel
      Left = 10
      Top = 8
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fundo de Caixa:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtFundoDeCaixaAtualizado: TEditFocus
      Left = 361
      Top = 4
      Width = 89
      Height = 22
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
  end
  object pnlMensagemSaldoDinheiro: TPanel [7]
    Left = 0
    Top = 331
    Width = 733
    Height = 22
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    ExplicitTop = 325
    object lblMensagemSaldoDinheiro: TLabel
      Left = 1
      Top = 1
      Width = 731
      Height = 20
      Align = alClient
      Alignment = taCenter
      Caption = 
        'O saldo a transferir em Dinheiro possui X referente ao saldo do ' +
        'fechamento anterior, feito pelo operador Y'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqAntialiased
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 445
      ExplicitHeight = 12
    end
  end
  object pnlSaldoNegativoOperador: TPanel [8]
    Left = 0
    Top = 375
    Width = 733
    Height = 51
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    StyleElements = [seClient, seBorder]
    ExplicitTop = 372
    object lblSaldoNegativoOperador: TLabel
      Left = 1
      Top = 1
      Width = 731
      Height = 49
      Align = alClient
      Alignment = taCenter
      Caption = 'ATEN'#199#195'O: Saldo negativo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqAntialiased
      ParentFont = False
      Layout = tlCenter
      StyleElements = [seBorder]
      ExplicitLeft = 6
      ExplicitTop = -4
    end
  end
  object pnlMensagemSaldoOrdemPagamento: TPanel [9]
    Left = 0
    Top = 353
    Width = 733
    Height = 22
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    ExplicitTop = 396
    object lblMensagemSaldoOrdemPagamento: TLabel
      Left = 1
      Top = 1
      Width = 731
      Height = 20
      Align = alClient
      Alignment = taCenter
      Caption = 
        'O saldo a transferir em Ordem Pagto. possui X referente ao saldo' +
        ' do fechamento anterior, feito pelo operador Y'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqAntialiased
      ParentFont = False
      Layout = tlCenter
      ExplicitTop = 2
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
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 48
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
