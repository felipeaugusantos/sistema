inherited frmRecebimentoEntregaAgendada: TfrmRecebimentoEntregaAgendada
  Width = 662
  Height = 525
  Caption = 'Recebimento de Entrega Agendada'
  ExplicitWidth = 662
  ExplicitHeight = 525
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 454
    Width = 656
    TabOrder = 3
    ExplicitTop = 454
    ExplicitWidth = 656
    inherited FlwBotoes: TFlowPanel
      Width = 652
      ExplicitWidth = 652
      inherited btnConfirma: TBitBtnLocked
        Enabled = False
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 573
      ExplicitLeft = 573
    end
  end
  inherited pnlStatus: TPanel
    Top = 480
    Width = 656
    TabOrder = 4
    ExplicitTop = 480
    ExplicitWidth = 656
    inherited pnlNomeForm: TPanel
      Left = 485
      ExplicitLeft = 485
    end
    inherited pnlInfo: TPanel
      Width = 485
      ExplicitWidth = 485
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 656
    Height = 126
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object lbl4: TLabel
      Left = 89
      Top = 3
      Width = 75
      Height = 14
      Caption = 'Transportadora'
    end
    object lbl1: TLabel
      Left = 453
      Top = 3
      Width = 26
      Height = 14
      Caption = 'Placa'
    end
    object Label1: TLabel
      Left = 8
      Top = 5
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 89
      Height = 14
      Caption = 'Nome do Motorista'
    end
    object Label3: TLabel
      Left = 8
      Top = 84
      Width = 61
      Height = 14
      Caption = 'Identifica'#231#227'o'
    end
    object edtCodTra: TEditFocus
      Tag = 99
      Left = 89
      Top = 19
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtNomTra: TEditFocus
      Left = 140
      Top = 19
      Width = 307
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtPlaca_: TMaskEditFocus
      Tag = 99
      Left = 453
      Top = 19
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      EditMask = '>aaa-9a99;1;'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 3
      Text = '   -    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodigo: TEditFocus
      Tag = 99
      Left = 8
      Top = 19
      Width = 75
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = edtCodigoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttInteiro
    end
    object edtNomMot: TEditFocus
      Tag = 99
      Left = 8
      Top = 56
      Width = 441
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 60
      TipoTexto = ttAlfanumerico
    end
    object edtIdenti: TEditFocus
      Tag = 99
      Left = 8
      Top = 98
      Width = 441
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      ParentFont = False
      TabOrder = 5
      OnKeyPress = edtIdentiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 60
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlAcesso: TPanel [3]
    Left = 0
    Top = 126
    Width = 656
    Height = 96
    Align = alTop
    ParentColor = True
    TabOrder = 1
    object Label4: TLabel
      Left = 8
      Top = 5
      Width = 89
      Height = 14
      Caption = 'Chave de Acesso '
    end
    object Label5: TLabel
      Left = 8
      Top = 46
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object Label6: TLabel
      Left = 174
      Top = 46
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
    end
    object Label30: TLabel
      Left = 217
      Top = 46
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
    end
    object Label7: TLabel
      Left = 116
      Top = 46
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object edtAcesso: TEditFocus
      Tag = 99
      Left = 8
      Top = 20
      Width = 523
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 44
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 61
      Width = 103
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 44
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 174
      Top = 61
      Width = 37
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 44
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 217
      Top = 61
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 4
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 290
      Top = 61
      Width = 241
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 116
      Top = 61
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 44
      TabOrder = 2
      Text = 'NF'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgDocumentos: TcxGridCitel [4]
    Left = 0
    Top = 222
    Width = 656
    Height = 232
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDocumentosTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgDocumentosTableViewDOCCHK: TcxGridDBColumn
        Caption = 'Conferido'
        DataBinding.FieldName = 'DOCCHK'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = cxImageList1
        Properties.Items = <
          item
            ImageIndex = 0
            Value = '0'
          end
          item
            ImageIndex = 1
            Value = '1'
          end>
        Width = 54
      end
      object cxgDocumentosTableViewADC_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'ADC_NUMDOC'
        OnGetDataText = cxgDocumentosTableViewADC_NUMDOCGetDataText
        Width = 105
      end
      object cxgDocumentosTableViewADC_ESPDOC: TcxGridDBColumn
        Caption = 'Especie'
        DataBinding.FieldName = 'ADC_ESPDOC'
        Width = 63
      end
      object cxgDocumentosTableViewADC_SERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'ADC_SERIE_'
        Width = 52
      end
      object cxgDocumentosTableViewADC_CODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. Fornecedor'
        DataBinding.FieldName = 'ADC_CODFOR'
        Width = 90
      end
      object cxgDocumentosTableViewFOR_NOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Width = 277
      end
    end
    object cxgDocumentosLevel: TcxGridLevel
      GridView = cxgDocumentosTableView
    end
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 14680320
    ImageInfo = <
      item
        Image.Data = {
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
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000090000
          000D0000000F0000000F0000000F0000000F0000000F0000000F0000000F0000
          000F0000000F00000010000000100000000F0000000A000000021D5A42C0287D
          5AFF277D5AFF277C5AFF277C59FF277B59FF277B58FF277A58FF267A58FF2678
          57FF267A56FF267856FF267755FF257756FF1B563DC1000000092B825FFF53C8
          A2FF51C7A0FF50C7A0FF4EC69FFF4DC59DFF4CC59DFF4AC49BFF49C39BFF47C3
          99FF45C298FF45C198FF43C096FF42C095FF277B59FF0000000D2C8664FF5DCC
          AAFF43C398FF42C299FF42C298FF43C298FF65CFADFF74D5B6FF4CC59DFF40C0
          95FF3EC095FF3EBF94FF3DBF94FF4BC49CFF297F5CFF0000000E2F8B68FF67D1
          B0FF48C69EFF48C59CFF47C59CFF5FCDABFF25825DFF00673BFF51BA96FF44C3
          9AFF43C399FF43C298FF42C298FF54C9A4FF2B8360FF0000000D31906DFF71D5
          B8FF4DC9A3FF4DC9A1FF60CFADFF3B9372FF87AF9DFFB1CFC1FF26875FFF53CA
          A5FF48C69EFF47C59DFF47C59DFF5DCEABFF2D8865FF0000000C339671FF7ADA
          BFFF52CCA7FF60D1AFFF4BA183FF699782FFF8F1EEFFF9F3EEFF357F5DFF5CBD
          9DFF4EC9A2FF4CC9A2FF4CC8A1FF67D2B2FF2F8C69FF0000000B359A76FF83DE
          C6FF59D0ADFF5AB094FF4F826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1C74
          4FFF69D5B4FF53CDA7FF52CCA6FF72D7B9FF32926EFF0000000B39A07CFF8CE2
          CBFF5FD4B3FF0D6742FFD2D2CBFF6A8F77FF136A43FF73967EFFF1E8E3FF72A2
          8BFF4CA384FF6AD9BAFF5AD2AFFF7BDBC0FF339773FF0000000A3AA681FF97E9
          D5FF69DEBFFF52BC9DFF0B6942FF389B79FF66DABAFF349773FF73967EFFF0EA
          E7FF4F886CFF60B89BFF67DABAFF87E2CAFF359C78FF000000093FAD88FF9FEC
          DAFF6DE1C3FF6DE1C3FF6DE0C2FF6CDFC1FF6BE0C1FF6BDFC0FF2C8966FF698E
          76FFE6E1DCFF176B47FF5FD1B2FF90E7D1FF3CA481FF0000000842B28DFFA5EE
          DDFF70E4C7FF70E4C6FF70E3C6FF6FE3C5FF6FE2C5FF6EE2C4FF6EE2C4FF3C9E
          7DFF1F6D4AFF2D8965FF6CE0C2FF97EAD6FF3DAA86FF0000000744B691FFAAEF
          E0FF73E6C9FF73E6C9FF72E5C9FF72E5C8FF71E5C8FF71E5C8FF71E4C7FF71E4
          C7FF64D3B5FF6DDFC2FF6FE3C6FF9EECDAFF41AF8BFF0000000746B994FFAEF1
          E2FF74E8CBFF74E7CBFF74E7CBFF74E7CAFF74E6CAFF73E6CAFF73E6CAFF73E6
          C9FF73E5C9FF72E5C9FF72E5C8FFA4EEDDFF42B38EFF0000000647BC97FFC5F4
          EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4
          EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFF44B792FF00000005348B70BF47BC
          97FF47BC97FF47BC97FF47BC97FF47BC97FF47BC97FF47BC97FF47BB97FF47BB
          97FF47BB96FF46BB96FF47BA95FF45BA94FF338A6EC000000003}
      end>
  end
end
