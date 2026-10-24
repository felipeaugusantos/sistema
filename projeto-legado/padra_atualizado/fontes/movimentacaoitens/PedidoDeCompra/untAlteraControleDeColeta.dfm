inherited frmAlteraControleDeColeta: TfrmAlteraControleDeColeta
  Width = 594
  Height = 673
  Caption = 'Altera dados da coleta'
  ExplicitWidth = 594
  ExplicitHeight = 673
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 602
    Width = 588
    TabOrder = 3
    ExplicitTop = 602
    ExplicitWidth = 588
    inherited FlwBotoes: TFlowPanel
      Width = 584
      ExplicitWidth = 584
    end
    inherited btnSair: TBitBtnLocked
      Left = 508
      ExplicitLeft = 508
    end
  end
  inherited pnlStatus: TPanel
    Top = 628
    Width = 588
    TabOrder = 4
    ExplicitTop = 628
    ExplicitWidth = 588
    inherited pnlNomeForm: TPanel
      Left = 417
      ExplicitLeft = 417
    end
    inherited pnlInfo: TPanel
      Width = 417
      ExplicitWidth = 417
    end
  end
  object pnlProduto: TPanel [2]
    Left = 0
    Top = 0
    Width = 588
    Height = 70
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'pnlTop'
    Enabled = False
    ShowCaption = False
    TabOrder = 0
    object Label4: TLabel
      Left = 21
      Top = 16
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedido de Compra:'
    end
    object Label5: TLabel
      Left = 71
      Top = 40
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object DBEditFocus3: TDBEditFocus
      Left = 114
      Top = 13
      Width = 103
      Height = 22
      Color = 16768952
      DataField = 'CON_NUMPED'
      DataSource = dtsConsulta
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus4: TDBEditFocus
      Left = 218
      Top = 13
      Width = 351
      Height = 22
      Color = 16768952
      DataField = 'NOMFOR'
      DataSource = dtsConsulta
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus5: TDBEditFocus
      Left = 114
      Top = 37
      Width = 103
      Height = 22
      Color = 16768952
      DataField = 'CON_CODITE'
      DataSource = dtsConsulta
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus6: TDBEditFocus
      Left = 218
      Top = 37
      Width = 351
      Height = 22
      Color = 16768952
      DataField = 'DESITE'
      DataSource = dtsConsulta
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlComum: TPanel [3]
    Left = 0
    Top = 70
    Width = 588
    Height = 139
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Label122: TLabel
      Left = 11
      Top = 84
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Local da Mercadoria:'
    end
    object Label3: TLabel
      Left = 49
      Top = 108
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
    end
    object GroupBox1: TGroupBox
      Left = 18
      Top = 6
      Width = 340
      Height = 60
      Caption = 'Dados do Fornecedor:'
      TabOrder = 0
      object Label2: TLabel
        Left = 24
        Top = 26
        Width = 123
        Height = 14
        Alignment = taRightJustify
        Caption = 'Previs'#227'o de Faturamento:'
      end
      object dbePreFat: TcxDBDateEdit
        Tag = 99
        Left = 150
        Top = 23
        DataBinding.DataField = 'CON_PREFAT'
        DataBinding.DataSource = dtsConsulta
        TabOrder = 0
        Width = 90
      end
    end
    object dbeCodLoc: TDBEditFocus
      Tag = 99
      Left = 114
      Top = 81
      Width = 51
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CON_CODLOC'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      OnKeyPress = dbeCodLocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus2: TDBEditFocus
      Tag = 99
      Left = 114
      Top = 105
      Width = 439
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CON_OBSERV'
      DataSource = dtsConsulta
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesLoc: TDBEditFocus
      Left = 166
      Top = 81
      Width = 387
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'DESLOC'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlColeta: TPanel [4]
    Left = 0
    Top = 209
    Width = 588
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlColeta'
    ShowCaption = False
    TabOrder = 2
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 588
      Height = 48
      Align = alTop
      BevelOuter = bvLowered
      Caption = 'Panel1'
      ParentShowHint = False
      ShowCaption = False
      ShowHint = False
      TabOrder = 0
      object lblQuantidade: TLabel
        Left = 23
        Top = 17
        Width = 138
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade Tolal Requisi'#231#227'o:'
      end
      object Label1: TLabel
        Left = 280
        Top = 17
        Width = 143
        Height = 14
        Caption = 'Quantidade Pendentre Coleta:'
      end
      object dbeQtdIte: TDBEditFocus
        Tag = 99
        Left = 163
        Top = 14
        Width = 87
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'QTDITE'
        DataSource = dtsConsulta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnKeyPress = dbeCodLocKeyPress
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object edtQtdPen: TEditFocus
        Tag = 99
        Left = 425
        Top = 14
        Width = 93
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 5
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 48
      Width = 588
      Height = 72
      Align = alTop
      BevelOuter = bvLowered
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      object Label6: TLabel
        Left = 16
        Top = 38
        Width = 73
        Height = 14
        Caption = 'Data da Coleta:'
      end
      object Label7: TLabel
        Left = 199
        Top = 39
        Width = 103
        Height = 14
        Caption = 'Quantidade Coletada:'
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 586
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Nova Coleta'
        TabOrder = 2
      end
      object cxdDtaCol: TcxDateEdit
        Tag = 99
        Left = 92
        Top = 35
        TabOrder = 0
        Width = 85
      end
      object btnIncluir: TBitBtnLocked
        Left = 403
        Top = 35
        Width = 75
        Height = 22
        Caption = '&Incluir'
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
        TabOrder = 3
        OnClick = btnIncluirClick
      end
      object edtQtdCol: TEditFocus
        Tag = 99
        Left = 304
        Top = 35
        Width = 93
        Height = 22
        Alignment = taRightJustify
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 358
      Width = 588
      Height = 35
      Align = alBottom
      BevelOuter = bvLowered
      Caption = 'Panel5'
      ShowCaption = False
      TabOrder = 3
      object btnExcluir: TBitBtnLocked
        Left = 229
        Top = 7
        Width = 103
        Height = 22
        Caption = '&Excluir Coleta'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnExcluirClick
      end
    end
    object cxgColeta: TcxGrid
      Left = 0
      Top = 120
      Width = 588
      Height = 238
      Align = alClient
      TabOrder = 2
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvColeta: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00'
            Kind = skSum
            Column = cxvColetaQTDBAI
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Nenhuma coleta encontrada>'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object cxvColetaDTABAI: TcxGridDBColumn
          Caption = 'Data da Coleta'
          DataBinding.FieldName = 'CON_DTACOL'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soAscending
          Width = 105
        end
        object cxvColetaQTDBAI: TcxGridDBColumn
          Caption = 'Quantidade Coletada'
          DataBinding.FieldName = 'CON_QTDBAI'
          HeaderAlignmentHorz = taCenter
          Width = 148
        end
      end
      object cxgColetaLevel1: TcxGridLevel
        GridView = cxvColeta
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 624
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 624
    Top = 112
  end
  object dtsConsulta: TDataSource
    Left = 488
    Top = 88
  end
end
