inherited frmCadCodFabrProdAcab: TfrmCadCodFabrProdAcab
  Width = 586
  Height = 396
  Caption = 'Cadastro C'#243'digo de F'#225'brica do Produto Acabado'
  Position = poScreenCenter
  ExplicitWidth = 586
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 323
    Width = 580
    ExplicitTop = 323
    ExplicitWidth = 580
    DesignSize = (
      580
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 576
    end
    inherited btnSair: TBitBtnLocked
      Left = 497
      TabOrder = 2
      ExplicitLeft = 497
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 101
      Height = 21
      Caption = '[ F10 ] Confirmar'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 580
    Height = 323
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 263
      Top = 1
      Height = 321
      ExplicitLeft = 184
      ExplicitTop = 152
      ExplicitHeight = 100
    end
    object Splitter2: TSplitter
      Left = 314
      Top = 1
      Height = 321
      Align = alRight
      ExplicitLeft = 272
      ExplicitTop = 128
      ExplicitHeight = 100
    end
    object pnlEsquerda: TPanel
      Left = 1
      Top = 1
      Width = 262
      Height = 321
      Align = alLeft
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object pnlLegEsq: TPanel
        Left = 1
        Top = 286
        Width = 260
        Height = 34
        Align = alBottom
        BevelInner = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 2
          Width = 135
          Height = 14
          Caption = 'F1 - Move para Cima (Up)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 16
          Top = 18
          Width = 153
          Height = 14
          Caption = 'F2 - Move para Baixo (Down)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object dbgEsquerda: TcxGrid
        Left = 1
        Top = 1
        Width = 260
        Height = 241
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgEsquerdaDBTableView1: TcxGridDBTableView
          OnDblClick = dbgEsquerdaDBTableView1DblClick
          OnKeyDown = dbgEsquerdaDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsEsquerda
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum registro para exibi'#231#227'o>'
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          object dbgEsquerdaDBTableView1DescricaoCampo: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DescricaoCampo'
            Width = 250
          end
          object dbgEsquerdaDBTableView1TabelaCampo: TcxGridDBColumn
            DataBinding.FieldName = 'TabelaCampo'
            Visible = False
          end
          object dbgEsquerdaDBTableView1Sequencia: TcxGridDBColumn
            DataBinding.FieldName = 'Sequencia'
            Visible = False
          end
        end
        object dbgEsquerdaLevel1: TcxGridLevel
          GridView = dbgEsquerdaDBTableView1
        end
      end
      object pnlExpressao: TPanel
        Left = 1
        Top = 242
        Width = 260
        Height = 44
        Align = alBottom
        BevelInner = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object lblExpressao: TLabel
          Left = 7
          Top = 3
          Width = 105
          Height = 14
          Caption = 'Digite a express'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtExpressao: TEditFocus
          Left = 7
          Top = 18
          Width = 219
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnGravar: TBitBtnLocked
          Left = 228
          Top = 18
          Width = 27
          Height = 20
          Hint = 'Gravar Express'#227'o'
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
          TabOrder = 1
          OnClick = btnGravarClick
        end
      end
    end
    object pnlCentro: TPanel
      Left = 266
      Top = 1
      Width = 48
      Height = 321
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object btnAddUm: TSpeedButton
        Left = 8
        Top = 66
        Width = 30
        Height = 25
        Caption = '>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnAddUmClick
      end
      object btnAddTodos: TSpeedButton
        Left = 8
        Top = 90
        Width = 30
        Height = 25
        Caption = '>>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnAddTodosClick
      end
      object btnDelTodos: TSpeedButton
        Left = 8
        Top = 114
        Width = 30
        Height = 25
        Caption = '<<'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnDelTodosClick
      end
      object btnDelUma: TSpeedButton
        Left = 8
        Top = 138
        Width = 30
        Height = 25
        Caption = '<'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnDelUmaClick
      end
    end
    object pnlDireita: TPanel
      Left = 317
      Top = 1
      Width = 262
      Height = 321
      Align = alRight
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object dbgDireita: TcxGrid
        Left = 1
        Top = 1
        Width = 260
        Height = 319
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgDireitaDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDireita
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum registro para exibi'#231#227'o>'
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          object dbgDireitaDBTableView1DescricaoCampo: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DescricaoCampo'
            Width = 250
          end
          object dbgDireitaDBTableView1TabelaCampo: TcxGridDBColumn
            DataBinding.FieldName = 'TabelaCampo'
            Visible = False
          end
        end
        object dbgDireitaLevel1: TcxGridLevel
          GridView = dbgDireitaDBTableView1
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 351
    Width = 580
    ExplicitTop = 351
    ExplicitWidth = 580
    inherited pnlNomeForm: TPanel
      Left = 409
      ExplicitLeft = 409
    end
    inherited pnlInfo: TPanel
      Width = 409
      ExplicitWidth = 409
    end
  end
  object dtsDireita: TDataSource
    DataSet = cdsDireita
    Left = 400
    Top = 40
  end
  object cdsDireita: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 40
    object cdsDireitaDescricaoCampo: TStringField
      FieldName = 'DescricaoCampo'
      Size = 50
    end
    object cdsDireitaTabelaCampo: TStringField
      FieldName = 'TabelaCampo'
      Size = 50
    end
  end
  object dtsEsquerda: TDataSource
    DataSet = cdsEsquerda
    Left = 96
    Top = 32
  end
  object cdsEsquerda: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsEsquerdaAfterScroll
    Left = 128
    Top = 32
    object cdsEsquerdaDescricaoCampo: TStringField
      FieldName = 'DescricaoCampo'
      Size = 50
    end
    object cdsEsquerdaTabelaCampo: TStringField
      FieldName = 'TabelaCampo'
      Size = 50
    end
    object cdsEsquerdaSequencia: TIntegerField
      FieldName = 'Sequencia'
    end
    object cdsEsquerdaExpressao: TStringField
      FieldName = 'Expressao'
      Size = 100
    end
  end
end
