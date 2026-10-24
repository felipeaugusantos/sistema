inherited frmMovimentacaoProgramadaVencimento: TfrmMovimentacaoProgramadaVencimento
  Width = 1024
  Height = 633
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 
    'Gera'#231#227'o de Movimenta'#231#227'o Programada - Digita'#231#227'o Global - Itens Pr' +
    #243'ximos ao Vencimento'
  ExplicitWidth = 1024
  ExplicitHeight = 633
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 562
    Width = 1018
    ExplicitTop = 562
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      ExplicitLeft = 938
    end
  end
  inherited pnlStatus: TPanel
    Top = 588
    Width = 1018
    ExplicitTop = 588
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlCabec: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 28
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblDigita: TLabel
      Left = 2
      Top = 11
      Width = 330
      Height = 14
      Caption = 
        'Quantidade de dias para o vencimento:                     dias o' +
        'u menos   '
    end
    object edtDia: TEditFocus
      Tag = 99
      Left = 193
      Top = 4
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConsultar: TBitBtnLocked
      Left = 338
      Top = 3
      Width = 81
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
      TabOrder = 1
      OnClick = btnConsultarClick
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 28
    Width = 1018
    Height = 534
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxgItensViewEditKeyPress
      DataController.DataSource = dtsGrid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgItensViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 66
      end
      object cxgItensViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 162
      end
      object cxgItensViewDESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'DESMAR'
        Options.Editing = False
        Width = 73
      end
      object cxgItensViewSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 50
      end
      object cxgItensViewLOCORI: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 79
      end
      object cxgItensViewLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 100
      end
      object cxgItensViewDTAVAL: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'DTAVAL'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 63
      end
      object cxgItensViewDIAVAL: TcxGridDBColumn
        Caption = 'Qtde de Dias p/ Venc.'
        DataBinding.FieldName = 'DIAVAL'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 111
      end
      object cxgItensViewSALDOS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'SALDOS'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 114
      end
      object cxgItensViewLOCDES: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o Destino'
        DataBinding.FieldName = 'LOCDES'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxgItensViewLOCDESPropertiesValidate
        Options.AutoWidthSizable = False
        Width = 129
      end
      object cxgItensViewQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.OnValidate = cxgItensViewQTDITEPropertiesValidate
        Options.AutoWidthSizable = False
        Width = 69
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 96
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 168
    Top = 176
    object cdsItensAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsItensCODITE: TStringField
      DisplayWidth = 20
      FieldName = 'CODITE'
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 30
    end
    object cdsItensSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsItensNUMLOT: TStringField
      FieldName = 'NUMLOT'
    end
    object cdsItensLOCFIS: TStringField
      FieldName = 'LOCFIS'
    end
    object cdsItensDTAVAL: TDateField
      FieldName = 'DTAVAL'
    end
    object cdsItensDIAVAL: TStringField
      Alignment = taRightJustify
      FieldName = 'DIAVAL'
    end
    object cdsItensSALDOS: TFloatField
      FieldName = 'SALDOS'
      DisplayFormat = '0.00'
    end
    object cdsItensLOCDES: TStringField
      FieldName = 'LOCDES'
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensCRITIC: TStringField
      FieldName = 'CRITIC'
      Size = 1
    end
  end
  object dtsGrid: TDataSource
    DataSet = cdsItens
    Left = 232
    Top = 160
  end
end
