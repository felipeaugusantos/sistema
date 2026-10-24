inherited frmFatItensRetornoRemessa: TfrmFatItensRetornoRemessa
  Caption = 'Itens para retorno de remessa'
  Position = poMainFormCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 769
    Height = 460
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Panel2: TPanel
      Left = 1
      Top = 433
      Width = 767
      Height = 26
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 0
      object FlowPanel1: TFlowPanel
        Left = 2
        Top = 2
        Width = 0
        Height = 22
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 2
        Visible = False
      end
      object btnCancelar: TBitBtnLocked
        Left = 688
        Top = 2
        Width = 77
        Height = 22
        Align = alRight
        Cancel = True
        Caption = 'C&ancela'
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
        ModalResult = 2
        TabOrder = 1
        OnClick = btnSairClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 3
        Top = 1
        Width = 75
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    object DBGridCitel1: TDBGridCitel
      Left = 1
      Top = 1
      Width = 767
      Height = 432
      Align = alClient
      DataSource = dtsItens
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DET_NUMDOC'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLI_NOMCLI'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OPE_NOMOPE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_DTAENT'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_CODEMP'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_ESPDOC'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_CODITE'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_DESITE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_QTDITE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GER_CODTRA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRA_NOMTRA'
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 712
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 712
    Top = 72
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 192
    Top = 80
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 80
    object cdsItensDET_NUMDOC: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'DET_NUMDOC'
      Size = 12
    end
    object cdsItensCLI_NOMCLI: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsItensOPE_NOMOPE: TStringField
      DisplayLabel = 'Vendedor'
      FieldName = 'OPE_NOMOPE'
      Size = 30
    end
    object cdsItensDET_DTAENT: TDateField
      DisplayLabel = 'Data Faturamento'
      FieldName = 'DET_DTAENT'
    end
    object cdsItensDET_CODEMP: TStringField
      DisplayLabel = 'C'#243'd. Empresa'
      FieldName = 'DET_CODEMP'
      Size = 3
    end
    object cdsItensDET_ESPDOC: TStringField
      DisplayLabel = 'Esp. Documento'
      FieldName = 'DET_ESPDOC'
      Size = 2
    end
    object cdsItensDET_CODITE: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'DET_CODITE'
      Size = 5
    end
    object cdsItensDET_DESITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'DET_DESITE'
      Size = 70
    end
    object cdsItensDET_QTDITE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'DET_QTDITE'
      DisplayFormat = '#0.0000'
    end
    object cdsItensGER_CODTRA: TStringField
      DisplayLabel = 'C'#243'd. Transp.'
      FieldName = 'GER_CODTRA'
      Size = 5
    end
    object cdsItensTRA_NOMTRA: TStringField
      DisplayLabel = 'Transp.'
      FieldName = 'TRA_NOMTRA'
      Size = 40
    end
  end
end
