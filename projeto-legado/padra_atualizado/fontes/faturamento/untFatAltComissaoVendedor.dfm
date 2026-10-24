inherited frmFatAltComissaoVendedor: TfrmFatAltComissaoVendedor
  Width = 949
  Height = 453
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o da Comiss'#227'o do Vendedor'
  Position = poMainFormCenter
  ExplicitWidth = 949
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 370
    Width = 933
    Height = 28
    Enabled = True
    Visible = True
    ExplicitTop = 370
    ExplicitWidth = 933
    ExplicitHeight = 28
    inherited FlwBotoes: TFlowPanel
      Left = 655
      Width = 171
      ExplicitLeft = 655
      ExplicitWidth = 171
      object btnMarcarTodos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 24
        Align = alLeft
        Caption = '[F7] &Marcar Todos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
          3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
          2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
          43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 0
        OnClick = btnMarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 826
      Top = 2
      Width = 105
      Height = 24
      Align = alRight
      Caption = '&Cancelar e Sair'
      Spacing = 2
      TabOrder = 4
      ExplicitLeft = 826
      ExplicitTop = 2
      ExplicitWidth = 105
      ExplicitHeight = 24
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 155
      Height = 24
      Align = alLeft
      Caption = '[F10] &Confirmar Comiss'#227'o'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000C30E0000C30E00000001000000010000006B00000073
        0000007B000000940000009C0000086B0800087B08000884080008A5080008AD
        080008B5080010731000107B10001084100010A5100010AD100010B510001873
        1800187B180018841800188C1800189C180018A5180018AD180018B51800217B
        2100218C210021942100219C210021AD210021B5210029942900299C29003194
        3100319C3100399C390039A5390039AD3900429C420042A5420042AD42004AA5
        4A004AAD4A0052A5520052AD52005AAD5A0063AD630063B563006BB56B0073BD
        73007BB57B007BBD7B0084B5840084C684008CBD8C008CC68C009CCE9C00A5D6
        A500B5DEB500FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3C3C3C3C3C
        3C3C3C3C3C3C3C3C3C3B3C340B11111112120C0C06060201323C3C0D1A1F2121
        1F201C16160E0803003C3C141F23232324393C1D17100904023C3C1B23272927
        273C3C3C1E180F08063C3C1F26292B2927283C3C3C180F0E073C3C22292B2B29
        2927253C3C3C17160D3C3C262B3C3C3C3C3C3C3C3C3C3C1C133C3C272D3C3C3C
        3C3C3C3C3C3C3C1C193C3C2B2E2E2D2B2926233C3C3C201F193C3C2B30302D2B
        29263C3C3C1F1F1F193C3C2D33312E2D2B3C3C3C22222121193C3C303733302F
        2E3A3C2929272321193C3C3138373331302F2E2D2C292721113C3C3A312F2D2B
        2B2929272623211A363C3B3C3C3C3C3C3C3C3C3C3C3C3C3C3C3B}
      Spacing = 2
      TabOrder = 1
      OnClick = btnConfirmarClick
    end
    object btnRestaurar: TBitBtnLocked
      Left = 427
      Top = 2
      Width = 228
      Height = 24
      Align = alLeft
      Caption = '[F6] &Restaurar (%) de comiss'#227'o sugerido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        9E9E9EADADADAFAFAFABAAABACAFABB2AEAEA5AAACB2AEAFB2AFB0A8ACABA4A6
        A5FFFFFFFFFFFF000000FFFFFFF2F2F2A0A0A0BFBFBFAFAFAFD2CFD0B1B6B5B0
        ADAFD8D8D5C5AA9ECCA294E3D1CBA3A1A2FFFEFEFFFFFF000000FFFFFFF3F3F3
        A2A2A2A4A4A4939393BFBEBC989B9E949298CFCAC3B6866EBB8062D3BAADA4A4
        A6FFFEFFFFFFFF000000FFFFFFF4F4F49F9F9FC4C4C4B5B5B5D2D2D1BDBBBDB7
        B4B9DEDCD4BC8871BB8565D1BEACA2A7A5FEFEFFFFFFFF000000FFFFFFF4F4F4
        A4A4A49B9B9B8A8A89B6B7B79791918B898AC3C5BDB5826FBA7A5DD6BAAAA6A5
        A1FFFEFFFFFFFF000000FFFFFFF4F4F49E9E9ECFCFCFC2C2C2DAD6D8CDCAC4B9
        C3C6E0DED699BFF582B9F7C4DDF1A49FA3FDFFFFFFFFFF000000FFFFFFF4F4F4
        A3A3A39A9A9A8A8A8AB6B9B6909195918787B8BFC70974ED0064FF70AEF1ACA3
        A5FFFFFEFFFFFF000000FFFFFFF4F4F4A0A0A0CCCBCBBDBEBED4D6D9CCC6BFBC
        BEBED5DBDFA6BEDA9BB7D6CDDBE5AAA1A0FFFFFFFFFFFF000000FFFFFFF4F4F4
        A3A2A39A999A888788B6B4BD8E9193818986BFC0BB99908E8C8885B5BDC0A4A1
        A8FEFFFFFFFFFF000000FFFFFFF4F4F49F9F9FE2E2E3D5D4D6E6E4E1D6D5D9D9
        D2D5E4E4E8D4D4D3D6D1CFE8ECEBA8A09FFFFFFFFFFFFF000000FFFFFFF5F5F6
        9A9E974C741B598E2B5E8E2965952F6B9937709C4378A15179A85960813DABAA
        AAFFFEFFFFFFFF000000FFFFFFF6F5F7949891648F298ACA3983CB498BD44E92
        DA579ADF61A4E971BFFA89799F56A4A3AFFFFFFFFFFFFF000000FFFFFFF4F4F5
        9FA29B5A7537567D23587B20577C1E577C1D577B1D557A1D4C781863803CAEAF
        A8FFFEFFFFFFFF000000FFFFFFFBFBFB757775B6B9B5AFB2AFB0B0B5B0B1B3B0
        B1B4B0B2B1B0B2B2AFAEB5B8B7B3837F7FFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFBFAFBFBFAFCFBFBFBFBFAFBFBFAFBFBFBFBFBFBFBFBFAFBFAF9FBFFFF
        FFFFFFFFFFFFFF000000}
      ParentFont = False
      Spacing = 2
      TabOrder = 3
      StyleElements = [seClient, seBorder]
      OnClick = btnRestaurarClick
    end
    object btnInfPerCom: TBitBtnLocked
      Left = 157
      Top = 2
      Width = 270
      Height = 24
      Align = alLeft
      Caption = '[F5] &Informar (%) de comiss'#227'o para todos os itens'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
        83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
        DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
        AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
        00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
        E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
        0066000066000066000066000066000066000066000066000066000066000066
        00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
        3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
        0066000066000066000066000066000066000066000066000066000066000066
        00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
        ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
        CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
        00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
        F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
        0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
        D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
        2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
        43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
        DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
        FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
        0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
        82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentFont = False
      Spacing = 2
      TabOrder = 2
      StyleElements = [seClient, seBorder]
      OnClick = btnInfPerComClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 398
    Width = 933
    ExplicitTop = 398
    ExplicitWidth = 933
    inherited pnlNomeForm: TPanel
      Left = 762
      ExplicitLeft = 762
    end
    inherited pnlInfo: TPanel
      Width = 762
      ExplicitWidth = 762
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    ActivePage = nil
    Align = alNone
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 933
    Height = 348
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      OnKeyDown = cxgItensViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      OnEditKeyDown = cxgItensViewEditKeyDown
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensViewQTDITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensViewTOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensViewVALCOM
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensViewQTDITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensViewTOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensViewVALCOM
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensViewQTDITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensViewTOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensViewVALCOM
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.ScrollBars = ssVertical
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxgItensViewALTPCO: TcxGridDBColumn
        DataBinding.FieldName = 'ALTPCO'
        Visible = False
        Options.Focusing = False
      end
      object cxgItensViewCODITE: TcxGridDBColumn
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 50
      end
      object cxgItensViewDESITE: TcxGridDBColumn
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 179
      end
      object cxgItensViewREFERE: TcxGridDBColumn
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 92
      end
      object cxgItensViewQTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 61
      end
      object cxgItensViewSIGUNI: TcxGridDBColumn
        DataBinding.FieldName = 'SIGUNI'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 20
      end
      object cxgItensViewUNIDIG: TcxGridDBColumn
        DataBinding.FieldName = 'UNIDIG'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 60
      end
      object cxgItensViewDESCON: TcxGridDBColumn
        DataBinding.FieldName = 'DESCON'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 56
      end
      object cxgItensViewUNITAR: TcxGridDBColumn
        DataBinding.FieldName = 'UNITAR'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 65
      end
      object cxgItensViewTOTITE: TcxGridDBColumn
        DataBinding.FieldName = 'TOTITE'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 73
      end
      object cxgItensViewPERCOM: TcxGridDBColumn
        DataBinding.FieldName = 'PERCOM'
        RepositoryItem = cxrEdtValPer
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Filtering = False
        Width = 75
      end
      object cxgItensViewVALCOM: TcxGridDBColumn
        DataBinding.FieldName = 'VALCOM'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Width = 70
      end
    end
    object cxgItensLevel: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlLegenda: TPanel [4]
    Left = 0
    Top = 348
    Width = 933
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 3
    object shp2: TShape
      Left = 7
      Top = 4
      Width = 15
      Height = 15
      Brush.Color = clRed
    end
    object lbl2: TLabel
      Left = 24
      Top = 4
      Width = 188
      Height = 14
      Caption = '(%) de comiss'#227'o digitado manualmente'
    end
    object shp1: TShape
      Left = 223
      Top = 4
      Width = 15
      Height = 15
      Brush.Color = clBlue
    end
    object lbl1: TLabel
      Left = 240
      Top = 4
      Width = 127
      Height = 14
      Caption = '(%) de comiss'#227'o sugerido'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 80
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 352
    Top = 80
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsItensBeforePost
    Left = 400
    Top = 80
    object intgrfldItensAUTINC: TIntegerField
      FieldName = 'AUTINC'
      Visible = False
    end
    object strngfldItensALTPCO: TStringField
      FieldName = 'ALTPCO'
      Size = 1
    end
    object strngfldItensCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object strngfldItensDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESITE'
      Size = 101
    end
    object strngfldItensREFERE: TStringField
      DisplayLabel = 'Refer'#234'ncia'
      FieldName = 'REFERE'
      Size = 30
    end
    object cdsItensQTDITE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QTDITE'
    end
    object strngfldItensSIGUNI: TStringField
      Alignment = taCenter
      DisplayLabel = 'UN'
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsItensUNIDIG: TFloatField
      DisplayLabel = 'Vr. Unit'#225'rio'
      FieldName = 'UNIDIG'
    end
    object cdsItensDESCON: TFloatField
      DisplayLabel = 'Desc. (%)'
      FieldName = 'DESCON'
    end
    object cdsItensUNITAR: TFloatField
      DisplayLabel = 'Vr. Unit. L'#237'q.'
      FieldName = 'UNITAR'
    end
    object cdsItensTOTITE: TFloatField
      DisplayLabel = 'Valor Total'
      FieldName = 'TOTITE'
    end
    object cdsItensPERCOM: TFloatField
      DisplayLabel = '(%) Comiss'#227'o'
      FieldName = 'PERCOM'
    end
    object cdsItensVALCOM: TFloatField
      DisplayLabel = 'Vr. Comiss'#227'o'
      FieldName = 'VALCOM'
    end
  end
  object cxedtRepository: TcxEditRepository
    Left = 448
    Top = 80
    PixelsPerInch = 96
    object cxrEdtValPer: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = ',0.00;(,0.00)'
      Properties.MaxValue = 100.000000000000000000
      Properties.OnValidate = cxrEdtValPerPropertiesValidate
    end
  end
end
