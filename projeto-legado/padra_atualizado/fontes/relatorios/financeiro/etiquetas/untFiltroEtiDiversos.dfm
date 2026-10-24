inherited frmFiltroEtiDiversos: TfrmFiltroEtiDiversos
  Left = 323
  Top = 223
  Width = 361
  Height = 347
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 361
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 303
    Width = 355
    ExplicitTop = 303
    ExplicitWidth = 355
    inherited btnSair: TBitBtnLocked
      Left = 284
      ExplicitLeft = 284
    end
  end
  inherited pnlStatus: TPanel
    Top = 303
    Width = 355
    TabOrder = 3
    ExplicitTop = 303
    ExplicitWidth = 355
    inherited pnlNomeForm: TPanel
      Left = 179
      Width = 176
      ExplicitLeft = 179
      ExplicitWidth = 176
    end
    inherited pnlInfo: TPanel
      Width = 179
      ExplicitWidth = 179
    end
  end
  inherited pgcDados: TPageControl
    Width = 355
    Height = 303
    TabOrder = 1
    Visible = False
    ExplicitWidth = 355
    ExplicitHeight = 303
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 347
      ExplicitHeight = 271
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 355
    Height = 303
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 22
      Top = 12
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Inicial:'
    end
    object Label2: TLabel
      Left = 26
      Top = 35
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Final:'
    end
    object Label6: TLabel
      Left = 45
      Top = 58
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label8: TLabel
      Left = 49
      Top = 104
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label9: TLabel
      Left = 45
      Top = 127
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label10: TLabel
      Left = 5
      Top = 274
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Etiquetas:'
    end
    object Label4: TLabel
      Left = 33
      Top = 81
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object edtNomIni: TEditFocus
      Tag = 99
      Left = 84
      Top = 8
      Width = 257
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFin: TEditFocus
      Tag = 99
      Left = 84
      Top = 31
      Width = 257
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 84
      Top = 54
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 84
      Top = 100
      Width = 257
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Tag = 99
      Left = 84
      Top = 123
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 80
      Top = 270
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomCid: TEditFocus
      Left = 131
      Top = 54
      Width = 210
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkMosFil: TCheckBox
      Left = 80
      Top = 250
      Width = 261
      Height = 17
      Caption = 'Mostrar apenas registros que satisfazem o filtro'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object gpbAniv: TGroupBox
      Left = 84
      Top = 199
      Width = 185
      Height = 49
      Caption = 'Anivers'#225'rio (Dia/M'#234's)'
      TabOrder = 7
      object lbl1: TLabel
        Left = 8
        Top = 20
        Width = 29
        Height = 14
        Caption = 'Inicial:'
      end
      object lbl2: TLabel
        Left = 100
        Top = 20
        Width = 25
        Height = 14
        Caption = 'Final:'
      end
      object mskAniIni: TMaskEditFocus
        Tag = 99
        Left = 40
        Top = 16
        Width = 44
        Height = 22
        EditMask = '!99/99;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        Text = '  /  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskAniFin: TMaskEditFocus
        Tag = 99
        Left = 128
        Top = 16
        Width = 44
        Height = 22
        EditMask = '!99/99;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 1
        Text = '  /  '
        OnExit = FormCreate
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object gpb1: TGroupBox
      Left = 84
      Top = 148
      Width = 257
      Height = 49
      Caption = 'Per'#237'odo de Venda'
      TabOrder = 6
      object lbl3: TLabel
        Left = 8
        Top = 20
        Width = 29
        Height = 14
        Caption = 'Inicial:'
      end
      object lbl4: TLabel
        Left = 139
        Top = 20
        Width = 25
        Height = 14
        Caption = 'Final:'
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 40
        Top = 16
        Width = 78
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
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
        Left = 168
        Top = 16
        Width = 78
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 84
      Top = 77
      Width = 46
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 3
      OnExit = edtCodAtiExit
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomAti: TEditFocus
      Left = 131
      Top = 77
      Width = 210
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 0
  end
end
