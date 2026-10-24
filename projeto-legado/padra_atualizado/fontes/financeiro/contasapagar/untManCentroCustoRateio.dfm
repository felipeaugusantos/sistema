inherited frmManCentroCustoRateio: TfrmManCentroCustoRateio
  Width = 754
  Height = 349
  BorderIcons = [biSystemMenu]
  Caption = 
    'Manuten'#231#227'o Coletiva de Rateio de Plano de Contas - Contas a Paga' +
    'r'
  Position = poMainFormCenter
  ExplicitWidth = 754
  ExplicitHeight = 349
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 276
    Width = 748
    TabOrder = 4
    ExplicitTop = 276
    ExplicitWidth = 748
    inherited FlwBotoes: TFlowPanel
      Width = 744
      ExplicitWidth = 744
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 22
        Caption = '[F10] Confirmar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 669
      ExplicitLeft = 669
    end
  end
  inherited pnlStatus: TPanel
    Top = 304
    Width = 748
    TabOrder = 5
    ExplicitTop = 304
    ExplicitWidth = 748
    inherited pnlNomeForm: TPanel
      Left = 577
      ExplicitLeft = 577
    end
    inherited pnlInfo: TPanel
      Width = 577
      ExplicitWidth = 577
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 748
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 2
      Top = 5
      Width = 575
      Height = 23
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 5
      ExplicitWidth = 575
      ExplicitHeight = 23
      inherited lblPlaContas: TLabel
        Left = 6
        Top = 5
        Width = 81
        Height = 14
        ExplicitLeft = 6
        ExplicitTop = 5
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 145
        Top = 1
        Width = 423
        Height = 22
        ExplicitLeft = 145
        ExplicitTop = 1
        ExplicitWidth = 423
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 89
        Top = 1
        Width = 55
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 89
        ExplicitTop = 1
        ExplicitWidth = 55
        ExplicitHeight = 22
      end
    end
    object chkEventos: TCheckBox
      Left = 573
      Top = 5
      Width = 145
      Height = 15
      Caption = 'Habilitar Centro de Custo'
      TabOrder = 1
      OnClick = chkEventosClick
    end
  end
  object grdCentroCustoRateio: TcxGrid [3]
    Left = 0
    Top = 75
    Width = 748
    Height = 201
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdCentroCustoRateioDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdCentroCustoRateioDBTableView1CustomDrawCell
      DataController.DataSource = dtsCentros
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsData.Editing = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideSelection = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object grdCentroCustoRateioDBT_CODCTA: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODCTA'
        Width = 90
      end
      object grdCentroCustoRateioDBT_DESCTA: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCTA'
        Width = 318
      end
      object grdCentroCustoRateioDBT_EVENTO: TcxGridDBColumn
        Caption = 'Evento'
        DataBinding.FieldName = 'EVENTO'
        Width = 298
      end
      object grdCentroCustoRateioDBT_CODEVE: TcxGridDBColumn
        DataBinding.FieldName = 'CODEVE'
        Visible = False
      end
    end
    object grdCentroCustoRateioLevel1: TcxGridLevel
      GridView = grdCentroCustoRateioDBTableView1
    end
  end
  object pnlEvento: TPanel [4]
    Left = 0
    Top = 29
    Width = 748
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    Visible = False
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = -3
      Top = 0
      Width = 596
      Height = 22
      TabOrder = 0
      ExplicitLeft = -3
      ExplicitWidth = 596
      inherited lblEventos: TLabel
        Left = 8
        Width = 87
        Height = 14
        ExplicitLeft = 8
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Height = 22
        OnKeyPress = fraCentroCustoedtCodEveKeyPress
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Width = 423
        Height = 22
        Enabled = True
        ExplicitWidth = 423
        ExplicitHeight = 22
      end
    end
  end
  object PnlBtnCabe: TPanel [5]
    Left = 0
    Top = 51
    Width = 748
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object btnCancelar: TBitBtnLocked
      Left = 486
      Top = 0
      Width = 84
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
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnAdicionar: TBitBtnLocked
      Left = 402
      Top = 0
      Width = 84
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
      OnClick = btnAdicionarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 160
  end
  object dtsCentros: TDataSource
    DataSet = cdsCentros
    Left = 224
    Top = 160
  end
  object cdsCentros: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 160
    object cdsCentrosCODCTA: TStringField
      FieldName = 'CODCTA'
      Size = 7
    end
    object cdsCentrosDESCTA: TStringField
      FieldName = 'DESCTA'
      Size = 30
    end
    object cdsCentrosEVENTO: TStringField
      FieldName = 'EVENTO'
      Size = 55
    end
    object cdsCentrosCODEVE: TStringField
      FieldName = 'CODEVE'
      Size = 5
    end
  end
end
