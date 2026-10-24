inherited frmExpDigVolumesCompostos: TfrmExpDigVolumesCompostos
  Width = 653
  Height = 603
  Caption = 'Volumes Compostos'
  ExplicitWidth = 653
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 532
    Width = 647
    TabOrder = 1
    ExplicitTop = 532
    ExplicitWidth = 647
    inherited FlwBotoes: TFlowPanel
      Width = 643
      ExplicitWidth = 643
    end
    inherited btnSair: TBitBtnLocked
      Left = 564
      ExplicitLeft = 564
    end
  end
  inherited pnlStatus: TPanel
    Top = 558
    Width = 647
    TabOrder = 2
    ExplicitTop = 558
    ExplicitWidth = 647
    inherited pnlNomeForm: TPanel
      Left = 476
      ExplicitLeft = 476
    end
    inherited pnlInfo: TPanel
      Width = 476
      ExplicitWidth = 476
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 647
    Height = 532
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblSigla: TLabel
      Left = 7
      Top = 16
      Width = 64
      Height = 14
      Caption = 'Sigla Volume:'
    end
    object lblQtdVol: TLabel
      Left = 184
      Top = 16
      Width = 88
      Height = 14
      Caption = 'Qtde. de Volumes:'
    end
    object Label1: TLabel
      Left = 200
      Top = 128
      Width = 32
      Height = 14
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 240
      Top = 136
      Width = 32
      Height = 14
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 8
      Top = 232
      Width = 264
      Height = 16
      Caption = 'Produtos sem necessidade de Expedi'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtSigla: TEditFocus
      Tag = 99
      Left = 77
      Top = 13
      Width = 97
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 0
      OnKeyPress = edtSiglaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object edtQtdVol: TEditFocus
      Tag = 99
      Left = 274
      Top = 13
      Width = 87
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object btnAdicionar: TBitBtnLocked
      Left = 367
      Top = 13
      Width = 82
      Height = 22
      Caption = '&Adicionar'
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
      TabOrder = 2
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 452
      Top = 13
      Width = 82
      Height = 22
      Caption = '&Cancelar'
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
      TabOrder = 3
      OnClick = btnCancelaItemClick
    end
    object cxgVolume: TcxGrid
      Left = 7
      Top = 41
      Width = 610
      Height = 185
      TabOrder = 4
      object cxgVolumeDBTableView: TcxGridDBTableView
        OnKeyDown = cxgVolumeDBTableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsVolume
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            FieldName = 'QTDVOL'
            Column = cxgVolumeQTDVOL
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object cxgVolumeTIPVOL: TcxGridDBColumn
          Caption = 'Tipo de Volume'
          DataBinding.FieldName = 'TIPVOL'
          Width = 394
        end
        object cxgVolumeSIGVOL: TcxGridDBColumn
          Caption = 'Sigla'
          DataBinding.FieldName = 'SIGVOL'
          Width = 100
        end
        object cxgVolumeQTDVOL: TcxGridDBColumn
          Caption = 'Qtde. Volumes'
          DataBinding.FieldName = 'QTDVOL'
          Width = 86
        end
      end
      object cxgVolumeLevel: TcxGridLevel
        GridView = cxgVolumeDBTableView
      end
    end
    object cxgProdutos: TcxGrid
      Left = 7
      Top = 251
      Width = 610
      Height = 261
      TabOrder = 5
      object cxgProdutosDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsProdutos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.0000'
            Kind = skSum
            FieldName = 'QTDITE'
            Column = cxgProdutosQTDITE
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object cxgProdutosDESITE: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'DESITE'
          Width = 394
        end
        object cxgProdutosUNIDAD: TcxGridDBColumn
          Caption = 'Unid.'
          DataBinding.FieldName = 'UNIDAD'
          Width = 100
        end
        object cxgProdutosQTDITE: TcxGridDBColumn
          Caption = 'Qtde. Produtos'
          DataBinding.FieldName = 'QTDITE'
          Width = 86
        end
      end
      object cxgProdutosLevel: TcxGridLevel
        GridView = cxgProdutosDBTableView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 952
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 904
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 832
  end
  object dtsVolume: TDataSource
    DataSet = cdsVolume
    Left = 224
    Top = 64
  end
  object cdsVolume: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 64
    object cdsVolumeTIPVOL: TStringField
      FieldName = 'TIPVOL'
    end
    object cdsVolumeSIGVOL: TStringField
      FieldName = 'SIGVOL'
      Size = 10
    end
    object cdsVolumeQTDVOL: TIntegerField
      FieldName = 'QTDVOL'
    end
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 288
    object cdsProdutosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 80
    end
    object cdsProdutosUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 4
    end
    object cdsProdutosQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.0000'
      EditFormat = '#,##0.0000'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 152
    Top = 288
  end
end
