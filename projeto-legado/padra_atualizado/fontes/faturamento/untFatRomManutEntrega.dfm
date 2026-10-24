inherited frmFatRomManutEntrega: TfrmFatRomManutEntrega
  Left = 313
  Top = 381
  Width = 625
  Height = 312
  Caption = 'Romaneio - Manuten'#231#227'o da Entrega'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 625
  ExplicitHeight = 312
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 241
    Width = 619
    Height = 26
    TabOrder = 2
    ExplicitTop = 241
    ExplicitWidth = 619
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 504
      Height = 22
      ExplicitWidth = 504
      ExplicitHeight = 22
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 111
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 506
      Top = 2
      Width = 111
      Align = alRight
      Caption = 'C&ancela'
      ExplicitLeft = 506
      ExplicitTop = 2
      ExplicitWidth = 111
    end
  end
  inherited pnlStatus: TPanel
    Top = 267
    Width = 619
    TabOrder = 3
    ExplicitTop = 267
    ExplicitWidth = 619
    inherited pnlNomeForm: TPanel
      Left = 369
      Width = 250
      ExplicitLeft = 369
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 369
      ExplicitWidth = 369
    end
  end
  object pnlDigDoc: TPanel [2]
    Left = 0
    Top = 0
    Width = 619
    Height = 205
    Align = alClient
    Color = 16770261
    TabOrder = 0
    TabStop = True
    object Label1: TLabel
      Left = 0
      Top = 14
      Width = 79
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'N'#186' Documento:'
    end
    object lblCodEmp: TLabel
      Left = 14
      Top = 38
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 181
      Top = 14
      Width = 41
      Height = 14
      AutoSize = False
      Caption = 'Esp'#233'cie:'
    end
    object Label6: TLabel
      Left = 15
      Top = 62
      Width = 64
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 9
      Top = 86
      Width = 70
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Emiss'#227'o:'
    end
    object Label5: TLabel
      Left = 153
      Top = 86
      Width = 35
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor:'
    end
    object Label3: TLabel
      Left = 9
      Top = 110
      Width = 70
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cond. Pagto:'
    end
    object Label7: TLabel
      Left = 14
      Top = 134
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Vendedor:'
    end
    object Label12: TLabel
      Left = 8
      Top = 158
      Width = 133
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Entregar no faturamento?'
    end
    object ColorLabel1: TColorLabel
      Left = 185
      Top = 158
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object lbl1: TLabel
      Left = 305
      Top = 158
      Width = 88
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Previs'#227'o:'
    end
    object lblTurno: TLabel
      Left = 470
      Top = 158
      Width = 31
      Height = 14
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Alignment = taRightJustify
      Caption = 'Turno:'
    end
    object lblCliBus: TLabel
      Left = 54
      Top = 182
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente vai retirar?'
      Visible = False
    end
    object lblLocRet: TLabel
      Left = 248
      Top = 182
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Local Retira:'
      Visible = False
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 83
      Top = 10
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      OnEnter = edtNumDocEnter
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
      Left = 83
      Top = 34
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 149
      Top = 34
      Width = 458
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 224
      Top = 10
      Width = 30
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
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 83
      Top = 58
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 8
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 149
      Top = 58
      Width = 458
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaEmi: TMaskEditFocus
      Tag = 99
      Left = 83
      Top = 82
      Width = 65
      Height = 22
      Enabled = False
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtValDoc: TEditFocus
      Tag = 99
      Left = 192
      Top = 82
      Width = 74
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 6
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 83
      Top = 106
      Width = 524
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;_'
      MaxLength = 98
      ReadOnly = True
      TabOrder = 8
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNomVen: TEditFocus
      Left = 149
      Top = 130
      Width = 458
      Height = 22
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 83
      Top = 130
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 3
      ReadOnly = True
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtEntFat: TEditFocus
      Tag = 99
      Left = 149
      Top = 154
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object mskDtaPre: TMaskEditFocus
      Tag = 99
      Left = 399
      Top = 154
      Width = 65
      Height = 22
      Enabled = False
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 13
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object cmbTurEnt: TComboBoxFocus
      Tag = 99
      Left = 504
      Top = 154
      Width = 75
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 14
      Items.Strings = (
        'Manh'#227
        'Tarde'
        'Noite')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkUrgente: TCheckBox
      Left = 248
      Top = 158
      Width = 65
      Height = 17
      Caption = 'Urgente'
      TabOrder = 12
    end
    object cmbCliBus: TComboBoxFocus
      Tag = 99
      Left = 149
      Top = 178
      Width = 46
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 15
      Visible = False
      Items.Strings = (
        'N'#195'O'
        'SIM')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbLocRet: TComboBoxFocus
      Tag = 99
      Left = 312
      Top = 178
      Width = 152
      Height = 22
      Style = csDropDownList
      Color = clWhite
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 16
      Visible = False
      Items.Strings = (
        'CAIXA'
        'EXPEDI'#199#195'O'
        'BALC'#195'O'
        'BALC'#195'O 2')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  object pnlMotivoDaAlteracao: TPanel [3]
    Left = 0
    Top = 205
    Width = 619
    Height = 36
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      619
      36)
    object lblMotivoDaAlteracao: TLabel
      Left = 8
      Top = 11
      Width = 98
      Height = 14
      Alignment = taCenter
      Caption = 'Motivo da Altera'#231#227'o:'
    end
    object edtCodOco: TEditFocus
      Tag = 99
      Left = 110
      Top = 7
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnExit = edtCodOcoExit
      OnKeyPress = edtCodOcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesOco: TEditFocus
      Left = 176
      Top = 7
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
    object btnAlteracoes: TBitBtnLocked
      Left = 571
      Top = 7
      Width = 42
      Height = 22
      Caption = '...'
      TabOrder = 2
      OnClick = btnAlteracoesClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 336
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 8
  end
end
