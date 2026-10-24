inherited frmConsultaVendaDepartamento: TfrmConsultaVendaDepartamento
  Width = 1043
  Height = 510
  Caption = 'Venda por Departamento'
  OnDestroy = FormDestroy
  ExplicitWidth = 1043
  ExplicitHeight = 510
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 439
    Width = 1037
    ExplicitTop = 439
    ExplicitWidth = 1037
    inherited FlwBotoes: TFlowPanel
      Width = 1033
      ExplicitWidth = 1033
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 954
      Caption = '&Fechar'
      ExplicitLeft = 954
    end
  end
  inherited pnlStatus: TPanel
    Top = 465
    Width = 1037
    ExplicitTop = 465
    ExplicitWidth = 1037
    inherited pnlNomeForm: TPanel
      Left = 866
      ExplicitLeft = 866
    end
    inherited pnlInfo: TPanel
      Width = 866
      ExplicitWidth = 866
    end
  end
  object pnlParametros: TPanel [2]
    Left = 0
    Top = 0
    Width = 1037
    Height = 73
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 5
      Top = 1
      Width = 67
      Height = 14
      Caption = 'Departamento'
    end
    object edtDepartamento: TEditFocus
      Tag = 99
      Left = 5
      Top = 16
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnExit = edtDepartamentoExit
      OnKeyPress = edtDepartamentoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDepartamento: TEditFocus
      Left = 78
      Top = 16
      Width = 455
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object btnAdicionar: TBitBtnLocked
      Left = 6
      Top = 41
      Width = 85
      Height = 23
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
      TabOrder = 2
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 91
      Top = 41
      Width = 85
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
      TabOrder = 3
    end
  end
  object cxgConsulta: TcxGrid [3]
    Left = 0
    Top = 73
    Width = 1037
    Height = 366
    Align = alClient
    TabOrder = 3
    object cxgConsultaDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsul
      DataController.DetailKeyFieldNames = 'DET_CODVEN'
      DataController.MasterKeyFieldNames = 'DET_CODVEN'
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgConsultaDBTableViewColumn4
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgConsultaDBTableViewColumn4
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgConsultaDBTableViewColumn3
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgConsultaDBTableViewColumn3
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxgConsultaDBTableViewColumn4
        end
        item
          Kind = skSum
          Column = cxgConsultaDBTableViewColumn3
        end>
      DataController.Summary.SummaryGroups = <
        item
          Links = <
            item
              Column = cxgConsultaDBTableViewColumn3
            end>
          SummaryItems = <>
        end
        item
          Links = <
            item
              Column = cxgConsultaDBTableViewColumn4
            end>
          SummaryItems = <>
        end>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupByBox = False
      OptionsView.GroupFooterMultiSummaries = True
      OptionsView.GroupSummaryLayout = gslAlignWithColumns
      object cxgConsultaDBTableViewColumn1: TcxGridDBColumn
        Caption = 'Vendedor: '
        DataBinding.FieldName = 'DET_CODVEN'
        Visible = False
        GroupIndex = 0
      end
      object cxgConsultaDBTableViewColumn2: TcxGridDBColumn
        Caption = 'Departamento'
        DataBinding.FieldName = 'DEP_DESCRI'
        Options.Editing = False
        Width = 200
      end
      object cxgConsultaDBTableViewColumn3: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'DET_QTDITE'
        Options.Editing = False
        Width = 100
      end
      object cxgConsultaDBTableViewColumn4: TcxGridDBColumn
        Caption = 'Total'
        DataBinding.FieldName = 'DET_TOTITE'
        Options.Editing = False
        Width = 100
      end
    end
    object dbgDocumentosDBViewMaster: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsul
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Filter.AutoDataSetFilter = True
      DataController.KeyFieldNames = 'DET_CODVEN'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupFooterMultiSummaries = True
      OptionsView.GroupSummaryLayout = gslAlignWithColumns
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object dbgDocumentosDBViewMasterColumn1: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'DET_CODVEN'
      end
    end
    object cxgConsultaLevel: TcxGridLevel
      GridView = cxgConsultaDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 168
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 168
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 80
    Top = 176
  end
  object dtsConsul: TDataSource
    Left = 280
    Top = 200
  end
end
