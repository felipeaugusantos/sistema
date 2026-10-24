inherited frmOcorrenciasRomaneio: TfrmOcorrenciasRomaneio
  Left = 195
  Width = 1049
  Height = 533
  Caption = 'Ocorr'#234'ncias do Romaneio'
  Position = poDesigned
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 1049
  ExplicitHeight = 533
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 460
    Width = 1043
    TabOrder = 3
    ExplicitTop = 460
    ExplicitWidth = 1043
    inherited FlwBotoes: TFlowPanel
      Width = 1039
      ExplicitTop = 2
      ExplicitWidth = 1039
      ExplicitHeight = 24
      object btnOcorrencia: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 22
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Caption = '[F2] Ocorr'#234'ncia'
        TabOrder = 0
        OnClick = btnOcorrenciaClick
      end
      object btnRemoverOcorrencia: TBitBtnLocked
        Left = 125
        Top = 0
        Width = 148
        Height = 22
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Caption = '[DEL] Remover ocorr'#234'ncia'
        TabOrder = 1
        OnClick = btnRemoverOcorrenciaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 944
      Width = 96
      ExplicitLeft = 944
      ExplicitWidth = 96
    end
  end
  inherited pnlStatus: TPanel
    Top = 488
    Width = 1043
    TabOrder = 4
    ExplicitTop = 488
    ExplicitWidth = 1043
    inherited pnlNomeForm: TPanel
      Left = 872
      ExplicitLeft = 872
    end
    inherited pnlInfo: TPanel
      Width = 872
      ExplicitWidth = 872
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 1043
    Height = 52
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1043
      52)
    object Label1: TLabel
      Left = 13
      Top = 8
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Romaneio:'
    end
    object Label4: TLabel
      Left = 109
      Top = 8
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa'
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 13
      Top = 22
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      OnExit = edtNumRomExit
      OnKeyPress = edtNumRomKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object btnFiltrar: TBitBtnLocked
      Left = 166
      Top = 22
      Width = 85
      Height = 22
      Caption = '&Consultar'
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
      TabOrder = 2
      OnClick = btnFiltrarClick
    end
    object GroupBox1: TGroupBox
      Left = 684
      Top = 6
      Width = 353
      Height = 38
      Anchors = [akTop, akRight]
      Caption = 'Legenda de cores'
      TabOrder = 3
      object Shape1: TShape
        Left = 20
        Top = 18
        Width = 25
        Height = 14
        Brush.Color = 3329434
      end
      object Label2: TLabel
        Left = 51
        Top = 18
        Width = 93
        Height = 14
        Caption = 'Possui ocorr'#234'ncias'
      end
      object Shape2: TShape
        Left = 188
        Top = 18
        Width = 25
        Height = 14
        Brush.Color = clSkyBlue
      end
      object Label3: TLabel
        Left = 219
        Top = 18
        Width = 115
        Height = 14
        Caption = 'N'#227'o possui ocorr'#234'ncias'
      end
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 109
      Top = 22
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtNumRomKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object GroupBox2: TGroupBox
      Left = 395
      Top = 6
      Width = 284
      Height = 38
      Anchors = [akTop, akRight]
      Caption = 'Navega'#231#227'o'
      TabOrder = 4
      object lblSeta1: TLabel
        Left = 37
        Top = 18
        Width = 99
        Height = 14
        Caption = 'Recolher documento'
      end
      object lblSeta2: TLabel
        Left = 174
        Top = 18
        Width = 98
        Height = 14
        Caption = 'Expandir documento'
      end
      object imgSeta2: TImage
        Left = 152
        Top = 16
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
          4D410000B18F0BFC61050000001B744558745469746C65004E6578743B506C61
          793B4172726F773B526967687416E40EAE000002FA49444154384F9D937D4CCC
          711CC73F872424992152FAE71A339BC51F2A228A626416F3508B50A968593596
          5092A2BBAEEBC19455B44A1E57914AE7BA763DCC5D7A90259387B674D793A3EB
          9CD4DBF7979ABB7FFDB6F77EFBFCBEBFD7EBF3FBEEFBF9110062178F65068B09
          CB34AE8ECC6EA2F0EC571476EB1585663452B0B8810285F5745C2027BF241979
          C7BCF8CB4E0A4CE28ADB1195A3680B482ADDC36A534E7426B39142D21A284854
          472719E87F5D4647AFD5D0C1D86AF23A57612430BD58D88AF76A2D44251D084E
          9549F647E43A4F89DE0E8D524BBF9E9AD47A6AFCFA93769F7B4E9E91E5468259
          D1F9CD181A1DC7A7E131D4740EE2426E0B8EC496176EF1895F3D25AAEBD1D1CB
          8F5AF2887846DBC3CB8C046651B94AA874E3907D1D85A26F14AC2B0AE5DD0810
          C8F5BBCFDECF58E5E26BC3DE9BC989DC4E97926B68899160F6D92C05BA877FA3
          FCD34F947D184159D708A45F74A8F93C821B25EFB02FBA52B3E95856CC82E56B
          174D8A78868239A7D31BD139F40B8F3A8751DCA14541FB77E4B56870A75983A2
          560DF29403084E576073D0C3EEB5DEC9818C313514CC0D4891E3B54A8FBB6F7E
          20A7F93B6E2ABE21A56110D7A47D8893A89054AB86B8AE1F89CFBBE170B88083
          CC0D05E6BEF15254756921AC1B40B27C0089B23E5C91AA71E9452F62AB5548A8
          EA859FA01E0E87F206F9EE576318636628987720568207ED1A24B08EF12F55B8
          5CCD40764F90AA70225389F547F2757CF784340B1B473B0E66996628B0D81B5D
          856CE5102E56A926BAC649D408B9DD0627FFA231FB1D49F716F23DB9E39CC332
          9D8567E79EF1979D14CCDF19F90CC2DA7E5CA8ECC599820EB8043D04DF5320B1
          5AE3B399AD9BB370A3CE3B5FD143B6AE625AEE9A6A24B0740B2B45D4E32EB001
          81BD87A8D57ADD492FF6DC8285FB3F78514F7B682AD62E425AEA2C3012CC7309
          7C8295BBD23FAF708A38C56A4B9689B3B6734B23DBAD62B2D9226260CA0468E5
          944C8B1D938D04DCE771DDB87063CBF698462BB689199CCA40112DDB28242B06
          2FE160E71BB46843E23FC1FF07F407F39203EC5BAF525F0000000049454E44AE
          426082}
      end
      object imgSeta1: TImage
        Left = 15
        Top = 16
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
          4D410000B18F0BFC610500000021744558745469746C6500507265763B417272
          6F773B4C6566743B4261636B3B526577696E640B2B870F000002FC4944415438
          4F9DD37F2CD4711CC7F177F223AD25F4E30FFE306B994CE987C8544BAD2959F9
          112D2652C9242674E59A1FE3244D96CA22729C733FFC88B890F3A32B45F97138
          4C2CA5EEFC3E3FC265D3BBEFE77297FEEDB6D7EEFEF83E1FDFEF7DF7FDC29D12
          09308A259050D403B17C094473BA208AD509B43C314432DBE17A561B509F55D4
          56535BB33C0D4404326014513115C67025406777C24D5607DCC8154344761B84
          65B652C7820635DD33B47C77FF6491C4FF5E2355C15A3510CFEB82385E274C2C
          2E814CF10B86A991EFE550E774D8D3831792EAEB63391214F6C9D12B514480F5
          6A2086DB09D1056298FCB904D285251292CBD53E7125C5C237515810C5ECC0F2
          8E317C2F5560934C811EF10DFF02B7D962A0B3DA55A196BD7B98912FA3EA6144
          668B82D724C5D6B145ACFD3A8F853D3358333887AEF43A02E8A981E550739BB5
          A3BE775C292DF851F374EEEB216C1D55E05BEAAC828139E477CF20AB630A2B3E
          CDE2499A90541B56029A1713CBFC021E347E49130CA0883A8B684881559FE7B1
          A4EF07F2247FE2ACD649E44BA6D131B29A54FA2B01DD90F40FD8D03F8D95FDB3
          58DC3BAB0C72DAA690D92EC7676D72CCFC38818F9B2630A765128F845692CA60
          25A0ED79AB90E69550371EC7EB41AE584EC5726590F66E1C53DF8CE1DD861164
          D4CAF0BE68040F055590CA702540EE818EA9F56963874066AA4B54F5029DD38B
          19CDE398221AC5A4FA118C170E636CB54C89D80596936AA31AF088AE5121CA07
          C6D4C6DBDCD6278B733C52B014CEEEC1A43A19C6BC9222BDF23B465749D1E652
          190136A901675A25384508E049F3980A228FEC3A13BB007B2BB78C3A87100106
          B3BA31EAE537E5F6FA3E27C06635702CF8051C0E2A85E4FA1160D40E43827058
          056951D333B6BDEA6AE69CDEE5104A41EC3EB4F22926C0163570E07231D8F917
          C23E1F2EECF166C32ECF7CD8E1910F16EE7904227F4B9B9AA1914DF83593A369
          8396E70A09F0F726EEF7E383CD792EEC3E9B0F3B3D5860E99E0BDBDD72C1DC85
          0966A77260AB53B60A226FA1C1F2B4D480EAC7FF0DE137E24715C9B23525CC00
          00000049454E44AE426082}
      end
    end
  end
  object pnlGrid: TPanel [4]
    Left = 0
    Top = 52
    Width = 1043
    Height = 408
    Align = alClient
    TabOrder = 1
    object dbgDocumentos: TcxGrid
      Left = 1
      Top = 1
      Width = 1041
      Height = 263
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      LookAndFeel.ScrollbarMode = sbmClassic
      LookAndFeel.SkinName = ''
      object dbgDocumentosDBView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsRomaneio
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <
          item
            Links = <>
            SummaryItems = <>
          end>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GridLines = glVertical
        OnCustomDrawGroupCell = dbgDocumentosDBViewCustomDrawGroupCell
        object dbgDocumentosDOCUME: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'DOCUME'
          Visible = False
          GroupIndex = 0
          SortIndex = 0
          SortOrder = soAscending
          Width = 76
        end
        object dbgDocumentosGER_DTAENT: TcxGridDBColumn
          Caption = 'Data Documento'
          DataBinding.FieldName = 'GER_DTAENT'
          Width = 74
        end
        object dbgDocumentosGER_VLRCON: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'GER_VLRCON'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 97
        end
        object dbgDocumentosGER_CNDPAG: TcxGridDBColumn
          Caption = 'Cond. Pag.'
          DataBinding.FieldName = 'CNDPAG'
          Width = 210
        end
        object dbgDocumentosVENDEDOR: TcxGridDBColumn
          Caption = 'Vend.'
          DataBinding.FieldName = 'VENDEDOR'
          Width = 201
        end
        object dbgDocumentosGER_DTENTR: TcxGridDBColumn
          Caption = 'Data Entrega'
          DataBinding.FieldName = 'GER_DTENTR'
          Width = 80
        end
        object dbgDocumentosGER_CODCLI: TcxGridDBColumn
          Caption = 'Cod. Cliente'
          DataBinding.FieldName = 'GER_CODCLI'
          Width = 72
        end
        object dbgDocumentosCLI_NOMCLI: TcxGridDBColumn
          Caption = 'Nome Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Width = 200
        end
        object dbgDocumentosDBGER_NUMFAT: TcxGridDBColumn
          Caption = 'Doc. Faturado'
          DataBinding.FieldName = 'GER_NUMFAT'
          Width = 80
        end
        object dbgDocumentosDBGER_TIPFAT: TcxGridDBColumn
          Caption = 'Esp. Doc. Faturado'
          DataBinding.FieldName = 'GER_TIPFAT'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 102
        end
        object dbgDocumentosOCORRE: TcxGridDBColumn
          Caption = 'Ocorr'#234'ncia'
          DataBinding.FieldName = 'OCORRE'
          Width = 371
        end
        object dbgDocumentosGER_OBSCPL: TcxGridDBColumn
          Caption = 'Obs. Complementares'
          DataBinding.FieldName = 'GER_OBSCPL'
          Width = 583
        end
      end
      object dbgDocumentoslevel: TcxGridLevel
        GridView = dbgDocumentosDBView
      end
    end
    object pnlOcorrencias: TPanel
      Left = 1
      Top = 264
      Width = 1041
      Height = 143
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 1039
        Height = 17
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object Label15: TLabel
          Left = 1
          Top = 1
          Width = 1037
          Height = 14
          Hint = 'Inseridas na exclus'#227'o do documento em um romaneio anterior'
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Ocorr'#234'ncias'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          ExplicitLeft = -1
          ExplicitTop = 5
          ExplicitWidth = 1023
        end
      end
      object txtOcorrencias: TMemoFocus
        Left = 1
        Top = 18
        Width = 1039
        Height = 124
        Align = alClient
        Alignment = taCenter
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
  end
  object dtsRomaneio: TDataSource
    Left = 624
    Top = 392
  end
end
