inherited frmFatImportarItensRequisicao: TfrmFatImportarItensRequisicao
  Width = 780
  Height = 500
  Caption = 'Importar Requisi'#231#227'o'
  Position = poScreenCenter
  ExplicitWidth = 780
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 774
    TabOrder = 1
    ExplicitTop = 427
    ExplicitWidth = 774
    inherited FlwBotoes: TFlowPanel
      Width = 693
      TabOrder = 1
      ExplicitTop = 2
      ExplicitWidth = 693
      ExplicitHeight = 24
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 159
        Height = 22
        Caption = '[F10] Confirmar'
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
        ModalResult = 1
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 159
        Top = 0
        Width = 159
        Height = 22
        Caption = '[F6] Marcar / Desmarcar'
        TabOrder = 1
        OnClick = btnMarDesClick
      end
      object btnMarDesTodos: TBitBtnLocked
        Left = 318
        Top = 0
        Width = 159
        Height = 22
        Caption = '[F7] Marcar / Desmarcar Todos'
        TabOrder = 2
        OnClick = btnMarDesTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 695
      Top = 2
      Height = 24
      Align = alRight
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 695
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  object cxgReq: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 774
    Height = 427
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgReqView: TcxGridDBTableView
      OnKeyDown = cxgReqViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgReqViewCellDblClick
      OnCustomDrawCell = cxgReqViewCustomDrawCell
      DataController.DataSource = dtsReq
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '  '
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgReqViewAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
      end
      object cxgReqViewCODREQ: TcxGridDBColumn
        DataBinding.FieldName = 'CODREQ'
        Width = 56
      end
      object cxgReqViewCODFOR: TcxGridDBColumn
        DataBinding.FieldName = 'CODFOR'
        Visible = False
      end
      object cxgReqViewNOMFOR: TcxGridDBColumn
        DataBinding.FieldName = 'NOMFOR'
        Visible = False
      end
      object cxgReqViewDTACAD: TcxGridDBColumn
        DataBinding.FieldName = 'DTACAD'
        Width = 60
      end
      object cxgReqViewNOMOPE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMOPE'
        Width = 110
      end
      object cxgReqViewNOMCLI: TcxGridDBColumn
        DataBinding.FieldName = 'NOMCLI'
        Width = 160
      end
      object cxgReqViewPRODUT: TcxGridDBColumn
        DataBinding.FieldName = 'PRODUT'
        Width = 160
      end
      object cxgReqViewREFERE: TcxGridDBColumn
        DataBinding.FieldName = 'REFERE'
        Width = 62
      end
      object cxgReqViewSIGUNI: TcxGridDBColumn
        DataBinding.FieldName = 'SIGUNI'
      end
      object cxgReqViewCODFAB: TcxGridDBColumn
        DataBinding.FieldName = 'CODFAB'
        Width = 69
      end
      object cxgReqViewQTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'QTDITE'
        Width = 48
      end
      object cxgReqViewMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object cxgReqViewCODITE: TcxGridDBColumn
        DataBinding.FieldName = 'CODITE'
        Visible = False
        Width = 50
      end
      object cxgReqViewDESITE: TcxGridDBColumn
        DataBinding.FieldName = 'DESITE'
        Visible = False
        Width = 150
      end
    end
    object cxgCliCnd: TcxGridLevel
      GridView = cxgReqView
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 774
    TabOrder = 2
    ExplicitTop = 455
    ExplicitWidth = 774
    inherited pnlNomeForm: TPanel
      Left = 603
      TabOrder = 1
      ExplicitLeft = 603
    end
    inherited pnlInfo: TPanel
      Width = 603
      TabOrder = 0
      ExplicitWidth = 603
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 774
    Top = 74
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 774
    Top = 46
  end
  object cdsReq: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 30
    Top = 50
    object cdsReqAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object cdsReqCODREQ: TStringField
      DisplayLabel = 'C'#243'd.'
      FieldName = 'CODREQ'
      Size = 6
    end
    object cdsReqDTACAD: TDateField
      DisplayLabel = 'Dta. Cad.'
      FieldName = 'DTACAD'
    end
    object cdsReqNOMOPE: TStringField
      DisplayLabel = 'Vendedor'
      FieldName = 'NOMOPE'
      Size = 34
    end
    object cdsReqNOMCLI: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'NOMCLI'
      Size = 69
    end
    object cdsReqPRODUT: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'PRODUT'
      Size = 76
    end
    object cdsReqREFERE: TStringField
      DisplayLabel = 'Refer'#234'ncia'
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsReqSIGUNI: TStringField
      DisplayLabel = 'Unid.'
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsReqCODFAB: TStringField
      DisplayLabel = 'C'#243'd. F'#225'brica'
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsReqQTDITE: TFloatField
      DisplayLabel = 'Qtd.'
      FieldName = 'QTDITE'
    end
    object cdsReqMARDES: TIntegerField
      FieldName = 'MARDES'
      Visible = False
    end
    object cdsReqCODITE: TStringField
      FieldName = 'CODITE'
      Visible = False
      Size = 5
    end
    object cdsReqDESITE: TStringField
      DisplayLabel = 'DesIte'
      DisplayWidth = 70
      FieldName = 'DESITE'
      Visible = False
      Size = 76
    end
  end
  object dtsReq: TDataSource
    DataSet = cdsReq
    Left = 60
    Top = 50
  end
end
