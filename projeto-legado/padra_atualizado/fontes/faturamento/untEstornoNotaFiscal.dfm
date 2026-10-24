inherited frmEstornoNotaFiscal: TfrmEstornoNotaFiscal
  Width = 844
  Height = 600
  BorderStyle = bsDialog
  Caption = 'Estorno de Nota Fiscal de Devolu'#231#227'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 844
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 838
    ExplicitTop = 527
    ExplicitWidth = 838
    inherited FlwBotoes: TFlowPanel
      Width = 834
      ExplicitWidth = 834
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 758
      ExplicitLeft = 758
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 838
    ExplicitTop = 555
    ExplicitWidth = 838
    inherited pnlNomeForm: TPanel
      Left = 667
      ExplicitLeft = 667
    end
    inherited pnlInfo: TPanel
      Width = 667
      ExplicitWidth = 667
    end
  end
  object pnlConsulta: TPanel [2]
    Left = 0
    Top = 0
    Width = 838
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label4: TLabel
      Left = 64
      Top = 20
      Width = 38
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cliente:'
    end
    object Label14: TLabel
      Left = 45
      Top = 43
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label15: TLabel
      Left = 13
      Top = 66
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chave de Acesso:'
    end
    object Label1: TLabel
      Left = 193
      Top = 43
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 105
      Top = 17
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 190
      Top = 17
      Width = 515
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 105
      Top = 40
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      OnExit = edtNumDocExit
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 225
      Top = 40
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnExit = edtNumDocExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtChaveAcesso: TEditFocus
      Left = 105
      Top = 63
      Width = 368
      Height = 22
      Alignment = taLeftJustify
      Color = 15263976
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 15263976
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnCarregar: TBitBtnLocked
      Left = 479
      Top = 63
      Width = 110
      Height = 23
      Caption = '&Carregar'
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
      OnClick = btnCarregarClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 595
      Top = 63
      Width = 110
      Height = 23
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
      TabOrder = 6
      OnClick = btnCancelarClick
    end
  end
  object cxGrid: TcxGrid [3]
    Left = 0
    Top = 97
    Width = 838
    Height = 430
    Align = alClient
    TabOrder = 3
    object cxGridItens: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxGridItensTOTITE
        end
        item
          Kind = skCount
        end
        item
          Kind = skCount
          Column = cxGridItensCODITE
        end
        item
          Kind = skSum
          Column = cxGridItensVLRCON
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxGridItensCODITE: TcxGridDBColumn
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 49
      end
      object cxGridItensREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Options.Focusing = False
        Width = 73
      end
      object cxGridItensDESITE: TcxGridDBColumn
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 347
      end
      object cxGridItensQTDITE: TcxGridDBColumn
        Caption = 'Qtde'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 54
      end
      object cxGridItensUNITAR: TcxGridDBColumn
        Caption = 'Vlr.Unit'#225'rio'
        DataBinding.FieldName = 'UNITAR'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 79
      end
      object cxGridItensDESESP: TcxGridDBColumn
        Caption = 'Desconto'
        DataBinding.FieldName = 'DESESP'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 64
      end
      object cxGridItensTOTITE: TcxGridDBColumn
        DataBinding.FieldName = 'TOTITE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 86
      end
      object cxGridItensVLRCON: TcxGridDBColumn
        Caption = 'Vlr. Total c/ Imp.'
        DataBinding.FieldName = 'VLRCON'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 84
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 360
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 264
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    OnDataChange = dtsItensDataChange
    Left = 542
    Top = 166
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 480
    Top = 166
    object cdsItensCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsItensDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESITE'
      Size = 86
    end
    object cdsItensQTDITE: TFloatField
      DisplayLabel = 'Qtd'
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensCODUNI: TStringField
      FieldName = 'UNIDAD'
      Size = 3
    end
    object cdsItensVALITE: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'UNITAR'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensDESESP: TFloatField
      FieldName = 'DESESP'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensTOTITE: TFloatField
      DisplayLabel = 'Vlr. Total'
      FieldName = 'TOTITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensVLRCON: TFloatField
      DisplayLabel = 'Vlr. Geral'
      FieldName = 'VLRCON'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
end
