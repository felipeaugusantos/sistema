inherited frmFatPromocaoBrindes: TfrmFatPromocaoBrindes
  Width = 869
  Caption = 'Promo'#231#227'o de Brindes por Produtos Vendidos'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitLeft = -18
  ExplicitWidth = 869
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 433
    Width = 863
    Height = 27
    BevelInner = bvNone
    BevelOuter = bvRaised
    Enabled = True
    TabOrder = 3
    Visible = True
    ExplicitTop = 433
    ExplicitWidth = 863
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 861
      Height = 25
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 861
      ExplicitHeight = 25
      object btnFechamento: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 157
        Height = 25
        Align = alLeft
        Caption = '[F10] Fechamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
        ParentFont = False
        TabOrder = 0
        OnClick = btnFechamentoClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 157
        Top = 0
        Width = 157
        Height = 25
        Align = alLeft
        Caption = '[F2] Marcar Todos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000C30E0000C30E00000001000000000000006B00000073
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
        ParentFont = False
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 314
        Top = 0
        Width = 163
        Height = 25
        Align = alLeft
        Caption = '[F3] Desmarcar Todos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
        ParentFont = False
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
      object btnMarcarDesmarcar: TBitBtnLocked
        Left = 477
        Top = 0
        Width = 208
        Height = 25
        Align = alLeft
        Caption = '[ENTER] Marca / Desmarca Registro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333FFF33F333FF3F330E0330FFFCCFCC33777FF7F3377F7730EEE030FFFC
          CFCC377777F7F33773770EEE0000FFFFFCCF777777773F33377FEEE0BFBF0FFF
          FCCF7777333373F337730E0BFBFBF0FFCCFF77733333373F77F330BFBFBFBF0F
          CCFF37F333333F7F773330FBFBFB0B0FFFFF37F3F33F737FFFFF30B0BF0FB000
          000037F73F73F777777730FB0BF0FB0FFFFF373F73F73F7F333F330030BF0F0F
          FF993F77373F737F3377CC33330BF00FFF9977FFF373F77F3F77CC993330009F
          99FF7777F337777F77F333993330F99F99FF3F77FF37F773773F993CC330FFF9
          9F9977F77F37F3377F77993CC330FFF99F997737733733377377}
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 3
        OnClick = btnMarcarDesmarcarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 772
      Top = 1
      Width = 89
      Height = 25
      ExplicitLeft = 772
      ExplicitTop = 1
      ExplicitWidth = 89
      ExplicitHeight = 25
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 4
    TabStop = False
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlHeader: TPanel [3]
    Left = 0
    Top = 0
    Width = 863
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 62
      Top = 13
      Width = 35
      Height = 14
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 14
      Top = 61
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Emiss'#227'o:'
    end
    object Label6: TLabel
      Left = 182
      Top = 62
      Width = 6
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object Label5: TLabel
      Left = 39
      Top = 37
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label4: TLabel
      Left = 187
      Top = 37
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label1: TLabel
      Left = 264
      Top = 37
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 99
      Top = 9
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 179
      Top = 9
      Width = 548
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 99
      Top = 57
      Width = 80
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 192
      Top = 57
      Width = 66
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object chkSomenteComPontos: TCheckBox
      Left = 264
      Top = 57
      Width = 263
      Height = 22
      Caption = 'Exibir somente produtos com pontos para brinde?'
      Checked = True
      State = cbChecked
      TabOrder = 8
      WordWrap = True
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 99
      Top = 33
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 230
      Top = 33
      Width = 28
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 3
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
      Left = 312
      Top = 33
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 4
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 369
      Top = 33
      Width = 358
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
    object btnCarregarVendas: TBitBtnLocked
      Left = 606
      Top = 57
      Width = 121
      Height = 22
      Caption = '&Carregar Vendas'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 9
      OnClick = btnCarregarVendasClick
    end
  end
  object pnlGridItens: TPanel [4]
    Left = 0
    Top = 85
    Width = 863
    Height = 318
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGridItens'
    Enabled = False
    TabOrder = 1
    TabStop = True
    object cxgItensVenda: TcxGrid
      Left = 0
      Top = 0
      Width = 863
      Height = 318
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgItensVendaView: TcxGridDBBandedTableView
        OnKeyDown = cxgItensVendaViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgItensVendaViewCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem registros para exibir'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'VENDAS DO CLIENTE'
          end>
        object cxgItensVendaViewDTAENT: TcxGridDBBandedColumn
          Caption = 'Data Emiss'#227'o'
          DataBinding.FieldName = 'DTAENT'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Filtering = False
          Width = 74
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgItensVendaViewNUMDOC: TcxGridDBBandedColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'NUMDOC'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Filtering = False
          Width = 66
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgItensVendaViewESPDOC: TcxGridDBBandedColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'ESPDOC'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Filtering = False
          Width = 53
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxgItensVendaViewCODEMP: TcxGridDBBandedColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Filtering = False
          Width = 50
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxgItensVendaViewCODVEN: TcxGridDBBandedColumn
          Caption = 'Vend.'
          DataBinding.FieldName = 'CODVEN'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Filtering = False
          Width = 36
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxgItensVendaViewCODITE: TcxGridDBBandedColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 50
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object cxgItensVendaViewDESCRI: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Options.Editing = False
          Options.Filtering = False
          Width = 176
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object cxgItensVendaViewCLAFIS: TcxGridDBBandedColumn
          Caption = 'CFOP'
          DataBinding.FieldName = 'CLAFIS'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 41
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object cxgItensVendaViewSIGUNI: TcxGridDBBandedColumn
          Caption = 'UN'
          DataBinding.FieldName = 'SIGUNI'
          FooterAlignmentHorz = taCenter
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 46
          Position.BandIndex = 0
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object cxgItensVendaViewQTDITE: TcxGridDBBandedColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Width = 68
          Position.BandIndex = 0
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object cxgItensVendaViewUNITAR: TcxGridDBBandedColumn
          Caption = 'Valor Unit'#225'rio'
          DataBinding.FieldName = 'UNITAR'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Width = 84
          Position.BandIndex = 0
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object cxgItensVendaViewTOTITE: TcxGridDBBandedColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'TOTITE'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Width = 66
          Position.BandIndex = 0
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object cxgItensVendaViewPONBRI: TcxGridDBBandedColumn
          Caption = 'Qtd. Pontos'
          DataBinding.FieldName = 'PONBRI'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Width = 62
          Position.BandIndex = 0
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object cxgItensVendaViewITESEL: TcxGridDBBandedColumn
          Caption = 'Selecionado'
          DataBinding.FieldName = 'ITESEL'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 13
          Position.RowIndex = 0
        end
      end
      object cxgItensVendaLevel: TcxGridLevel
        GridView = cxgItensVendaView
      end
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 403
    Width = 863
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 4
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label7: TLabel
      Left = 614
      Top = 4
      Width = 141
      Height = 22
      Align = alRight
      Alignment = taRightJustify
      Caption = '  Total de Pontos Vendas: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object Label8: TLabel
      Left = 347
      Top = 4
      Width = 163
      Height = 22
      Align = alRight
      Alignment = taRightJustify
      Caption = 'Total de Pontos Selecionado: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object edtPonTot: TEditFocus
      Tag = 99
      Left = 755
      Top = 4
      Width = 104
      Height = 22
      Align = alRight
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
      ExplicitHeight = 23
    end
    object edtPonSel: TEditFocus
      Tag = 99
      Left = 510
      Top = 4
      Width = 104
      Height = 22
      Align = alRight
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
      ExplicitHeight = 23
    end
    object pnlLegDevolucao: TPanel
      Left = 4
      Top = 4
      Width = 148
      Height = 22
      Align = alLeft
      BevelKind = bkSoft
      BevelOuter = bvNone
      BevelWidth = 30
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 2
      object shp1: TShape
        Left = 0
        Top = 0
        Width = 17
        Height = 18
        Align = alLeft
        Brush.Color = clRed
        ExplicitHeight = 22
      end
      object lbl1: TLabel
        Left = 17
        Top = 0
        Width = 125
        Height = 18
        Align = alLeft
        Caption = '  Devolu'#231#245'es de Venda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 15
      end
    end
  end
  inherited pnlStatus: TPanel
    Width = 863
    TabOrder = 5
    ExplicitTop = 460
    ExplicitWidth = 863
    inherited pnlNomeForm: TPanel
      Left = 692
      ExplicitLeft = 692
    end
    inherited pnlInfo: TPanel
      Width = 692
      ExplicitWidth = 692
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 808
    Top = 240
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 776
    Top = 240
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 848
    Top = 240
  end
end
