inherited frmFatAltVendedor: TfrmFatAltVendedor
  Left = 482
  Top = 194
  Width = 900
  Height = 590
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o de Vendedor do Documento de Venda'
  Position = poMainFormCenter
  ExplicitWidth = 900
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 545
    Width = 894
    TabOrder = 5
    ExplicitTop = 545
    ExplicitWidth = 894
    inherited pnlInfo: TPanel [0]
      Width = 723
      ExplicitWidth = 723
    end
    inherited pnlNomeForm: TPanel [1]
      Left = 723
      ExplicitLeft = 723
    end
  end
  object pnlBusca: TPanel [1]
    Left = 0
    Top = 0
    Width = 894
    Height = 92
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label5: TLabel
      Left = 9
      Top = 13
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label3: TLabel
      Left = 21
      Top = 36
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 161
      Top = 13
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label1: TLabel
      Left = 31
      Top = 58
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtDocum: TEditFocus
      Tag = 99
      Left = 68
      Top = 9
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 68
      Top = 32
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 204
      Top = 9
      Width = 28
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDesEmp: TEditFocus
      Left = 132
      Top = 32
      Width = 751
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 68
      Top = 55
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 4
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 132
      Top = 55
      Width = 751
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 92
    Width = 894
    Height = 135
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 1
    object Label2: TLabel
      Left = 704
      Top = 8
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dt.Emiss'#227'o:'
    end
    object Label6: TLabel
      Left = 11
      Top = 8
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o Pagamento:'
    end
    object lblVenAtu: TLabel
      Left = 11
      Top = 45
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor Atual:'
    end
    object Label7: TLabel
      Left = 796
      Top = 8
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Documento:'
    end
    object lblRepAtu: TLabel
      Left = 453
      Top = 45
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Representante Atual:'
    end
    object lblVe2Atu: TLabel
      Left = 11
      Top = 82
      Width = 86
      Height = 14
      Caption = 'Vendedor 2 Atual:'
    end
    object edtDtaFat: TEditFocus
      Tag = 99
      Left = 704
      Top = 22
      Width = 87
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtConPag: TEditFocus
      Tag = 99
      Left = 11
      Top = 22
      Width = 687
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesVen: TEditFocus
      Tag = 99
      Left = 76
      Top = 59
      Width = 370
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 12
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValDoc: TEditFocus
      Tag = 99
      Left = 796
      Top = 22
      Width = 87
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 11
      Top = 59
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodRep: TEditFocus
      Tag = 99
      Left = 453
      Top = 59
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesRep: TEditFocus
      Tag = 99
      Left = 518
      Top = 59
      Width = 365
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 12
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesVe2: TEditFocus
      Tag = 99
      Left = 76
      Top = 96
      Width = 370
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 12
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVe2: TEditFocus
      Tag = 99
      Left = 11
      Top = 96
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
  end
  object pnlVendedor: TPanel [3]
    Left = 0
    Top = 227
    Width = 894
    Height = 99
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object lblVen: TLabel
      Left = 12
      Top = 58
      Width = 57
      Height = 14
      Caption = 'Vendedor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodNew: TEditFocus
      Tag = 99
      Left = 11
      Top = 72
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodNewKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesNew: TEditFocus
      Left = 68
      Top = 72
      Width = 815
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgOpcAlt: TRadioGroup
      Tag = 99
      Left = 11
      Top = 7
      Width = 872
      Height = 47
      Caption = 'Op'#231#227'o de Altera'#231#227'o'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Vendedor'
        'Representante'
        'Vendedor 2')
      TabOrder = 0
      OnClick = rdgOpcAltClick
    end
  end
  object pnlGrid: TPanel [4]
    Left = 0
    Top = 326
    Width = 894
    Height = 193
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object cxGrid: TcxGrid
      Left = 2
      Top = 34
      Width = 890
      Height = 157
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridVendedores: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsProdutos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxGridVendedoresCodIte: TcxGridDBColumn
          Caption = 'C'#243'd.Item'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Options.Focusing = False
          Width = 50
        end
        object cxGridVendedoresDescri: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Options.Editing = False
          Options.Focusing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 175
        end
        object cxGridVendedoresUnidad: TcxGridDBColumn
          Caption = 'Und.'
          DataBinding.FieldName = 'UNIDAD'
          Options.Editing = False
          Options.Focusing = False
          Width = 30
        end
        object cxGridVendedoresQtdIte: TcxGridDBColumn
          Caption = 'Qtde'
          DataBinding.FieldName = 'QTDITE'
          Options.Editing = False
          Options.Focusing = False
          Width = 31
        end
        object cxGridVendedoresUnitar: TcxGridDBColumn
          Caption = 'Vr.Unit.'
          DataBinding.FieldName = 'UNITAR'
          Options.Editing = False
          Options.Focusing = False
          Width = 42
        end
        object cxGridVendedoresTotIte: TcxGridDBColumn
          Caption = 'Vr.Total'
          DataBinding.FieldName = 'TOTITE'
          Options.Editing = False
          Options.Focusing = False
          Width = 55
        end
        object cxGridVendedoresPedOri: TcxGridDBColumn
          Caption = 'Ped.Origem'
          DataBinding.FieldName = 'PEDORI'
          Options.Editing = False
          Options.Focusing = False
          SortIndex = 1
          SortOrder = soAscending
          Width = 118
        end
        object cxGridVendedoresCodVenAtual: TcxGridDBColumn
          Caption = 'Vend.Atual'
          DataBinding.FieldName = 'CODVENATU'
          Options.Editing = False
          Options.Focusing = False
          SortIndex = 2
          SortOrder = soAscending
          Width = 56
        end
        object cxGridVendedoresNomVenAtual: TcxGridDBColumn
          Caption = 'Nome.Vend.Atual'
          DataBinding.FieldName = 'NOMVENATU'
          Options.Editing = False
          Options.Focusing = False
          Width = 117
        end
        object cxGridVendedoresCodVenNovo: TcxGridDBColumn
          Caption = 'Vend.Novo'
          DataBinding.FieldName = 'CODVEN'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                424D360400000000000036000000280000001000000010000000010020000000
                000000000000C40E0000C40E0000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000090000000E0000
                0010000000100000001000000010000000100000001100000011000000110000
                0011000000100000000B00000003000000000000000019427ACA245AA5FF255C
                A7FF255BA7FF245AA6FF2459A6FF2358A5FF2358A4FF2356A4FF2256A4FF2255
                A3FF2154A3FF2153A1FF1C468AE303080F2900000002255DA5FF316BAEFF6DA6
                D5FF86CAF0FF46A6E4FF44A3E4FF41A1E3FF3FA0E2FF3C9EE2FF3B9CE1FF389B
                E0FF369AE0FF3498DFFF2C77C1FF10284D8B000000082B68AEFF4984BEFF4B8B
                C5FFB2E3F8FF68BBECFF55B0E8FF52AEE8FF4EACE7FF4CA9E6FF49A8E5FF47A6
                E4FF44A4E4FF41A2E3FF3A92D6FF1C4885D50000000D2F6FB4FF6CA7D2FF3F87
                C4FFAED9F0FF9AD8F5FF66BDEEFF63BBEDFF60B9EBFF5DB6EBFF5BB5EAFF57B2
                EAFF55B0E9FF51AEE7FF4FABE7FF2D69B1FF040B142F3276B9FF8FC7E6FF509F
                D4FF86BCE0FFC5EFFCFF78CAF2FF74C8F1FF72C5F0FF6FC4F0FF6DC2EFFF69C0
                EEFF66BDEEFF63BBEDFF60B9EBFF448BC9FF122D4D81357CBCFFAFE3F5FF75C8
                EDFF59A2D4FFDDF7FDFFDFF8FEFFDDF7FEFFDBF7FEFFD8F5FEFFD4F4FDFFD0F2
                FDFFCCEFFCFFC7EDFBFFC1EBFBFF9ACBE9FF215187CB3882C1FFC7F5FEFF97E5
                FCFF64BAE5FF4D9FD3FF4D9DD2FF4B9BD1FF4A99CFFF4998CFFF4896CEFF4694
                CCFF4592CBFF3073B7FF3072B6FF2F71B5FF2A65A4EA3A88C5FFCDF7FEFFA6EC
                FEFF9CE8FDFF93E4FBFF8EE1FBFF89DFFBFF86DEFAFF81DAFAFF7ED8F9FF7BD7
                F9FF79D6F9FF2A6BB0FF000000140000000A000000073D8EC8FFD0F8FEFFAEF0
                FEFFAAEEFEFFA6EDFEFFA5EBFDFFBBF2FDFFD4F9FEFFD5F9FEFFD3F8FEFFD1F8
                FEFFCEF7FDFF3680BFFF0000000800000000000000003F92CBFFD3F9FEFFB6F3
                FEFFB3F1FDFFB0F1FEFFB8EDFAFF4895CBFF3B8CC6FF3B8AC6FF3A89C5FF3A88
                C5FF3A87C3FF2A6391C20000000500000000000000004197CEFFE2FCFEFFE2FC
                FEFFE1FCFEFFD4F3FAFF458FBFEC040A0E1B0000000600000006000000060000
                0006000000060000000400000001000000000000000031739ABF429AD0FF4299
                D0FF4299D0FF4297CFFF15324459000000020000000000000000000000000000
                0000000000000000000000000000000000000000000000000002000000030000
                0003000000040000000300000002000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000}
              Kind = bkGlyph
            end>
          Properties.CharCase = ecUpperCase
          Properties.OnButtonClick = cxGridVendedoresCodVenPropertiesButtonClick
          Properties.OnValidate = cxGridVendedoresCodVenPropertiesValidate
          Width = 56
        end
        object cxGridVendedoresNomVenNovo: TcxGridDBColumn
          Caption = 'Nome Vend.Novo'
          DataBinding.FieldName = 'NOMVEN'
          Options.Focusing = False
          Width = 112
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridVendedores
      end
    end
    object pnlTitulo: TPanel
      Left = 2
      Top = 2
      Width = 890
      Height = 32
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object lblTitulo: TLabel
        Left = 385
        Top = 9
        Width = 123
        Height = 15
        Caption = 'Vendedores dos Itens'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited pnlBotoes: TPanel [5]
    Top = 519
    Width = 894
    Height = 26
    TabOrder = 4
    ExplicitTop = 519
    ExplicitWidth = 894
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 813
      Height = 22
      ExplicitWidth = 813
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 200
        Height = 22
        Caption = '&Confirma'
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
      object btnTrocaVendedor: TBitBtnLocked
        Left = 200
        Top = 0
        Width = 200
        Height = 22
        Caption = '&Trocar Vendedor de todos os itens'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000000000000C0000
          0007000000030000000A00000010000000050000000000000000000000000000
          0000000000030000000C000000100000000F00000008000000021115A0FF0304
          1F470000000B090C467B0C0F94FF000000100000000000000000000000000000
          00000000000A00632FFF00612EFF005929FF002611860000000912168AD40709
          4A8C0000001E0F1373BA090C66BA0000000D0000000000000000000000000000
          00000000000B00622EFF00190C5A001B0D5A005929FF000B052F12186696212A
          BDFF1F28BCFF161BACFF06083F79000000070000000000000000000000000000
          000000000009006934FF001B0D57001D0F5600602DFF0006031C0A0D3451171E
          AEFF05061A43161CAAFF02031633000000020000000000000000000000000000
          000000000007007B3FFF00783EFF007138FF00361B930000000800000009242D
          C1FF1A2083B5131997E10000000A000000000000000000000000000000000000
          000000000006007B3FFF0020105000211250007037FF00070418000000041D26
          89B0242EC1FF0E11619100000005000000000000000000000000000000000000
          000000000004008444FF0022124D001B0F3D00793EFF00100828000000021419
          546B212BC3FF070A314B00000002000000000000000000000000000000000000
          000000000002009653FF009351FF008A49FF0045238C000000030000000E0000
          00140000001700000013000000070000000200000000000000020000000B0000
          0014000000170000001800000019000000190000001300000005A86D49EEB576
          4FFFB5754FFFB5754DFF3220155C0000000600000000000000065837258CB26F
          49FFB16E48FFB06E47FFAF6D46FFB06C46FFAF6B45FF00000011855A3FC0DDB9
          94FFE7C696FFC39469FF623B23B0040302190000000600000004000000135635
          219BCC9F78FFE7C493FFE4BD86FFE1B780FFB3734DFF000000144531236ACD9D
          79FFEFD6B1FFE6C495FFB9865DFF623C23AE2D1B115A0604021E2E1D125C6942
          2AB1C29069FFE6C495FFE8C597FFE3BD88FFB97B55FF000000120202010D9F76
          56D2E1C1A2FFF2DDB9FFEACBA0FFC79D73FFB27C54FFA46740FFB6815AFFCEA2
          7AFFE5C59BFFEFD5AEFFE6C6A2FFEBCDA1FFC0845EFF0000000F000000021D16
          102EB98D6AEAE0C09FFFF5E5C8FFF4E0BBFFF3DEB6FFF2DCB2FFF2DCB4FFF3DD
          B6FFF3DFBEFFDCB894FFBD8B65F5DBB691FFC58F67FF0000000D000000000000
          0002110D0A1D8F6D53B4D7AE89FFEBD4B7FFF5E5CAFFF9ECD2FFF3E2C6FFEAD0
          B0FFD3A984FF8B694EB6110D0925644C388BC9986FFF0000000A000000000000
          000000000001000000043E3125517C61499CA68163CDCEA079F9A68162CD7C60
          499D3E302453000000060000000200000006664F3A8400000004}
        TabOrder = 1
        OnClick = btnTrocaVendedorClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 815
      Top = 2
      Align = alRight
      ExplicitLeft = 815
      ExplicitTop = 2
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 8
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 509
    Top = 355
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 479
    Top = 355
    object cdsProdutosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 101
    end
    object cdsProdutosUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 2
    end
    object cdsProdutosQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosUNITAR: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'UNITAR'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosTOTITE: TFloatField
      DisplayLabel = 'QTDITE'
      FieldName = 'TOTITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosTABELA: TStringField
      FieldName = 'TABELA'
      Size = 7
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsProdutosCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsProdutosCODREP: TStringField
      FieldName = 'CODREP'
      Size = 3
    end
    object cdsProdutosCODVE2: TStringField
      FieldName = 'CODVE2'
      Size = 3
    end
    object cdsProdutosNOMVEN: TStringField
      FieldName = 'NOMVEN'
      Size = 100
    end
    object cdsProdutosNOMREP: TStringField
      FieldName = 'NOMREP'
      Size = 100
    end
    object cdsProdutosNOMVE2: TStringField
      FieldName = 'NOMVE2'
      Size = 100
    end
    object cdsProdutosCODVENATU: TStringField
      FieldName = 'CODVENATU'
      Size = 3
    end
    object cdsProdutosCODVE2ATU: TStringField
      FieldName = 'CODVE2ATU'
      Size = 3
    end
    object cdsProdutosCODREPATU: TStringField
      FieldName = 'CODREPATU'
      Size = 3
    end
    object cdsProdutosNOMVENATU: TStringField
      FieldName = 'NOMVENATU'
      Size = 100
    end
    object cdsProdutosNOMREPATU: TStringField
      FieldName = 'NOMREPATU'
      Size = 100
    end
    object cdsProdutosNOMVE2ATU: TStringField
      FieldName = 'NOMVE2ATU'
      Size = 100
    end
    object cdsProdutosPEDORI: TStringField
      FieldName = 'PEDORI'
      Size = 50
    end
  end
end
