inherited frmExportarArquivosTinta: TfrmExportarArquivosTinta
  Width = 952
  Height = 628
  BorderIcons = [biSystemMenu]
  Caption = 'Coral Imobili'#225'ria - Exportar Registros'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 952
  ExplicitHeight = 628
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 556
    Width = 946
    TabOrder = 1
    ExplicitTop = 556
    ExplicitWidth = 946
    inherited btnSair: TBitBtnLocked
      Left = 863
      ExplicitLeft = 863
    end
    object btnGerar: TBitBtnLocked
      Left = 781
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Gerar'
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
      OnClick = btnGerarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 584
    Width = 946
    TabOrder = 2
    ExplicitTop = 584
    ExplicitWidth = 946
    inherited pnlNomeForm: TPanel
      Left = 775
      ExplicitLeft = 775
    end
    inherited pnlInfo: TPanel
      Width = 775
      ExplicitWidth = 775
    end
  end
  object pnlTop: TPanel [2]
    Left = 0
    Top = 0
    Width = 946
    Height = 65
    Align = alTop
    TabOrder = 0
    object Shape1: TShape
      Left = 632
      Top = 16
      Width = 16
      Height = 12
      Brush.Color = clRed
    end
    object Shape2: TShape
      Left = 632
      Top = 32
      Width = 16
      Height = 12
      Brush.Color = clBlue
    end
    object Label2: TLabel
      Left = 652
      Top = 32
      Width = 117
      Height = 15
      Caption = 'Registros Pendentes'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 652
      Top = 16
      Width = 119
      Height = 15
      Caption = 'Registros Exportados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object rdgStatus: TRadioGroup
      Left = 1
      Top = 8
      Width = 184
      Height = 41
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Pendentes'
        'Exportados')
      ParentFont = False
      TabOrder = 0
      OnClick = rdgStatusClick
    end
  end
  object pnlBotton: TPanel [3]
    Left = 0
    Top = 515
    Width = 946
    Height = 41
    Align = alBottom
    TabOrder = 3
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 185
      Height = 39
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Panel1'
      TabOrder = 0
      object btnRegistros: TBitBtnLocked
        Left = 11
        Top = 13
        Width = 121
        Height = 22
        Caption = '&Marcar Todos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460FEEBF82E98E3593460FFF00FF00000000000000
          0000000000000000000000000000000000000000000000FF00FF93460F5DD270
          F7DAB793460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnRegistrosClick
      end
    end
    object Panel2: TPanel
      Left = 690
      Top = 1
      Width = 255
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object lblQuantidade: TLabel
        Left = 0
        Top = 24
        Width = 255
        Height = 15
        Align = alBottom
        Caption = 'Quantidade de Registros: 0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 153
      end
    end
  end
  object Panel3: TPanel [4]
    Left = 0
    Top = 65
    Width = 946
    Height = 450
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 4
    object dbgRegistros: TDBGridCitel
      Left = 1
      Top = 1
      Width = 944
      Height = 448
      Align = alClient
      DataSource = dtsRegistros
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgRegistrosDrawColumnCell
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DET_NUMDOC'
          Title.Caption = 'Doc.'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DET_ESPDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Esp.'
          Width = 40
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DET_DTAENT'
          Title.Alignment = taCenter
          Title.Caption = 'Data'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DET_CODEMP'
          Title.Alignment = taCenter
          Title.Caption = 'Emp.'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_DESCRI'
          Title.Caption = 'Nome da Cor'
          Width = 234
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'UNI_DESUNI'
          Title.Alignment = taCenter
          Title.Caption = 'Unidade'
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'DET_QTDEMB'
          Title.Alignment = taRightJustify
          Title.Caption = 'Volume'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_NOMCLI'
          Title.Caption = 'Nome do Cliente'
          Width = 350
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_PREVE1'
          Title.Caption = 'Valor da Venda'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AUTOINCREM'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DIRARQEXP'
          Title.Caption = 'Diret'#243'rio do Arquivo'
          Visible = False
        end>
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 824
    Top = 104
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 768
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 752
    Top = 192
  end
  object dtsRegistros: TDataSource
    DataSet = cdsRegistros
    OnDataChange = dtsRegistrosDataChange
    Left = 376
    Top = 121
  end
  object cdsRegistros: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 129
  end
end
