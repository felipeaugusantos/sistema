inherited frmManutencaoOrdProVidro: TfrmManutencaoOrdProVidro
  Width = 967
  Height = 684
  Caption = 'Manuten'#231#227'o Ordem de Produ'#231#227'o'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 967
  ExplicitHeight = 684
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 611
    Width = 961
    ExplicitTop = 611
    ExplicitWidth = 961
    inherited FlwBotoes: TFlowPanel
      Width = 957
      ExplicitWidth = 957
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 23
        Caption = '&Confirma'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 881
      ExplicitLeft = 881
    end
  end
  inherited pnlStatus: TPanel
    Top = 639
    Width = 961
    ExplicitTop = 639
    ExplicitWidth = 961
    inherited pnlNomeForm: TPanel
      Left = 790
      ExplicitLeft = 790
    end
    inherited pnlInfo: TPanel
      Width = 790
      ExplicitWidth = 790
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 961
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label6: TLabel
      Left = 128
      Top = 3
      Width = 87
      Height = 14
      Caption = 'Numero do Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEspecie: TLabel
      Left = 220
      Top = 3
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 261
      Top = 3
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblSerie: TLabel
      Left = 307
      Top = 3
      Width = 25
      Height = 14
      Caption = 'Serie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDocumento: TEditFocus
      Tag = 99
      Left = 126
      Top = 16
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtDocumentoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Tag = 99
      Left = 220
      Top = 16
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'NF'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 261
      Top = 16
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object btnCarregar: TBitBtnLocked
      Tag = 99
      Left = 352
      Top = 16
      Width = 97
      Height = 22
      Caption = '&Carregar'
      TabOrder = 3
      OnClick = btnCarregarClick
    end
    object rdgDocVendaOuPedVenda: TRadioGroup
      Left = 0
      Top = 0
      Width = 122
      Height = 46
      Align = alLeft
      Caption = 'Tipo de Busca'
      Items.Strings = (
        'Pedido de Venda'
        'Venda')
      TabOrder = 4
      OnClick = rdgDocVendaOuPedVendaClick
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 307
      Top = 16
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 46
    Width = 961
    Height = 565
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 0
      Top = 388
      Width = 961
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 0
      ExplicitWidth = 391
    end
    object cxDados: TcxGridCitel
      Left = 0
      Top = 0
      Width = 961
      Height = 388
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDados: TcxGridDBTableViewCitel
        OnKeyPress = cxgDadosKeyPress
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
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
        object cxgDadosCODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          MinWidth = 64
          Options.Editing = False
        end
        object cxgDadosDESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 288
        end
        object cxgDadosREFERE: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Width = 99
        end
        object cxgDadosSIGUNI: TcxGridDBColumn
          Caption = 'Unidade'
          DataBinding.FieldName = 'SIGUNI'
          Options.Editing = False
        end
        object cxgDadosQTDARQ: TcxGridDBColumn
          Caption = 'Qtd. Original'
          DataBinding.FieldName = 'QTDARQ'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.EditFormat = True
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 77
        end
        object cxgDadosTOTBAI: TcxGridDBColumn
          Caption = 'Qtd. Baixada'
          DataBinding.FieldName = 'TOTBAI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.EditFormat = True
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 78
        end
        object cxgDadosQTDRES: TcxGridDBColumn
          Caption = 'Qtd. Restante'
          DataBinding.FieldName = 'QTDRES'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.EditFormat = True
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 91
        end
        object cxgDadosQTDITE: TcxGridDBColumn
          Caption = 'Qtd. Ord. Prod.'
          DataBinding.FieldName = 'QTDITE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.EditFormat = True
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 95
        end
        object cxgDadosQTDBAI: TcxGridDBColumn
          Caption = 'Qtd. Adc. Ord. Prod.'
          DataBinding.FieldName = 'QTDBAI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.EditFormat = True
          Properties.DecimalPlaces = 4
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Width = 121
        end
        object cxgDadosCOD_RECEBEDOR: TcxGridDBColumn
          Caption = 'C'#243'd Recebedor'
          DataBinding.FieldName = 'COD_RECEBEDOR'
          Width = 97
        end
        object cxgDadosNOM_RECEBEDOR: TcxGridDBColumn
          Caption = 'Recebedor'
          DataBinding.FieldName = 'NOM_RECEBEDOR'
          Options.Editing = False
          Width = 263
        end
      end
      object cxlDados: TcxGridLevel
        GridView = cxgDados
      end
    end
    object cxGridCitel1: TcxGridCitel
      Left = 0
      Top = 391
      Width = 961
      Height = 147
      Align = alBottom
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsBaixa
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
        object cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'OPERADOR'
          Width = 405
        end
        object cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn
          Caption = 'Data da Baixa'
          DataBinding.FieldName = 'DTABAI'
          HeaderAlignmentHorz = taCenter
          Width = 120
        end
        object cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn
          Caption = 'Qtd. Baixa'
          DataBinding.FieldName = 'QTD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.0000'
          HeaderAlignmentHorz = taRightJustify
          Width = 111
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxGridCitel1DBTableViewCitel1
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 538
      Width = 961
      Height = 27
      Align = alBottom
      TabOrder = 2
      object lblBaixada: TLabel
        Left = 248
        Top = 6
        Width = 174
        Height = 14
        Caption = 'Ordem de Produ'#231#227'o original baixada'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object btnIncluirItem: TBitBtnLocked
        Left = 1
        Top = 1
        Width = 112
        Height = 25
        Align = alLeft
        Caption = '&Incluir Item'
        Enabled = False
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
        Enabled = False
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
      object chkBaixarOrdemProducao: TCheckBox
        Left = 283
        Top = 6
        Width = 230
        Height = 17
        Caption = 'Baixar ordem de produ'#231#227'o ao confirmar?'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 2
      end
    end
  end
  object dtsDados: TDataSource
    Left = 576
    Top = 256
  end
  object dtsBaixa: TDataSource
    Left = 584
    Top = 312
  end
end
