inherited frmCadCondLinGru: TfrmCadCondLinGru
  Width = 1222
  Height = 460
  BorderStyle = bsSizeable
  Caption = 'Desconto M'#225'ximo Linha/Grupo de Produtos'
  ExplicitWidth = 1222
  ExplicitHeight = 460
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 379
    Width = 1206
    TabOrder = 2
    ExplicitTop = 379
    ExplicitWidth = 1206
    inherited FlwBotoes: TFlowPanel
      Width = 1109
      ExplicitWidth = 1109
      inherited btnConfirma: TBitBtnLocked
        Width = 115
        Caption = '[ F10 ] Confirma'
        ExplicitWidth = 115
      end
      object btnExcluir: TBitBtnLocked
        Left = 115
        Top = 0
        Width = 82
        Height = 22
        Caption = '&Excluir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1111
      Top = 2
      Width = 93
      Align = alRight
      ExplicitLeft = 1111
      ExplicitTop = 2
      ExplicitWidth = 93
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 1206
    TabOrder = 3
    ExplicitTop = 405
    ExplicitWidth = 1206
    inherited pnlNomeForm: TPanel
      Left = 1035
      ExplicitLeft = 1035
    end
    inherited pnlInfo: TPanel
      Width = 1035
      ExplicitWidth = 1035
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 121
    Width = 1206
    Height = 242
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 1
    OnEnter = cxgItensEnter
    OnExit = cxgItensEnter
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsGrid
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'C'#243'd. Linha/Grupo'
        DataBinding.FieldName = 'CODGRU'
        Width = 93
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Linha/Grupo'
        DataBinding.FieldName = 'DESGRU'
        Width = 200
      end
      object cxgItensViewColumn5: TcxGridDBColumn
        Caption = 'Desc. M'#225'x. Gerente J'#250'nior'
        DataBinding.FieldName = 'DESMAG'
        HeaderAlignmentHorz = taRightJustify
        Width = 137
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Desc. M'#225'x. Gerente Master'
        DataBinding.FieldName = 'DESMGM'
        HeaderAlignmentHorz = taRightJustify
        Width = 138
      end
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'Desc. M'#225'x. Sub-Gerente J'#250'nior'
        DataBinding.FieldName = 'DESMAS'
        HeaderAlignmentHorz = taRightJustify
        Width = 158
      end
      object cxgItensViewColumn7: TcxGridDBColumn
        Caption = 'Desc. M'#225'x. Sub-Gerente Master'
        DataBinding.FieldName = 'DESMSM'
        HeaderAlignmentHorz = taRightJustify
        Width = 163
      end
      object cxgItensViewColumn6: TcxGridDBColumn
        Caption = 'Desc. M'#225'x. Vendedor J'#250'nior'
        DataBinding.FieldName = 'DESMAV'
        HeaderAlignmentHorz = taRightJustify
        Width = 150
      end
      object cxgItensViewColumn8: TcxGridDBColumn
        Caption = 'Desc. M'#225'x. Vendedor Master'
        DataBinding.FieldName = 'DESMVM'
        HeaderAlignmentHorz = taRightJustify
        Width = 150
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlItem: TPanel [3]
    Left = 0
    Top = 0
    Width = 1206
    Height = 121
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 66
      Top = 51
      Width = 96
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Linha/Grupo:'
    end
    object Label3: TLabel
      Left = 14
      Top = 72
      Width = 148
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Gerente J'#250'nior:'
    end
    object Label4: TLabel
      Left = 535
      Top = 72
      Width = 140
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Vendedor J'#250'nior:'
    end
    object lbl1: TLabel
      Left = 43
      Top = 27
      Width = 119
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Condi'#231#227'o de Pagto:'
    end
    object Label2: TLabel
      Left = 260
      Top = 72
      Width = 167
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Sub-Gerente J'#250'nior:'
    end
    object Label5: TLabel
      Left = 14
      Top = 96
      Width = 148
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Gerente Master:'
    end
    object Label6: TLabel
      Left = 260
      Top = 96
      Width = 167
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Sub-Gerente Master:'
    end
    object Label7: TLabel
      Left = 528
      Top = 96
      Width = 147
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desc. M'#225'x. Vendedor Master:'
    end
    object dbeCodGru: TDBEditFocus
      Tag = 99
      Left = 164
      Top = 43
      Width = 95
      Height = 22
      DataField = 'CODGRU'
      DataSource = dtsItens
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnKeyPress = dbeCodGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesGru: TDBEditFocus
      Left = 260
      Top = 43
      Width = 496
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'DESGRU'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesVen: TDBEditFocus
      Tag = 99
      Left = 678
      Top = 67
      Width = 78
      Height = 22
      DataField = 'DESMAV'
      DataSource = dtsItens
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDesGen: TDBEditFocus
      Tag = 99
      Left = 164
      Top = 67
      Width = 78
      Height = 22
      DataField = 'DESMAG'
      DataSource = dtsItens
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 760
      Top = 43
      Width = 93
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
      TabOrder = 10
      OnClick = btnAdicionarClick
    end
    object dbeCodCnd: TDBEditFocus
      Left = 164
      Top = 19
      Width = 95
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'CODCND'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = dbeCodGruKeyPress
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDesCnd: TDBEditFocus
      Left = 260
      Top = 19
      Width = 593
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'DESCND'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 760
      Top = 67
      Width = 93
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
      TabOrder = 11
      OnClick = btnCancelaItemClick
    end
    object dbeDesSub: TDBEditFocus
      Tag = 99
      Left = 431
      Top = 67
      Width = 78
      Height = 22
      DataField = 'DESMAS'
      DataSource = dtsItens
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDesGeM: TDBEditFocus
      Tag = 99
      Left = 164
      Top = 91
      Width = 78
      Height = 22
      DataField = 'DESMGM'
      DataSource = dtsItens
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDesSuM: TDBEditFocus
      Tag = 99
      Left = 431
      Top = 91
      Width = 78
      Height = 22
      DataField = 'DESMSM'
      DataSource = dtsItens
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDesVeM: TDBEditFocus
      Tag = 99
      Left = 678
      Top = 91
      Width = 78
      Height = 22
      DataField = 'DESMVM'
      DataSource = dtsItens
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  object prgProgresso: TProgressBar [4]
    Left = 0
    Top = 363
    Width = 1206
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 80
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 48
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 136
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 16
    Top = 136
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    AfterPost = cdsItensAfterPost
    Left = 112
    Top = 136
    object cdsItensCODCND: TStringField
      FieldName = 'CODCND'
      Size = 3
    end
    object cdsItensDESCND: TStringField
      FieldName = 'DESCND'
      Size = 70
    end
    object cdsItensCODGRU: TStringField
      FieldName = 'CODGRU'
      Size = 6
    end
    object cdsItensDESGRU: TStringField
      FieldName = 'DESGRU'
      Size = 70
    end
    object cdsItensDESMAG: TFloatField
      FieldName = 'DESMAG'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensDESMAV: TFloatField
      FieldName = 'DESMAV'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensDESMAS: TFloatField
      FieldName = 'DESMAS'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensDESMGM: TFloatField
      FieldName = 'DESMGM'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensDESMSM: TFloatField
      FieldName = 'DESMSM'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensDESMVM: TFloatField
      FieldName = 'DESMVM'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsGrid: TDataSource
    DataSet = cdsItens
    Left = 144
    Top = 136
  end
end
