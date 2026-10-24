inherited frmEstornoReceber: TfrmEstornoReceber
  Left = 175
  Top = 197
  Width = 632
  Height = 472
  BorderIcons = [biSystemMenu]
  Caption = 'Estorno de Contas a Receber'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 632
  ExplicitHeight = 472
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 626
    ExplicitTop = 427
    ExplicitWidth = 626
    inherited FlwBotoes: TFlowPanel
      Width = 622
      ExplicitWidth = 622
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 427
    Width = 626
    ExplicitTop = 427
    ExplicitWidth = 626
    inherited pnlNomeForm: TPanel
      Left = 481
      Width = 145
      ExplicitLeft = 481
      ExplicitWidth = 145
    end
    inherited pnlInfo: TPanel
      Width = 481
      ExplicitWidth = 481
    end
  end
  inherited pgcDados: TPageControl
    Top = 84
    Width = 626
    Height = 343
    Visible = False
    ExplicitTop = 84
    ExplicitWidth = 626
    ExplicitHeight = 343
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 618
      ExplicitHeight = 311
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 626
    Height = 84
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      626
      84)
    object Label5: TLabel
      Left = 20
      Top = 14
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Duplicata:'
    end
    object Label1: TLabel
      Left = 200
      Top = 14
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label2: TLabel
      Left = 26
      Top = 37
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label3: TLabel
      Left = 210
      Top = 37
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtNumDup: TEditFocus
      Tag = 99
      Left = 69
      Top = 10
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtNumDupExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 247
      Top = 10
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 69
      Top = 33
      Width = 44
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = -1
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 247
      Top = 33
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 4
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtParcel: TEditFocus
      Tag = 99
      Left = 152
      Top = 10
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      Text = 'A'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = -1
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Left = 313
      Top = 33
      Width = 307
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 313
      Top = 10
      Width = 307
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConsultar: TBitBtnLocked
      Tag = 99
      Left = 514
      Top = 58
      Width = 106
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Carregar T'#237'tulos'
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
      TabOrder = 5
      OnClick = btnConsultarClick
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 84
    Width = 626
    Height = 343
    Align = alClient
    ParentBackground = False
    TabOrder = 4
    object dbgDuplicatas: TDBGridCitel
      Left = 1
      Top = 1
      Width = 624
      Height = 312
      Align = alClient
      DataSource = dtsDados
      DrawingStyle = gdsClassic
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDuplicatasDrawColumnCell
      OnKeyDown = dbgDuplicatasKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CTR_NUMDUP'
          Title.Caption = 'Duplicata'
          Width = 142
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_SEQBAI'
          Title.Caption = 'Seq.'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_ESPDOC'
          Title.Caption = 'Esp'#233'cie'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_CODEMP'
          Title.Caption = 'Empresa'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_DTAREC'
          Title.Caption = 'Dt. Recebimento'
          Width = 110
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTR_VALREC'
          Title.Alignment = taCenter
          Title.Caption = 'Vr. Recebido'
          Width = 110
          Visible = True
        end>
    end
    object pnlBotoesEstorno: TPanel
      Left = 1
      Top = 313
      Width = 624
      Height = 29
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object btnConfirma: TBitBtnLocked
        Left = 2
        Top = 2
        Width = 147
        Height = 25
        Align = alLeft
        Caption = '[ F10 ] Confirma Estorno'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnSairEst: TBitBtnLocked
        Left = 475
        Top = 2
        Width = 147
        Height = 25
        Align = alRight
        Caption = '[ ESC ] Sair'
        TabOrder = 1
        OnClick = btnSairEstClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 288
    Top = 168
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 384
    Top = 168
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'cpvDados'
    Left = 416
    Top = 168
  end
  object cpvDados: TUniDataSetProvider
    DataSet = qryDados
    Options = []
    Left = 448
    Top = 168
  end
  object qryDados: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Constraints = <>
    Left = 480
    Top = 168
  end
end
