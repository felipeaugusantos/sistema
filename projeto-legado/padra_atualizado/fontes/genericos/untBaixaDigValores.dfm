inherited frmBaixaDigValores: TfrmBaixaDigValores
  Left = 444
  Top = 301
  Width = 513
  Height = 239
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 513
  ExplicitHeight = 239
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 134
    Width = 507
    TabOrder = 5
    ExplicitTop = 134
    ExplicitWidth = 507
    DesignSize = (
      507
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 503
      ExplicitWidth = 503
    end
    inherited btnSair: TBitBtnLocked
      Left = 265
      ExplicitLeft = 265
    end
  end
  inherited pnlStatus: TPanel
    Top = 194
    Width = 507
    TabOrder = 2
    ExplicitTop = 194
    ExplicitWidth = 507
    inherited pnlNomeForm: TPanel
      Left = 350
      Width = 157
      ExplicitLeft = 350
      ExplicitWidth = 157
    end
    inherited pnlInfo: TPanel
      Width = 350
      ExplicitWidth = 350
    end
  end
  inherited pgcDados: TPageControl
    Width = 507
    Height = 134
    TabOrder = 1
    Visible = False
    ExplicitWidth = 507
    ExplicitHeight = 134
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 499
      ExplicitHeight = 102
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 166
    Width = 507
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 3
    DesignSize = (
      507
      28)
    object btnConfirmaDados: TBitBtnLocked
      Left = 7
      Top = 4
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
      OnKeyUp = btnConfirmaDadosKeyUp
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 424
      Top = 4
      Width = 77
      Height = 22
      Anchors = [akTop, akRight]
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
    Width = 507
    Height = 134
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    DesignSize = (
      507
      134)
    object ColorLabel2: TColorLabel
      Left = 122
      Top = 11
      Width = 74
      Height = 14
      Caption = '(T)otal (P)arcial'
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 370
      Top = 58
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Desconto:'
      ExplicitLeft = 322
    end
    object Label4: TLabel
      Left = 58
      Top = 59
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Juros:'
    end
    object Label3: TLabel
      Left = 7
      Top = 34
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Pagamento:'
    end
    object Label2: TLabel
      Left = 364
      Top = 34
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Valor Pago:'
      ExplicitLeft = 316
    end
    object Label1: TLabel
      Left = 20
      Top = 11
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Baixa:'
    end
    object lblVendor: TLabel
      Left = 381
      Top = 10
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Vendor:'
      ExplicitLeft = 333
    end
    object Label12: TLabel
      Left = 193
      Top = 57
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desp. Cob.:'
    end
    object Label13: TLabel
      Left = 206
      Top = 14
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Out. Ent.:'
      Visible = False
    end
    object lblMulta: TLabel
      Left = 222
      Top = 34
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Multa:'
    end
    object edtValDes: TEditFocus
      Left = 423
      Top = 54
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      OnChange = edtValDesChange
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtValJur: TEditFocus
      Left = 91
      Top = 55
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtValPag: TEditFocus
      Tag = 99
      Left = 423
      Top = 31
      Width = 78
      Height = 22
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      TabOrder = 2
      OnEnter = edtValPagEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTipBai: TEditFocus
      Tag = 99
      Left = 91
      Top = 7
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      Text = 'T'
      OnChange = edtTipBaiChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object rgpTipDes: TRadioGroup
      Left = 11
      Top = 78
      Width = 490
      Height = 48
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Tipo de Desconto'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Devolu'#231#227'o'
        'Bonifica'#231#227'o'
        'Outros')
      TabOrder = 6
    end
    object edtVendor: TEditFocus
      Left = 423
      Top = 8
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 7
      OnChange = edtValDesChange
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object mskDtaPag: TcxDateEdit
      Tag = 99
      Left = 91
      Top = 30
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
      TabOrder = 1
      Width = 90
    end
    object edtValCob: TEditFocus
      Tag = 99
      Left = 252
      Top = 54
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtOutrasEntidades: TEditFocus
      Left = 252
      Top = 8
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      Visible = False
      OnChange = edtValDesChange
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtValMul: TEditFocus
      Left = 252
      Top = 31
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 9
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
  object pnlJuros: TPanel [5]
    Left = 0
    Top = 134
    Width = 507
    Height = 32
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    DesignSize = (
      507
      32)
    object lblMultaCad: TLabel
      Left = 242
      Top = 10
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Multa Cad.:'
      Visible = False
    end
    object Label6: TLabel
      Left = 8
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vl.Orig:'
    end
    object Label7: TLabel
      Left = 167
      Top = 10
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Juros Cad.:'
    end
    object Label8: TLabel
      Left = 369
      Top = 10
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Desc.Cad.:'
      ExplicitLeft = 407
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
    object edtTotalizaMulSuj: TEditFocus
      Left = 225
      Top = 5
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 6
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
    object edtTotalizaValOri: TEditFocus
      Left = 44
      Top = 5
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
      Left = 225
      Top = 5
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
      Left = 423
      Top = 5
      Width = 78
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
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
    Left = 192
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 160
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 208
  end
end
