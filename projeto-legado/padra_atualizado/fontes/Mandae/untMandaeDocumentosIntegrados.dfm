inherited frmMandaeDocumentosIntegrados: TfrmMandaeDocumentosIntegrados
  Left = 0
  Top = 0
  Width = 763
  Height = 479
  BorderIcons = [biSystemMenu]
  Caption = 'Documentos Integrados com Manda'#234'   '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 763
  ExplicitHeight = 479
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 406
    Width = 757
    ExplicitTop = 406
    ExplicitWidth = 757
    inherited FlwBotoes: TFlowPanel
      Width = 753
      ExplicitTop = 2
      ExplicitWidth = 753
      ExplicitHeight = 24
      object btnConsultarTracking: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 137
        Height = 22
        Caption = '[F6] Consultar Tracking'
        TabOrder = 0
        OnClick = btnConsultarTrackingClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 674
      Top = 2
      ExplicitLeft = 674
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 434
    Width = 757
    ExplicitTop = 434
    ExplicitWidth = 757
    inherited pnlNomeForm: TPanel
      Left = 586
      ExplicitLeft = 586
    end
    inherited pnlInfo: TPanel
      Width = 586
      ExplicitWidth = 586
    end
  end
  object grdDocumentos: TcxGridCitel [3]
    Left = 0
    Top = 81
    Width = 757
    Height = 325
    Align = alClient
    TabOrder = 3
    ExplicitTop = 77
    object grdDbDocumentos: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDocumentos
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDbDocumentosColumn1: TcxGridDBColumn
        Caption = 'Data\Hora Documento'
        DataBinding.FieldName = 'MAN_DTADOC'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 138
      end
      object grdDbDocumentosColumn2: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'MAN_NUMDOC'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 102
      end
      object grdDbDocumentosColumn3: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'MAN_ESPDOC'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 55
      end
      object grdDbDocumentosColumn6: TcxGridDBColumn
        Caption = 'Volume'
        DataBinding.FieldName = 'MAN_VOLUME'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
      end
      object grdDbDocumentosColumn4: TcxGridDBColumn
        Caption = 'C'#243'digo do Rastreio'
        DataBinding.FieldName = 'MAN_CODRAS'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 111
      end
      object grdDbDocumentosColumn5: TcxGridDBColumn
        Caption = 'Data\Hora do Envio'
        DataBinding.FieldName = 'MAN_DTAENV'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 138
      end
    end
    object grdDocumentosLevel1: TcxGridLevel
      GridView = grdDbDocumentos
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 757
    Height = 81
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object lblDatEnt: TLabel
      Left = 10
      Top = 14
      Width = 99
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data do Documento:'
    end
    object Label1: TLabel
      Left = 199
      Top = 14
      Width = 142
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data do Envio da Integra'#231#227'o:'
    end
    object Label2: TLabel
      Left = 36
      Top = 41
      Width = 73
      Height = 13
      Caption = 'N'#186' Documento:'
    end
    object Label3: TLabel
      Left = 213
      Top = 41
      Width = 40
      Height = 13
      Caption = 'Esp'#233'cie:'
    end
    object lblEmpresa: TLabel
      Left = 311
      Top = 41
      Width = 45
      Height = 14
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDataDocumento: TMaskEditFocus
      Tag = 99
      Left = 115
      Top = 11
      Width = 61
      Height = 21
      CharCase = ecUpperCase
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
    object edtDataEnvio: TMaskEditFocus
      Tag = 99
      Left = 347
      Top = 11
      Width = 61
      Height = 21
      CharCase = ecUpperCase
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
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 115
      Top = 38
      Width = 84
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 259
      Top = 38
      Width = 41
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 359
      Top = 38
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodEmpExit
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
      Left = 397
      Top = 38
      Width = 232
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object btnListar: TBitBtnLocked
      Left = 635
      Top = 38
      Width = 104
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
      TabOrder = 6
      OnClick = btnListarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 144
  end
  object dtsDocumentos: TDataSource
    Left = 33
    Top = 160
  end
end
