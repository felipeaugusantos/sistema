inherited frmFatAltComissaoManualCTR: TfrmFatAltComissaoManualCTR
  Left = 482
  Top = 194
  Width = 685
  Height = 418
  Caption = 'Altera'#231#227'o de Comiss'#227'o Manual - Contas '#224' Receber'
  Position = poMainFormCenter
  ExplicitWidth = 685
  ExplicitHeight = 418
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 374
    Width = 679
    TabOrder = 5
    ExplicitTop = 372
    ExplicitWidth = 670
    inherited pnlInfo: TPanel [0]
      Width = 508
      ExplicitWidth = 499
    end
    inherited pnlNomeForm: TPanel [1]
      Left = 508
      ExplicitLeft = 499
    end
  end
  object pnlBusca: TPanel [1]
    Left = 0
    Top = 0
    Width = 679
    Height = 70
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitWidth = 670
    DesignSize = (
      679
      70)
    object lblDoc: TLabel
      Left = 9
      Top = 19
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object lblEmp: TLabel
      Left = 21
      Top = 45
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblEsp: TLabel
      Left = 184
      Top = 19
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object lblParcel: TLabel
      Left = 263
      Top = 19
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Parcela:'
    end
    object edtDocum: TEditFocus
      Tag = 99
      Left = 68
      Top = 15
      Width = 100
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 68
      Top = 41
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 3
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 227
      Top = 15
      Width = 28
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDesEmp: TEditFocus
      Left = 125
      Top = 41
      Width = 539
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      ExplicitWidth = 530
    end
    object edtParcel: TEditFocus
      Tag = 99
      Left = 304
      Top = 15
      Width = 33
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 70
    Width = 679
    Height = 91
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 1
    ExplicitWidth = 670
    DesignSize = (
      679
      91)
    object Label1: TLabel
      Left = 11
      Top = 7
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 11
      Top = 44
      Width = 72
      Height = 14
      Caption = 'Dt.Vencimento:'
    end
    object lbl2: TLabel
      Left = 115
      Top = 44
      Width = 60
      Height = 14
      Caption = 'Dt.Cadastro:'
    end
    object lbl3: TLabel
      Left = 441
      Top = 44
      Width = 78
      Height = 14
      Caption = 'Dt.Recebimento:'
    end
    object lbl4: TLabel
      Left = 219
      Top = 44
      Width = 75
      Height = 14
      Caption = 'Valor Duplicata:'
    end
    object lblValDupSemImposto: TLabel
      Left = 323
      Top = 44
      Width = 109
      Height = 14
      Caption = 'Valor Duplicata s/ Imp.:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 11
      Top = 21
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 5
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDtaVen: TEditFocus
      Tag = 99
      Left = 11
      Top = 58
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 77
      Top = 21
      Width = 587
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
      ExplicitWidth = 578
    end
    object edtDtaCad: TEditFocus
      Tag = 99
      Left = 115
      Top = 58
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDtaRec: TEditFocus
      Tag = 99
      Left = 441
      Top = 58
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValDup: TEditFocus
      Tag = 99
      Left = 219
      Top = 58
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtValSeI: TEditFocus
      Tag = 99
      Left = 323
      Top = 58
      Width = 109
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
  end
  object pnlComissoes: TPanel [3]
    Left = 0
    Top = 161
    Width = 679
    Height = 182
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 670
    object pnlComVe1: TPanel
      Left = 1
      Top = 1
      Width = 224
      Height = 91
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 10944511
      ParentBackground = False
      TabOrder = 0
      StyleElements = [seFont, seBorder]
      object lbl5: TLabel
        Left = 11
        Top = 7
        Width = 59
        Height = 14
        Caption = 'Vendedor 1:'
      end
      object lbl6: TLabel
        Left = 11
        Top = 44
        Width = 60
        Height = 14
        Caption = 'Comiss'#227'o %'
      end
      object lbl7: TLabel
        Left = 114
        Top = 44
        Width = 63
        Height = 14
        Caption = 'Comiss'#227'o R$'
      end
      object edtCodVe1: TEditFocus
        Tag = 99
        Left = 11
        Top = 21
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        Color = clBtnFace
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodVe1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtPerCo1: TEditFocus
        Tag = 99
        Left = 11
        Top = 58
        Width = 94
        Height = 22
        Alignment = taRightJustify
        Color = clBtnFace
        TabOrder = 2
        OnExit = edtPerCo1Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDesVe1: TEditFocus
        Left = 77
        Top = 21
        Width = 132
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
      object edtTotCo1: TEditFocus
        Tag = 99
        Left = 114
        Top = 58
        Width = 95
        Height = 22
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlComPa1: TPanel
      Left = 223
      Top = 1
      Width = 224
      Height = 91
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 13434828
      ParentBackground = False
      TabOrder = 1
      StyleElements = [seFont, seBorder]
      object lbl8: TLabel
        Left = 11
        Top = 7
        Width = 68
        Height = 14
        Caption = 'Participante 1:'
      end
      object lbl9: TLabel
        Left = 11
        Top = 44
        Width = 60
        Height = 14
        Caption = 'Comiss'#227'o %'
      end
      object lbl10: TLabel
        Left = 114
        Top = 44
        Width = 63
        Height = 14
        Caption = 'Comiss'#227'o R$'
      end
      object edtCodPa1: TEditFocus
        Tag = 99
        Left = 11
        Top = 21
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        Color = clBtnFace
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodVe1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtPerPa1: TEditFocus
        Tag = 99
        Left = 11
        Top = 58
        Width = 94
        Height = 22
        Alignment = taRightJustify
        Color = clBtnFace
        TabOrder = 2
        OnExit = edtPerCo1Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDesPa1: TEditFocus
        Left = 77
        Top = 21
        Width = 132
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
      object edtTotPa1: TEditFocus
        Tag = 99
        Left = 114
        Top = 58
        Width = 95
        Height = 22
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlComPj1: TPanel
      Left = 445
      Top = 1
      Width = 224
      Height = 91
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 10944511
      ParentBackground = False
      TabOrder = 2
      StyleElements = [seFont, seBorder]
      object lbl11: TLabel
        Left = 11
        Top = 7
        Width = 56
        Height = 14
        Caption = 'Projetista 1:'
      end
      object lbl12: TLabel
        Left = 11
        Top = 44
        Width = 60
        Height = 14
        Caption = 'Comiss'#227'o %'
      end
      object lbl13: TLabel
        Left = 114
        Top = 44
        Width = 63
        Height = 14
        Caption = 'Comiss'#227'o R$'
      end
      object edtCodPj1: TEditFocus
        Tag = 99
        Left = 11
        Top = 21
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        Color = clBtnFace
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodVe1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtPerPj1: TEditFocus
        Tag = 99
        Left = 11
        Top = 58
        Width = 94
        Height = 22
        Alignment = taRightJustify
        Color = clBtnFace
        TabOrder = 2
        OnExit = edtPerCo1Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDesPj1: TEditFocus
        Left = 77
        Top = 21
        Width = 132
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
      object edtTotPj1: TEditFocus
        Tag = 99
        Left = 114
        Top = 58
        Width = 95
        Height = 22
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlComPa2: TPanel
      Left = 1
      Top = 90
      Width = 224
      Height = 91
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 13434828
      ParentBackground = False
      TabOrder = 3
      StyleElements = [seFont, seBorder]
      object lbl14: TLabel
        Left = 11
        Top = 7
        Width = 68
        Height = 14
        Caption = 'Participante 2:'
      end
      object lbl15: TLabel
        Left = 11
        Top = 44
        Width = 60
        Height = 14
        Caption = 'Comiss'#227'o %'
      end
      object lbl16: TLabel
        Left = 114
        Top = 44
        Width = 63
        Height = 14
        Caption = 'Comiss'#227'o R$'
      end
      object edtCodPa2: TEditFocus
        Tag = 99
        Left = 11
        Top = 21
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        Color = clBtnFace
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodVe1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtPerPa2: TEditFocus
        Tag = 99
        Left = 11
        Top = 58
        Width = 94
        Height = 22
        Alignment = taRightJustify
        Color = clBtnFace
        TabOrder = 2
        OnExit = edtPerCo1Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDesPa2: TEditFocus
        Left = 77
        Top = 21
        Width = 132
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
      object edtTotPa2: TEditFocus
        Tag = 99
        Left = 114
        Top = 58
        Width = 95
        Height = 22
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlComPj2: TPanel
      Left = 223
      Top = 90
      Width = 224
      Height = 91
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 10944511
      ParentBackground = False
      TabOrder = 4
      StyleElements = [seFont, seBorder]
      object lbl17: TLabel
        Left = 11
        Top = 7
        Width = 56
        Height = 14
        Caption = 'Projetista 2:'
      end
      object lbl18: TLabel
        Left = 11
        Top = 44
        Width = 60
        Height = 14
        Caption = 'Comiss'#227'o %'
      end
      object lbl19: TLabel
        Left = 114
        Top = 44
        Width = 63
        Height = 14
        Caption = 'Comiss'#227'o R$'
      end
      object edtCodPj2: TEditFocus
        Tag = 99
        Left = 11
        Top = 21
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        Color = clBtnFace
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodVe1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtPerPj2: TEditFocus
        Tag = 99
        Left = 11
        Top = 58
        Width = 94
        Height = 22
        Alignment = taRightJustify
        Color = clBtnFace
        TabOrder = 2
        OnExit = edtPerCo1Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDesPj2: TEditFocus
        Left = 77
        Top = 21
        Width = 132
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
      object edtTotPj2: TEditFocus
        Tag = 99
        Left = 114
        Top = 58
        Width = 95
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlComVe2: TPanel
      Left = 445
      Top = 91
      Width = 224
      Height = 91
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 13434828
      ParentBackground = False
      TabOrder = 5
      StyleElements = [seFont, seBorder]
      object lbl20: TLabel
        Left = 11
        Top = 7
        Width = 59
        Height = 14
        Caption = 'Vendedor 2:'
      end
      object lbl21: TLabel
        Left = 11
        Top = 44
        Width = 60
        Height = 14
        Caption = 'Comiss'#227'o %'
      end
      object lbl22: TLabel
        Left = 114
        Top = 44
        Width = 63
        Height = 14
        Caption = 'Comiss'#227'o R$'
      end
      object edtCodVe2: TEditFocus
        Tag = 99
        Left = 11
        Top = 21
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        Color = clBtnFace
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodVe1KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesVe2: TEditFocus
        Left = 77
        Top = 21
        Width = 132
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
      object edtPerCo2: TEditFocus
        Tag = 99
        Left = 11
        Top = 58
        Width = 94
        Height = 22
        Alignment = taRightJustify
        Color = clBtnFace
        TabOrder = 2
        OnExit = edtPerCo1Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtTotCo2: TEditFocus
        Tag = 99
        Left = 114
        Top = 58
        Width = 95
        Height = 22
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
  end
  inherited pnlBotoes: TPanel
    Top = 346
    Width = 679
    TabOrder = 4
    ExplicitTop = 344
    ExplicitWidth = 670
    inherited FlwBotoes: TFlowPanel
      Width = 675
      TabOrder = 2
      ExplicitWidth = 666
    end
    inherited btnSair: TBitBtnLocked
      Left = 596
      ExplicitLeft = 590
    end
    object btnConfirma: TBitBtnLocked
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
      OnClick = btnConfirmaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
    Top = 8
  end
end
