inherited frmBaixaOrdProdAcabado: TfrmBaixaOrdProdAcabado
  Width = 684
  Height = 453
  Caption = 'Ordem de Produ'#231#227'o Pedido de Venda - '
  ExplicitWidth = 684
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 678
    ExplicitTop = 380
    ExplicitWidth = 678
    inherited FlwBotoes: TFlowPanel
      Width = 674
      ExplicitWidth = 674
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 97
        Height = 22
        Caption = '&Confirmar'
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
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 595
      ModalResult = 8
      ExplicitLeft = 595
    end
  end
  inherited pnlStatus: TPanel
    Top = 408
    Width = 678
    ExplicitTop = 408
    ExplicitWidth = 678
    inherited pnlNomeForm: TPanel
      Left = 507
      ExplicitLeft = 507
    end
    inherited pnlInfo: TPanel
      Width = 507
      ExplicitWidth = 507
    end
  end
  object pnlOrdPro: TPanel [2]
    Left = 0
    Top = 0
    Width = 678
    Height = 63
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object Label3: TLabel
      Left = 29
      Top = 10
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Ordem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDigita: TLabel
      Left = 25
      Top = 38
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Separador:'
    end
    object edtOrdPro: TEditFocus
      Tag = 99
      Left = 84
      Top = 6
      Width = 115
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 84
      Top = 34
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 141
      Top = 34
      Width = 515
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlIteEst: TPanel [3]
    Left = 0
    Top = 63
    Width = 678
    Height = 317
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object dbgIteFatDor: TcxGridCitel
      Left = 2
      Top = 2
      Width = 674
      Height = 286
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgIteFatDorTV: TcxGridDBTableViewCitel
        OnKeyPress = dbgIteFatDorTVKeyPress
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsGrid
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '00'
            Kind = skCount
            Column = dbgIteFatDorTVCODITE
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object dbgIteFatDorTVCODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Options.Focusing = False
          Options.AutoWidthSizable = False
          Width = 89
        end
        object dbgIteFatDorTVDESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Options.Focusing = False
          Width = 285
        end
        object dbgIteFatDorTVSIGUNI: TcxGridDBColumn
          Caption = 'Unid.'
          DataBinding.FieldName = 'SIGUNI'
          Options.Editing = False
          Options.Focusing = False
          Options.AutoWidthSizable = False
          Width = 67
        end
        object dbgIteFatDorTVQTDITE: TcxGridDBColumn
          Caption = 'Quantidade Pedido'
          DataBinding.FieldName = 'QTDITE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 110
        end
        object dbgIteFatDorTVQTDBAI: TcxGridDBColumn
          Caption = 'Quantidade Baixa'
          DataBinding.FieldName = 'QTDBAI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Options.AutoWidthSizable = False
          Width = 110
        end
      end
      object dbgIteFatDorLvl: TcxGridLevel
        GridView = dbgIteFatDorTV
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 288
      Width = 674
      Height = 27
      Align = alBottom
      TabOrder = 1
      object btnIncluirItem: TBitBtnLocked
        Left = 1
        Top = 1
        Width = 112
        Height = 25
        Align = alLeft
        Caption = '&Incluir Item'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
          25D0522C17931209053000000009000000010000000000000000000000000000
          00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
          6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
          0110744226B9BC7C4DFFDDAE77FFDEB076FFE2B782FFE3BB87FFE3BC86FFE1B7
          82FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
          2095BE8053FFE0B37CFFDFB076FFDEB177FFB78254FFAA7144FFAB7245FFBC88
          59FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
          47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFA56B3FFFF5EFEAFFF8F3EEFFAB72
          45FFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
          6FFFE2B780FFE5BD89FFE7C291FFE8C393FFA56B3FFFF1E6DEFFF9F5F1FFAA71
          44FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
          83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFF5EDE6FFFAF6F3FFAD75
          47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
          8FFFE4BB84FFA56B3FFFF3EBE6FFFAF6F3FFF6EFE8FFF7F0EAFFFBF7F5FFFAF7
          F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
          A0FFE5BE89FFA56B3FFFE0D2CAFFE1D3CCFFE3D5CFFFF2EAE4FFF8F3EFFFEADF
          D9FFE6DAD4FFE9DED9FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
          ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFF1EAE5FFFAF6F3FFA56B
          3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
          9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFA56B3FFFF0EAE7FFFDFCFBFFA56B
          3FFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
          6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFA56B3FFFDECFC9FFDFD1CBFFA56B
          3FFFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
          3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFB98A5FFFA56B3FFFA56B3FFFBA8A
          5FFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
          0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
          CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
          00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
          B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
          000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
          60CD6C543F8B16110D2200000003000000010000000000000000}
        TabOrder = 0
        OnClick = btnIncluirItemClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 113
        Top = 1
        Width = 112
        Height = 25
        Align = alLeft
        Caption = '&Excluir'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020000000A00000010000000090000000200000000000000000000
          00020000000A000000120000000C000000030000000000000000000000000000
          00020000000F0F0742921D0F7EEF0603347A0000000E00000002000000020000
          000F0804347C1D0F7EF00F084194000000120000000200000000000000000000
          0008120B47923233AFFF3648CCFF1D1EA5FF0603357A0000000F0000000F0703
          357C1F20A5FF3747CCFF2D2FAEFF120B46950000000B00000000000000000000
          000C281C8DF1596CD8FF3B51D3FF3A4FD2FF1E22A6FF0602347D0502357E2022
          A6FF3A50D3FF3A50D3FF4C5FD4FF291D8CF10000001000000000000000000000
          0006130F3C734D4FBAFF667EE0FF415AD6FF415AD7FF1F24A7FF2529A8FF415A
          D7FF415AD7FF5B72DEFF484AB8FF130F3C790000000900000000000000000000
          00010000000A16123F73585CC1FF758DE6FF4A64DBFF4A65DBFF4A65DBFF4A64
          DBFF6983E3FF5356C0FF16123F780000000C0000000200000000000000000000
          0000000000010000000A191643755D63C7FF6783E5FF5774E2FF5774E2FF5774
          E2FF565CC6FF1916437A0000000D000000020000000000000000000000000000
          00000000000100000009100E3D734A50BEFF7492EBFF6383E7FF6483E7FF6383
          E7FF3840B6FF0B0839780000000C000000020000000000000000000000000000
          0001000000071413416E555CC5FF85A1EFFF7897EDFF9CB6F4FF9DB7F5FF7997
          EEFF7796EDFF414ABCFF0E0C3C730000000A0000000100000000000000000000
          00041818456B636CCFFF93AFF3FF83A1F1FFA6BFF7FF676DCAFF7E87DDFFAFC7
          F8FF83A3F2FF83A1F1FF5058C4FF121040710000000600000000000000000000
          00065759C3EFAFC6F6FF8EADF4FFABC4F8FF6F76D0FF1817456F24244F70868E
          E1FFB5CCF9FF8DACF4FFA1B8F4FF5758C3EF0000000900000000000000000000
          000331326B8695A0EAFFC0D3F9FF7880D7FF1C1C496B00000006000000072527
          526C8B93E6FFC1D3F9FF949EE9FF303168870000000500000000000000000000
          00010000000431336B825E62CBEC1F204D680000000500000001000000010000
          00052728536B5E62CBEC31326883000000070000000100000000000000000000
          0000000000000000000200000004000000020000000100000000000000000000
          0001000000030000000500000004000000010000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnExcluirClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 8
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 248
    Top = 216
    object cdsItensCODITE: TStringField
      DisplayWidth = 20
      FieldName = 'CODITE'
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensAUTINC: TStringField
      FieldName = 'AUTINC'
      Size = 22
    end
    object cdsItensSEQGER: TStringField
      FieldName = 'SEQGER'
      Size = 22
    end
    object cdsItensSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 4
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsItensQTDBAI: TFloatField
      FieldName = 'QTDBAI'
      OnValidate = cdsItensQTDBAIValidate
    end
    object cdsItensPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsItensPREMED: TFloatField
      FieldName = 'PREMED'
    end
    object cdsItensTOTCUS: TAggregateField
      FieldName = 'TOTCUS'
      Active = True
      DisplayName = ''
      Expression = 'SUM(PRECUS * QTDBAI)'
    end
    object cdsItensTOTMED: TAggregateField
      FieldName = 'TOTMED'
      Active = True
      DisplayName = ''
      Expression = 'SUM(PREMED * QTDBAI)'
    end
    object cdsItensTOTBAI: TAggregateField
      FieldName = 'TOTBAI'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDBAI)'
    end
  end
  object dtsGrid: TDataSource
    DataSet = cdsItens
    Left = 280
    Top = 216
  end
  object cdsProdutoAcabado: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 256
    Top = 272
    object cdsProdutoAcabadoAUTINC: TStringField
      DisplayWidth = 20
      FieldName = 'AUTINC'
    end
    object cdsProdutoAcabadoSEQGER: TStringField
      DisplayWidth = 20
      FieldName = 'SEQGER'
    end
    object cdsProdutoAcabadoCODITE: TStringField
      DisplayWidth = 20
      FieldName = 'CODITE'
    end
    object cdsProdutoAcabadoDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsProdutoAcabadoSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsProdutoAcabadoQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsProdutoAcabadoQTDBAI: TFloatField
      FieldName = 'QTDBAI'
    end
    object cdsProdutoAcabadoPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsProdutoAcabadoPREMED: TFloatField
      FieldName = 'PREMED'
    end
    object cdsProdutoAcabadoTOTCUS: TAggregateField
      FieldName = 'TOTCUS'
      Active = True
      DisplayName = ''
      Expression = 'SUM(PRECUS * QTDBAI)'
    end
    object cdsProdutoAcabadoTOTMED: TAggregateField
      FieldName = 'TOTMED'
      Active = True
      DisplayName = ''
      Expression = 'SUM(PREMED * QTDBAI)'
    end
    object cdsProdutoAcabadoTOTBAI: TAggregateField
      FieldName = 'TOTBAI'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDBAI)'
    end
  end
end
