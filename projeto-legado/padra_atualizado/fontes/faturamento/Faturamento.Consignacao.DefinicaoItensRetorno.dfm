inherited frmFaturamentoConsignacaoDefinicaoItensRetorno: TfrmFaturamentoConsignacaoDefinicaoItensRetorno
  Left = 0
  Top = 0
  Width = 1097
  Height = 533
  BorderIcons = []
  Caption = 'Relacionamento entre os Itens do retorno e envio na Consigna'#231#227'o'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poMainFormCenter
  ExplicitWidth = 1097
  ExplicitHeight = 533
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 459
    Width = 1091
    Height = 29
    Enabled = True
    Visible = True
    ExplicitTop = 459
    ExplicitWidth = 1091
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Width = 1087
      Height = 25
      Visible = True
      ExplicitWidth = 1087
      ExplicitHeight = 25
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 0
        Height = 22
        Caption = 'Confirmar'
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
        ModalResult = 1
        TabOrder = 0
        Visible = False
        WordWrap = True
      end
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 84
        Height = 22
        Caption = '&Confirmar'
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
        TabOrder = 1
        OnClick = btnConfirmarClick
      end
      object BitBtnLocked1: TBitBtnLocked
        Left = 84
        Top = 0
        Width = 77
        Height = 22
        Align = alRight
        Caption = 'Cancela'
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
        TabOrder = 2
        OnClick = btnSairClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 850
      ExplicitLeft = 850
    end
  end
  inherited pgcDados: TPageControl
    Width = 1091
    Height = 459
    ActivePage = nil
    ExplicitWidth = 1091
    ExplicitHeight = 459
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 1083
      ExplicitHeight = 449
    end
  end
  inherited pnlStatus: TPanel
    Top = 488
    Width = 1091
    ExplicitTop = 488
    ExplicitWidth = 1091
    inherited pnlNomeForm: TPanel
      Left = 920
      ExplicitLeft = 920
    end
    inherited pnlInfo: TPanel
      Width = 920
      ExplicitWidth = 920
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 1091
    Height = 459
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Panel3: TPanel
      Left = 1
      Top = 208
      Width = 1089
      Height = 250
      Align = alBottom
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 1087
        Height = 13
        Align = alTop
        Caption = 
          '  Itens encontrados nos documentos de envio de consigna'#231#227'o (Dado' +
          's para consulta) '
        ExplicitWidth = 408
      end
      object cxGridCitel2: TcxGridCitel
        Left = 1
        Top = 14
        Width = 1087
        Height = 235
        Align = alClient
        TabOrder = 0
        object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyPress = grdItensEditKeyPress
          DataController.DataSource = dtsItensDocumentoEnvio
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo Item'
            DataBinding.FieldName = 'ITE_CODITE'
            Options.Editing = False
            Width = 70
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE'
            Options.Editing = False
            Width = 330
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Unidade de medida'
            DataBinding.FieldName = 'ITE_UNIDAD'
            Options.Editing = False
            Width = 175
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = 'Vlr.Unit'#225'rio'
            DataBinding.FieldName = 'ITE_UNITAR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 200
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'Saldo'
            DataBinding.FieldName = 'ITE_SALDO_'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-#,##0.00'
            Options.Editing = False
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableViewCitel1
        end
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 1089
      Height = 207
      Align = alClient
      TabOrder = 1
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 1087
        Height = 13
        Align = alTop
        Caption = 
          '  Relacione a unidade de medida e o valor unit'#225'rio de envio com ' +
          'os valores correspondentes aos de retorno'
        ExplicitWidth = 514
      end
      object cxGridCitel1: TcxGridCitel
        Left = 1
        Top = 14
        Width = 1087
        Height = 192
        Align = alClient
        TabOrder = 0
        object grdItens: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyPress = grdItensEditKeyPress
          DataController.DataSource = dtsItens
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdItensColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo Item'
            DataBinding.FieldName = 'ITE_CODITE'
            Options.Editing = False
            Width = 70
          end
          object grdItensColumn2: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE'
            Options.Editing = False
            Width = 330
          end
          object grdItensColumn4: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'ITE_QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '#,##0.00;-#,##0.00'
            Options.Editing = False
          end
          object grdItensColumn3: TcxGridDBColumn
            Caption = 'Unidade no Doc.Retorno'
            DataBinding.FieldName = 'ITE_UNDRET'
            Options.Editing = False
            Width = 130
          end
          object grdItensColumn5: TcxGridDBColumn
            Caption = 'Vlr.Unit'#225'rio do Doc.Retorno'
            DataBinding.FieldName = 'ITE_UNIRET'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Options.Editing = False
            Width = 140
          end
          object grdItensColumn7: TcxGridDBColumn
            Caption = 'Unidade no Doc.Envio'
            DataBinding.FieldName = 'ITE_UNDENV'
            OnCustomDrawCell = grdItensColumn7CustomDrawCell
            Width = 130
          end
          object grdItensColumn6: TcxGridDBColumn
            Caption = 'Vlr.Unit'#225'rio do Doc.Envio'
            DataBinding.FieldName = 'ITE_UNITAR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            OnCustomDrawCell = grdItensColumn6CustomDrawCell
            Width = 140
          end
        end
        object cxGridCitel1Level1: TcxGridLevel
          GridView = grdItens
        end
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 144
    Top = 24
  end
  object dtsItens: TDataSource
    Left = 16
    Top = 32
  end
  object dtsItensDocumentoEnvio: TDataSource
    Left = 64
    Top = 288
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 657
    Top = 73
  end
end
