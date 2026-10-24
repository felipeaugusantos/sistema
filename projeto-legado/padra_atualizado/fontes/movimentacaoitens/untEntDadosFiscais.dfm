inherited frmEntDadosFiscais: TfrmEntDadosFiscais
  Left = 152
  Top = 180
  Width = 1008
  Height = 620
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Dados fiscais do Item'
  Position = poMainFormCenter
  ExplicitWidth = 1008
  ExplicitHeight = 620
  PixelsPerInch = 96
  TextHeight = 14
  object pgbDadosFiscais: TProgressBar [0]
    Left = 0
    Top = 297
    Width = 1002
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 297
    Width = 1002
    ExplicitTop = 297
    ExplicitWidth = 1002
    DesignSize = (
      1002
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 998
      ExplicitWidth = 998
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 575
    Width = 1002
    ExplicitTop = 575
    ExplicitWidth = 1002
    inherited pnlNomeForm: TPanel
      Left = 792
      Width = 210
      ExplicitLeft = 792
      ExplicitWidth = 210
    end
    inherited pnlInfo: TPanel
      Width = 792
      ExplicitWidth = 792
    end
  end
  inherited pgcDados: TPageControl
    Top = 191
    Width = 1002
    Height = 106
    Visible = False
    ExplicitTop = 191
    ExplicitWidth = 1002
    ExplicitHeight = 106
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 994
      ExplicitHeight = 74
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 19
    Width = 1002
    Height = 172
    Align = alTop
    Color = 16770261
    TabOrder = 4
    object lblTotIte: TLabel
      Left = 40
      Top = 13
      Width = 72
      Height = 14
      Caption = 'Total dos Itens:'
    end
    object Label4: TLabel
      Left = 67
      Top = 36
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
    end
    object Label5: TLabel
      Left = 318
      Top = 36
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desp. Acess.:'
    end
    object Label6: TLabel
      Left = 359
      Top = 13
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Frete:'
    end
    object Label8: TLabel
      Left = 710
      Top = 13
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label21: TLabel
      Left = 325
      Top = 82
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Substitui'#231#227'o:'
    end
    object Label22: TLabel
      Left = 334
      Top = 59
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total de IPI:'
    end
    object Label23: TLabel
      Left = 54
      Top = 105
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Liquido:'
    end
    object lblTotAnt: TLabel
      Left = 32
      Top = 129
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'ICMS Antecipado:'
    end
    object lblBasPis: TLabel
      Left = 747
      Top = 37
      Width = 17
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pis:'
    end
    object lblBasCof: TLabel
      Left = 730
      Top = 59
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cofins:'
    end
    object lblAlqPis: TLabel
      Left = 837
      Top = 36
      Width = 19
      Height = 14
      Alignment = taRightJustify
      Caption = 'Alq:'
    end
    object lblAlqCof: TLabel
      Left = 837
      Top = 59
      Width = 19
      Height = 14
      Alignment = taRightJustify
      Caption = 'Alq:'
    end
    object lblTotPis: TLabel
      Left = 905
      Top = 36
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
    end
    object lblTotCof: TLabel
      Left = 905
      Top = 59
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
    end
    object lblDtaAnt: TLabel
      Left = 186
      Top = 128
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vencim. ICMS Ant.:'
    end
    object lblTotDes: TLabel
      Left = 189
      Top = 13
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Descontos:'
    end
    object lblIcmDes: TLabel
      Left = 27
      Top = 59
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'ICMS Desonerado:'
    end
    object lblDesPis: TLabel
      Left = 9
      Top = 82
      Width = 107
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto PIS/COFINS:'
    end
    object lblPisCofinsCalcPorCfg: TLabel
      Left = 460
      Top = 106
      Width = 348
      Height = 14
      Caption = 
        'PIS/COFINS Calculado com base no XML do Fornecedor e Configura'#231#227 +
        'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object edtTotIte: TEditFocus
      Tag = 99
      Left = 119
      Top = 9
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
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
    object edtDesEsp: TEditFocus
      Tag = 99
      Left = 119
      Top = 32
      Width = 64
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
      OnExit = edtDesEspExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesAce: TEditFocus
      Tag = 99
      Left = 390
      Top = 32
      Width = 64
      Height = 22
      Alignment = taRightJustify
      TabOrder = 9
      OnExit = edtDesAceExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValFre: TEditFocus
      Tag = 99
      Left = 390
      Top = 9
      Width = 64
      Height = 22
      Alignment = taRightJustify
      TabOrder = 7
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
    object edtTotGer: TEditFocus
      Tag = 99
      Left = 768
      Top = 9
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotRet: TEditFocus
      Tag = 99
      Left = 390
      Top = 78
      Width = 64
      Height = 22
      Alignment = taRightJustify
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
    object edtTotLiq: TEditFocus
      Tag = 99
      Left = 119
      Top = 101
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
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
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotIpi: TEditFocus
      Tag = 99
      Left = 390
      Top = 55
      Width = 64
      Height = 22
      Alignment = taRightJustify
      TabOrder = 11
      OnExit = edtTotIpiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtBasCof: TEditFocus
      Tag = 99
      Left = 768
      Top = 55
      Width = 64
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
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
    object edtBasPis: TEditFocus
      Tag = 99
      Left = 768
      Top = 32
      Width = 64
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
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
    object edtAlqCof: TEditFocus
      Tag = 99
      Left = 858
      Top = 55
      Width = 40
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 20
      OnExit = edtAlqCofExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.0000'
    end
    object edtAlqPis: TEditFocus
      Tag = 99
      Left = 858
      Top = 31
      Width = 40
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 19
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.0000'
    end
    object edtTotCof: TEditFocus
      Tag = 99
      Left = 931
      Top = 55
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
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
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTotPis: TEditFocus
      Tag = 99
      Left = 931
      Top = 32
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
    object chkFreTri: TCheckBox
      Tag = 99
      Left = 461
      Top = 8
      Width = 198
      Height = 17
      Caption = 'Frete/Desp.Acess. Tributado ICMS'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 8
      OnClick = chkFreTriClick
    end
    object chkApliRed: TCheckBox
      Tag = 99
      Left = 461
      Top = 83
      Width = 301
      Height = 17
      Caption = 'Aplicar Redu'#231#227'o na Base de C'#225'lculo da Sub. Tribut'#225'ria'
      Checked = True
      State = cbChecked
      TabOrder = 14
      WordWrap = True
      OnClick = chkApliRedClick
      OnExit = chkApliRedClick
    end
    object chkRetFre: TCheckBox
      Tag = 99
      Left = 461
      Top = 23
      Width = 213
      Height = 17
      Caption = 'Calcular Retido para Frete'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 10
      OnClick = chkFreTriClick
    end
    object edtTotAnt: TEditFocus
      Tag = 99
      Left = 119
      Top = 124
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
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
    object chkAbaDes: TCheckBox
      Tag = 99
      Left = 461
      Top = 53
      Width = 233
      Height = 17
      Caption = 'Abater Desconto na Base de C'#225'lculo do IPI'
      TabOrder = 15
      OnClick = chkAbaDesClick
    end
    object mskDtaAnt: TMaskEditFocus
      Tag = 99
      Left = 277
      Top = 124
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnCalculaImpostos: TBitBtnLocked
      Tag = 99
      Left = 821
      Top = 101
      Width = 100
      Height = 22
      Caption = '&Calc. Impostos'
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
      TabOrder = 23
      OnClick = btnCalculaImpostosClick
    end
    object chkCreSub: TCheckBox
      Tag = 99
      Left = 461
      Top = 38
      Width = 224
      Height = 17
      Caption = 'Utilizar Cr'#233'dito de Substitui'#231#227'o Tribut'#225'ria'
      TabOrder = 13
      OnClick = chkCreSubClick
    end
    object chkDescontoIncondicional: TCheckBox
      Tag = 99
      Left = 461
      Top = 68
      Width = 233
      Height = 17
      Caption = 'Desconto Incondicional'
      TabOrder = 16
      OnClick = chkAbaDesClick
    end
    object pnlTipoFrete: TPanel
      Left = 1
      Top = 147
      Width = 1000
      Height = 24
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 26
      object lbl1: TLabel
        Left = 39
        Top = 3
        Width = 76
        Height = 14
        Caption = 'Rateio do Frete:'
      end
      object cbbTipFre: TComboBoxFocus
        Tag = 99
        Left = 118
        Top = 0
        Width = 177
        Height = 22
        Style = csDropDownList
        TabOrder = 0
        OnChange = cbbTipFreChange
        OnExit = cbbTipFreExit
        Items.Strings = (
          'Proporcional ao Valor do Item'
          'Proporcional ao Peso do Item'
          'Proporcional a Quantidade de Item'
          'Informar no momento da entrada')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object edtTotDes: TEditFocus
      Tag = 99
      Left = 271
      Top = 9
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
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
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtICMDes: TEditFocus
      Tag = 99
      Left = 119
      Top = 55
      Width = 64
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 2
      OnExit = edtTotIpiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDesPis: TEditFocus
      Tag = 99
      Left = 119
      Top = 78
      Width = 64
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 3
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
  object pnlTitulo: TPanel [5]
    Tag = 99
    Left = 0
    Top = 0
    Width = 1002
    Height = 19
    Align = alTop
    Caption = 'DADOS FISCAIS DO ITEM'
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object dbgItens: TDBGridCitel [6]
    Left = 0
    Top = 191
    Width = 1002
    Height = 106
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 6
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDblClick = dbgItensDblClick
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ENT_CODITE'
        Title.Caption = 'Item'
        Width = 41
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_CLAFIS'
        Title.Caption = 'CFOP'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_CODFIS'
        Title.Caption = 'C. FIS.'
        Width = 40
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_VLRCON'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. Contabil'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_BASICM'
        Title.Alignment = taCenter
        Title.Caption = 'Base ICMS'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_ALQICM'
        Title.Alignment = taCenter
        Title.Caption = 'Alq'
        Width = 35
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_VALICM'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. ICMS'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_BASIPI'
        Title.Alignment = taCenter
        Title.Caption = 'Base IPI'
        Width = 101
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_ALQIPI'
        Title.Alignment = taCenter
        Title.Caption = 'Alq'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_VALIPI'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. IPI'
        Width = 90
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_ISENTO'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. Isentas'
        Width = 63
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_BASRET'
        Title.Alignment = taCenter
        Title.Caption = 'Base Retido'
        Width = 99
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_VALRET'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. Retido'
        Width = 84
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_OUTRAS'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. Outras'
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_REFVBC'
        Title.Alignment = taCenter
        Title.Caption = 'Base IBS/CBS'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFCALQ'
        Title.Alignment = taCenter
        Title.Caption = 'Alq CBS'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFCVAL'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. CBS'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFIUFA'
        Title.Alignment = taCenter
        Title.Caption = 'Alq IBS Est.'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFIUFV'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. IBS Est.'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFIMNA'
        Title.Alignment = taCenter
        Title.Caption = 'Alq IBS Mun.'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFIMNV'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. IBS Mun.'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFSBAS'
        Title.Alignment = taCenter
        Title.Caption = 'Base IS'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFSALQ'
        Title.Alignment = taCenter
        Title.Caption = 'Alq IS'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_RFSVLR'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. IS'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_DESCON'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. Desc.'
        Width = 77
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_VICMDE'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. Desc. Des.'
        Width = 77
        Visible = True
      end>
  end
  object pnlBotoesDadFis: TPanel [7]
    Left = 0
    Top = 548
    Width = 1002
    Height = 27
    Align = alBottom
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 9
    Font.Name = 'luxi sans'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object btnConfirma: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 111
      Height = 25
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnCancelarEntrada: TBitBtnLocked
      Left = 890
      Top = 1
      Width = 111
      Height = 25
      Align = alRight
      Caption = '[ Esc ] Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelarEntradaClick
    end
    object btnCFOPTodos: TBitBtnLocked
      Left = 113
      Top = 1
      Width = 136
      Height = 25
      Caption = '[ F2 ] CFOP todos os itens'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnCFOPTodosClick
    end
  end
  object pnlDesIte: TPanel [8]
    Left = 0
    Top = 513
    Width = 1002
    Height = 35
    Align = alBottom
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 9
    Font.Name = 'luxi sans'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    object Label1: TLabel
      Left = 11
      Top = 11
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 373
      Top = 12
      Width = 63
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Refer'#234'ncia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 584
      Top = 11
      Width = 42
      Height = 14
      Caption = 'Unidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 67
      Top = 7
      Width = 303
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 438
      Top = 7
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 629
      Top = 7
      Width = 29
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
  object pnlValores: TPanel [9]
    Left = 0
    Top = 308
    Width = 1002
    Height = 205
    Align = alBottom
    Color = 16770261
    TabOrder = 9
    object pnlImpostosReforma: TPanel
      Left = 1
      Top = 135
      Width = 1000
      Height = 68
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object lblBasRef: TLabel
        Left = 10
        Top = 4
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base IBS/CBS:'
      end
      object lblAlqCbs: TLabel
        Left = 35
        Top = 26
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. CBS:'
      end
      object lblVlrCbs: TLabel
        Left = 40
        Top = 48
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. CBS:'
      end
      object lblAlqIbsUf: TLabel
        Left = 150
        Top = 26
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. IBS Est.:'
      end
      object lblVlrIbsUf: TLabel
        Left = 155
        Top = 48
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. IBS Est.:'
      end
      object lblAlqIbsMun: TLabel
        Left = 283
        Top = 23
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. IBS Mun.:'
      end
      object lblVlrIbsMun: TLabel
        Left = 288
        Top = 45
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. IBS Mun.:'
      end
      object lblBas_Is: TLabel
        Left = 416
        Top = 4
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base IS:'
      end
      object lblAlq_Is: TLabel
        Left = 422
        Top = 26
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. IS:'
      end
      object lblVlr_Is: TLabel
        Left = 427
        Top = 48
        Width = 29
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. IS:'
      end
      object edtBasRef: TEditFocus
        Tag = 99
        Left = 85
        Top = 0
        Width = 59
        Height = 22
        Alignment = taRightJustify
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
      object edtAlqCbs: TEditFocus
        Tag = 99
        Left = 85
        Top = 22
        Width = 59
        Height = 22
        Alignment = taRightJustify
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.0000'
      end
      object edtVlrCbs: TEditFocus
        Tag = 99
        Left = 85
        Top = 44
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtAlqIbsUf: TEditFocus
        Tag = 99
        Left = 216
        Top = 22
        Width = 59
        Height = 22
        Alignment = taRightJustify
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.0000'
      end
      object edtVlrIbsUf: TEditFocus
        Tag = 99
        Left = 216
        Top = 44
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
        RequeridoColor = clSilver
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtAlqIbsMun: TEditFocus
        Tag = 99
        Left = 354
        Top = 19
        Width = 59
        Height = 22
        Alignment = taRightJustify
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.0000'
      end
      object edtVlrIbsMun: TEditFocus
        Tag = 99
        Left = 354
        Top = 41
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBas_Is: TEditFocus
        Tag = 99
        Left = 460
        Top = 0
        Width = 59
        Height = 22
        Alignment = taRightJustify
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
      object edtAlq_Is: TEditFocus
        Tag = 99
        Left = 460
        Top = 22
        Width = 59
        Height = 22
        Alignment = taRightJustify
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.0000'
      end
      object edtVlr_Is: TEditFocus
        Tag = 99
        Left = 460
        Top = 44
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
        RequeridoColor = clSilver
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlCfop: TPanel
      Left = 1
      Top = 1
      Width = 1000
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label7: TLabel
        Left = 40
        Top = 4
        Width = 30
        Height = 14
        Caption = 'CFOP:'
      end
      object edtClaFis: TEditFocus
        Tag = 99
        Left = 75
        Top = 1
        Width = 58
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 4
        TabOrder = 0
        OnChange = edtClaFisChange
        OnExit = edtClaFisExit
        OnKeyPress = edtClaFisKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object cmbNatOpe: TComboBoxFocus
        Tag = 99
        Left = 135
        Top = 1
        Width = 857
        Height = 22
        Style = csDropDownList
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object pnlImpostos: TPanel
      Left = 1
      Top = 24
      Width = 1000
      Height = 111
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label9: TLabel
        Left = 13
        Top = 5
        Width = 56
        Height = 14
        Caption = 'C'#243'd. Fiscal:'
      end
      object Label10: TLabel
        Left = 13
        Top = 27
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Cont'#225'bil:'
      end
      object Label11: TLabel
        Left = 151
        Top = 27
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. ICMS:'
      end
      object Label12: TLabel
        Left = 156
        Top = 49
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. ICMS:'
      end
      object Label13: TLabel
        Left = 266
        Top = 5
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base IPI:'
      end
      object Label14: TLabel
        Left = 272
        Top = 27
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. IPI:'
      end
      object Label15: TLabel
        Left = 277
        Top = 49
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. IPI:'
      end
      object Label16: TLabel
        Left = 874
        Top = 5
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Isentas:'
      end
      object Label17: TLabel
        Left = 529
        Top = 5
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base ICMS Sub:'
      end
      object Label18: TLabel
        Left = 876
        Top = 71
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Outras:'
      end
      object Label19: TLabel
        Left = 145
        Top = 5
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base ICMS:'
      end
      object Label20: TLabel
        Left = 529
        Top = 27
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor ICMS Sub:'
      end
      object lblBasAnt: TLabel
        Left = 532
        Top = 49
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base ICMS Ant:'
      end
      object lblValAnt: TLabel
        Left = 532
        Top = 71
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor ICMS Ant:'
      end
      object Label24: TLabel
        Left = 387
        Top = 49
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. IPI N. Cred.:'
      end
      object Label25: TLabel
        Left = 837
        Top = 49
        Width = 92
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Retido N. Cred.:'
      end
      object Label26: TLabel
        Left = 376
        Top = 5
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base IPI N. Cred.:'
      end
      object Label27: TLabel
        Left = 382
        Top = 27
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'Alq. IPI N. Cred.:'
      end
      object Label28: TLabel
        Left = 834
        Top = 27
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base. Ret. N. Cred.:'
      end
      object Label29: TLabel
        Left = 701
        Top = 49
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base de FCP:'
      end
      object Label30: TLabel
        Left = 708
        Top = 71
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Aliq de FCP:'
      end
      object Label31: TLabel
        Left = 726
        Top = 93
        Width = 39
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. FCP:'
      end
      object Label32: TLabel
        Left = 679
        Top = 5
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Base de FCP Sub:'
      end
      object Label33: TLabel
        Left = 694
        Top = 27
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor FCP Sub:'
      end
      object edtCodFis: TEditFocus
        Tag = 99
        Left = 75
        Top = 1
        Width = 58
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnKeyPress = edtCodFisKeyPress
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clWhite
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtVlrCon: TEditFocus
        Tag = 99
        Left = 75
        Top = 23
        Width = 58
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
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
        RequeridoColor = clSilver
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtAlqIcm: TEditFocus
        Tag = 99
        Left = 205
        Top = 23
        Width = 58
        Height = 22
        Alignment = taRightJustify
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValIcm: TEditFocus
        Tag = 99
        Left = 205
        Top = 45
        Width = 58
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
        RequeridoColor = clSilver
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBasIpi: TEditFocus
        Tag = 99
        Left = 311
        Top = 1
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtAlqIpi: TEditFocus
        Tag = 99
        Left = 311
        Top = 23
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValIpi: TEditFocus
        Tag = 99
        Left = 311
        Top = 45
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtIsento: TEditFocus
        Tag = 99
        Left = 933
        Top = 1
        Width = 59
        Height = 22
        Alignment = taRightJustify
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
      object edtBasRet: TEditFocus
        Tag = 99
        Left = 610
        Top = 1
        Width = 59
        Height = 22
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtOutras: TEditFocus
        Tag = 99
        Left = 933
        Top = 67
        Width = 59
        Height = 22
        Alignment = taRightJustify
        TabOrder = 20
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBasIcm: TEditFocus
        Tag = 99
        Left = 205
        Top = 1
        Width = 58
        Height = 22
        Alignment = taRightJustify
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
      object edtValRet: TEditFocus
        Tag = 99
        Left = 610
        Top = 23
        Width = 59
        Height = 22
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBasAnt: TEditFocus
        Tag = 99
        Left = 610
        Top = 45
        Width = 59
        Height = 22
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValAnt: TEditFocus
        Tag = 99
        Left = 610
        Top = 67
        Width = 59
        Height = 22
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtVleIpi: TEditFocus
        Tag = 99
        Left = 463
        Top = 45
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        TabOrder = 21
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtVleRet: TEditFocus
        Tag = 99
        Left = 933
        Top = 45
        Width = 59
        Height = 22
        Alignment = taRightJustify
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 19
        NormalColor = clWhite
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBaeIpi: TEditFocus
        Tag = 99
        Left = 463
        Top = 1
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 22
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtAleIPI: TEditFocus
        Tag = 99
        Left = 463
        Top = 23
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 23
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBaeRet: TEditFocus
        Tag = 99
        Left = 933
        Top = 23
        Width = 59
        Height = 22
        Alignment = taRightJustify
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 18
        NormalColor = clWhite
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtValorFCP: TEditFocus
        Tag = 99
        Left = 771
        Top = 89
        Width = 58
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 16
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clSilver
        Requerido = True
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtAliqFcp: TEditFocus
        Tag = 99
        Left = 771
        Top = 67
        Width = 58
        Height = 22
        Alignment = taRightJustify
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtBasfcp: TEditFocus
        Tag = 99
        Left = 771
        Top = 45
        Width = 58
        Height = 22
        Alignment = taRightJustify
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
      object edtBasfcpSub: TEditFocus
        Tag = 99
        Left = 771
        Top = 1
        Width = 58
        Height = 22
        Alignment = taRightJustify
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
      object edtValorFCPSub: TEditFocus
        Tag = 99
        Left = 771
        Top = 23
        Width = 58
        Height = 22
        Alignment = taRightJustify
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
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 468
    Top = 264
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 636
    Top = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 264
  end
end
