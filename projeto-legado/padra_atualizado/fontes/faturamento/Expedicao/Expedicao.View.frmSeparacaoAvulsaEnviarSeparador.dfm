inherited frmSeparacaoAvulsaEnviarSeparador: TfrmSeparacaoAvulsaEnviarSeparador
  Width = 692
  Height = 500
  Caption = 'Separa'#231#227'o Avulsa - Envio ao Separador'
  ExplicitWidth = 692
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 429
    Width = 686
    TabOrder = 2
    ExplicitTop = 429
    ExplicitWidth = 686
    inherited FlwBotoes: TFlowPanel
      Width = 682
      ExplicitTop = 2
      ExplicitWidth = 682
    end
    inherited btnSair: TBitBtnLocked
      Left = 606
      ExplicitLeft = 606
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 686
    TabOrder = 3
    ExplicitTop = 455
    ExplicitWidth = 686
    inherited pnlNomeForm: TPanel
      Left = 515
      ExplicitLeft = 515
    end
    inherited pnlInfo: TPanel
      Width = 515
      ExplicitWidth = 515
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 686
    Height = 73
    Align = alTop
    TabOrder = 5
    object Label1: TLabel
      Left = 32
      Top = 16
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label2: TLabel
      Left = 14
      Top = 42
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object edtDescricaoProduto: TEditFocus
      Left = 143
      Top = 12
      Width = 517
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodigoProduto: TEditFocus
      Left = 74
      Top = 12
      Width = 68
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtQuantidade: TEditFocus
      Left = 74
      Top = 38
      Width = 103
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  object pnlSeparacao: TPanel [4]
    Left = 0
    Top = 73
    Width = 686
    Height = 47
    Align = alTop
    TabOrder = 0
    object Label4: TLabel
      Left = 18
      Top = 16
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Separador:'
    end
    object edtCodigoSeparador: TEditFocus
      Tag = 99
      Left = 74
      Top = 12
      Width = 68
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodigoSeparadorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomeSeparador: TEditFocus
      Left = 143
      Top = 12
      Width = 517
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  end
  object pnlLotes: TPanel [5]
    Left = 0
    Top = 120
    Width = 686
    Height = 309
    Align = alClient
    TabOrder = 1
    object lblNumLot: TLabel
      Left = 6
      Top = 13
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero Lote:'
    end
    object lblQuantidade: TLabel
      Left = 326
      Top = 14
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object cxgLotes: TcxGridCitel
      Left = 1
      Top = 44
      Width = 684
      Height = 264
      Align = alBottom
      TabOrder = 4
      object cxgLotesDBTBV: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsLotes
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = cxgLotesQUANTIDADE
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgLotesNUMERO_LOTE: TcxGridDBColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'NUMERO_LOTE'
          Width = 222
        end
        object cxgLotesQUANTIDADE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QUANTIDADE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          Width = 103
        end
      end
      object cxgLotesLVL: TcxGridLevel
        GridView = cxgLotesDBTBV
      end
    end
    object edtNumeroLote: TEditFocus
      Tag = 99
      Left = 74
      Top = 10
      Width = 230
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 0
      OnKeyPress = edtNumeroLoteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQuantidadeLote: TEditFocus
      Tag = 99
      Left = 386
      Top = 10
      Width = 71
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnAdicionarLote: TBitBtnLocked
      Left = 492
      Top = 9
      Width = 81
      Height = 25
      Caption = 'A&dicionar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000030000000E000000150000000C0000
        0002000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000200000012072B199C136940FF051E127A0000
        000C000000010000000000000000000000000000000000000000000000000000
        0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
        063D000000060000000000000000000000000000000000000000000000000000
        0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
        2BCE000000150000000200000000000000000000000000000000000000000000
        00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
        65FF082B1A8A0000000C00000001000000000000000000000000000000000000
        00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
        9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
        00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
        B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
        0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
        AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
        0000000000030000000600000005000000020000000000000002010302121A63
        44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
        0000000000000000000000000000000000000000000000000000000000020105
        03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000010002010B15573DA5509769FF0822184A00000004000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000100000004000000060000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 2
      OnClick = btnAdicionarLoteClick
    end
    object btnExcluirLote: TBitBtnLocked
      Left = 579
      Top = 9
      Width = 81
      Height = 25
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
      TabOrder = 3
      OnClick = btnExcluirLoteClick
    end
  end
  object dtsLotes: TDataSource
    Left = 332
    Top = 216
  end
end
