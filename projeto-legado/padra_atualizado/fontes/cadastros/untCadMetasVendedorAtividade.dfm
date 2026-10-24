inherited frmCadMetasVendedorAtividade: TfrmCadMetasVendedorAtividade
  Width = 578
  Height = 513
  BorderIcons = [biSystemMenu]
  Caption = 'Metas por Vendedor - Atividade'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 578
  ExplicitHeight = 513
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 442
    Width = 572
    Height = 26
    TabOrder = 3
    ExplicitTop = 442
    ExplicitWidth = 572
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 568
      Height = 22
      ExplicitWidth = 568
      ExplicitHeight = 22
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 118
        Height = 22
        Caption = '[ F10 ] Confirmar'
        Enabled = False
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
        OnClick = btnConfirmarClick
      end
      object btnHeranca: TBitBtnLocked
        Left = 118
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F5 ] Heran'#231'a'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
          000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
          99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
          0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
          FFFF3333337F337F333333333307B70FFFFF33333373FF733F333333333000FF
          0FFF3333333777337FF3333333333FF000FF33FFFFF3333777FF300000333300
          000F377777F33377777F30EEE0333000000037F337F33777777730EEE0333330
          00FF37F337F3333777F330EEE033333000FF37FFF7F3333777F3300000333330
          00FF3777773333F77733333333333000033F3333333337777333}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 493
      Top = 2
      ExplicitLeft = 493
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 468
    Width = 572
    TabOrder = 2
    ExplicitTop = 468
    ExplicitWidth = 572
    inherited pnlNomeForm: TPanel
      Left = 401
      TabOrder = 1
      ExplicitLeft = 401
    end
    inherited pnlInfo: TPanel
      Width = 401
      TabOrder = 0
      ExplicitWidth = 401
    end
  end
  object pnlAtividade: TPanel [2]
    Left = 0
    Top = 68
    Width = 572
    Height = 374
    Align = alClient
    Enabled = False
    ParentColor = True
    TabOrder = 1
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 570
      Height = 21
      Align = alTop
      Caption = 'Atividades'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
    end
    object cxgAtividades: TcxGrid
      Left = 1
      Top = 128
      Width = 570
      Height = 245
      Align = alClient
      TabOrder = 2
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgAtividadesDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Enabled = False
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = False
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Enabled = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Enabled = False
        Navigator.Buttons.Filter.Visible = False
        DataController.DataSource = dtsAtividade
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '-'
        OptionsView.GroupByBox = False
        object cxgAtividadesDBTableView1Column1: TcxGridDBColumn
          Caption = 'Atividade'
          DataBinding.FieldName = 'DESCRI'
          Width = 230
        end
        object cxgAtividadesDBTableView1Column2: TcxGridDBColumn
          Caption = 'Prazo M'#233'dio'
          DataBinding.FieldName = 'PRAMED'
          Width = 105
        end
        object cxgAtividadesDBTableView1Column3: TcxGridDBColumn
          Caption = 'Faturamento'
          DataBinding.FieldName = 'FATURA'
          HeaderAlignmentHorz = taRightJustify
          Width = 105
        end
        object cxgAtividadesDBTableView1Column4: TcxGridDBColumn
          Caption = 'Margem L'#237'quida'
          DataBinding.FieldName = 'MARGEM'
          Width = 105
        end
      end
      object cxgAtividadesLevel1: TcxGridLevel
        GridView = cxgAtividadesDBTableView1
      end
    end
    object pnlCadAti: TPanel
      Left = 1
      Top = 22
      Width = 570
      Height = 106
      Align = alTop
      ParentColor = True
      TabOrder = 1
      object Label1: TLabel
        Left = 22
        Top = 37
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Prazo M'#233'dio:'
      end
      object Label6: TLabel
        Left = 35
        Top = 13
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Atividade:'
      end
      object Label5: TLabel
        Left = 21
        Top = 61
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Faturamento:'
      end
      object Label7: TLabel
        Left = 6
        Top = 85
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Margem L'#237'quida:'
      end
      object Label8: TLabel
        Left = 190
        Top = 37
        Width = 20
        Height = 14
        Alignment = taRightJustify
        Caption = 'dias'
      end
      object edtPraMed: TEditFocus
        Tag = 99
        Left = 86
        Top = 30
        Width = 99
        Height = 22
        Hint = 'Prazo M'#233'dio'
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtCodAti: TEditFocus
        Tag = 99
        Left = 86
        Top = 6
        Width = 47
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodAtiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesAti: TEditFocus
        Left = 135
        Top = 6
        Width = 423
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtFatura: TEditFocus
        Tag = 99
        Left = 86
        Top = 54
        Width = 99
        Height = 22
        Hint = 'Faturamento'
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtMargem: TEditFocus
        Tag = 99
        Left = 86
        Top = 78
        Width = 99
        Height = 22
        Hint = 'Margem L'#237'quida'
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object btnAdicionar: TBitBtnLocked
        Left = 198
        Top = 78
        Width = 83
        Height = 22
        Caption = '&Adicionar'
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
        TabOrder = 5
        OnClick = btnAdicionarClick
      end
    end
  end
  object pnlPeriodo: TPanel [3]
    Left = 0
    Top = 0
    Width = 572
    Height = 68
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 40
      Width = 49
      Height = 14
      Caption = 'Per'#237'odo: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 14
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object Label4: TLabel
      Left = 111
      Top = 40
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object mskPeriodo: TMaskEditFocus
      Tag = 99
      Left = 58
      Top = 34
      Width = 47
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 2
      Text = '  /    '
      OnExit = mskPeriodoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 58
      Top = 7
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 106
      Top = 7
      Width = 453
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 159
      Top = 34
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 3
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmp: TEditFocus
      Left = 199
      Top = 34
      Width = 360
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 26
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 644
    Top = 26
  end
  object dtsAtividade: TDataSource
    Left = 540
    Top = 230
  end
end
