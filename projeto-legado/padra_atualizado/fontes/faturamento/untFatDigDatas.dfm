inherited frmFatDigDatas: TfrmFatDigDatas
  Left = 326
  Top = 264
  Width = 387
  Height = 352
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Digite as Datas'
  Position = poMainFormCenter
  OnKeyUp = FormKeyUp
  ExplicitWidth = 387
  ExplicitHeight = 352
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 279
    Width = 381
    ExplicitTop = 242
    ExplicitWidth = 381
    inherited FlwBotoes: TFlowPanel
      Width = 377
      ExplicitWidth = 377
    end
    inherited btnSair: TBitBtnLocked
      Left = 256
      ExplicitLeft = 256
    end
  end
  inherited pnlStatus: TPanel
    Top = 307
    Width = 381
    TabOrder = 3
    ExplicitTop = 270
    ExplicitWidth = 381
    inherited pnlNomeForm: TPanel
      Left = 229
      Width = 152
      ExplicitLeft = 229
      ExplicitWidth = 152
    end
    inherited pnlInfo: TPanel
      Width = 229
      ExplicitWidth = 229
    end
  end
  inherited pgcDados: TPageControl
    Width = 381
    Height = 279
    TabOrder = 1
    Visible = False
    ExplicitWidth = 381
    ExplicitHeight = 242
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 373
      ExplicitHeight = 210
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 279
    Width = 381
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 242
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
      Left = 297
      Top = 3
      Width = 77
      Height = 22
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
    Width = 381
    Height = 279
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 242
    object lblInformacao: TLabel
      Left = 2
      Top = 255
      Width = 377
      Height = 14
      Align = alTop
      Caption = 'Para devolu'#231#227'o fora do prazo, informe o documento diretamente.'
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Visible = False
      ExplicitTop = 224
      ExplicitWidth = 313
    end
    object pnlNumDoc: TPanel
      Left = 2
      Top = 86
      Width = 377
      Height = 52
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      ExplicitTop = 55
      object Label3: TLabel
        Left = 86
        Top = 8
        Width = 57
        Height = 14
        Caption = 'Documento:'
      end
      object Label5: TLabel
        Left = 117
        Top = 32
        Width = 26
        Height = 14
        Caption = 'COO:'
      end
      object lblCodEmpresa: TLabel
        Left = 2
        Top = 8
        Width = 45
        Height = 14
        Caption = 'Empresa:'
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 149
        Top = 4
        Width = 90
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 12
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 240
        Top = 4
        Width = 32
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 2
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttAlfabetico
      end
      object edtNumCoo: TEditFocus
        Tag = 99
        Left = 149
        Top = 28
        Width = 90
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 9
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 9
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 47
        Top = 4
        Width = 34
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
    end
    object pnlDatas: TPanel
      Left = 2
      Top = 138
      Width = 377
      Height = 43
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      ExplicitTop = 107
      object lblDtaIni: TLabel
        Left = 16
        Top = 8
        Width = 54
        Height = 14
        Caption = 'Data Inicial:'
      end
      object lblDtaFin: TLabel
        Left = 185
        Top = 8
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Final:'
      end
      object lblMsgOF: TLabel
        Left = 9
        Top = 27
        Width = 301
        Height = 14
        Alignment = taCenter
        Caption = '(Per'#237'odo em branco n'#227'o carrega os itens de notas de entrada)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 77
        Top = 4
        Width = 66
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 239
        Top = 4
        Width = 68
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object pnlDevCom: TPanel
      Left = 2
      Top = 181
      Width = 377
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      ExplicitTop = 150
      object chkDevCom: TCheckBox
        Left = 16
        Top = 1
        Width = 297
        Height = 17
        Caption = 'Devolver documentos completamente?'
        TabOrder = 0
        OnClick = chkDevComClick
      end
    end
    object pnlPigBas: TPanel
      Left = 2
      Top = 199
      Width = 377
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      Visible = False
      ExplicitTop = 168
      object chkPigBas: TCheckBox
        Left = 16
        Top = -1
        Width = 297
        Height = 17
        Caption = 'Deseja baixar Pigmento/Base?'
        Color = 16770261
        ParentColor = False
        TabOrder = 0
      end
    end
    object pnlConsumidor: TPanel
      Left = 2
      Top = 217
      Width = 377
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      ExplicitTop = 186
      object Label4: TLabel
        Left = 16
        Top = 2
        Width = 118
        Height = 14
        Caption = 'Consumidor (CGC / CPF)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodCliCon: TEditFocus
        Tag = 99
        Left = 16
        Top = 16
        Width = 96
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 18
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodCliConKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 18
        TipoTexto = ttNumerico
      end
      object edtNomCliCon: TEditFocus
        Tag = 99
        Left = 113
        Top = 16
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
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
    end
    object pnlCodigosViaLeitor: TPanel
      Left = 2
      Top = 33
      Width = 377
      Height = 53
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      ExplicitTop = 2
      object lblChaAce: TLabel
        Left = 5
        Top = 7
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Caption = 'Chave de Acesso:'
      end
      object lblQRCode: TLabel
        Left = 11
        Top = 30
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'QR Code (NFCe):'
      end
      object edtChaAce: TEditFocus
        Tag = 99
        Left = 97
        Top = 4
        Width = 275
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 0
        OnKeyPress = edtChaAceKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQrCode: TEditFocus
        Tag = 99
        Left = 97
        Top = 27
        Width = 275
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 1
        OnKeyPress = edtQrCodeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlRemessaDevolucao: TPanel
      Left = 2
      Top = 2
      Width = 377
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      ExplicitLeft = 4
      ExplicitTop = 10
      object Label1: TLabel
        Left = 5
        Top = 7
        Width = 117
        Height = 14
        Alignment = taRightJustify
        Caption = 'Remessa de Devolu'#231#227'o:'
      end
      object edtRemessaDevolucao: TEditFocus
        Left = 128
        Top = 3
        Width = 244
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 12
        TabOrder = 0
        OnExit = edtRemessaDevolucaoExit
        OnKeyPress = edtRemessaDevolucaoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 12
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 104
  end
end
