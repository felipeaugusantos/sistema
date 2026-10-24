inherited frmRelEstItemsAcimaMax_ItensOrc: TfrmRelEstItemsAcimaMax_ItensOrc
  Width = 1040
  Height = 768
  Caption = 'Itens do Or'#231'amento'
  ExplicitWidth = 1040
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 666
    Width = 1024
    Height = 47
    ExplicitTop = 666
    ExplicitWidth = 1024
    ExplicitHeight = 47
    DesignSize = (
      1024
      47)
    object lbl1: TLabel [0]
      Left = 5
      Top = 4
      Width = 392
      Height = 14
      Caption = 
        '[ESPACO] - Marca/Desmarca Item individualmente - [ DEL ] - Apaga' +
        'r Item'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Top = 22
      Width = 1020
      Height = 23
      Align = alBottom
      ExplicitTop = 22
      ExplicitWidth = 1020
      ExplicitHeight = 23
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 140
        ExplicitWidth = 140
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 140
        Width = 140
        ExplicitLeft = 140
        ExplicitWidth = 140
      end
      object btnGravar: TBitBtnLocked
        Left = 280
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F10 ] Confirma'
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
        TabOrder = 2
        OnClick = btnGravarClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 420
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F7 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 560
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F6 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnDesmarcaTodosClick
      end
      object btnMarcarDesmarcarExclusao: TBitBtnLocked
        Left = 700
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ DEL ] - Excluir Item'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000040000000E00000013000000130000
          0014000000140000001500000015000000160000001600000000000000000000
          00000000000000000000000000000000000D8C694DBCCD996EFFCC976CFFCB95
          6AFFC99468FFC99266FFC89163FFC79062FFC68E60FF00000000000000000000
          00000000000000000000000000000000000ECE9D73FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          00000000000000000000000000000000000DD09F76FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          00000000000000000000000000000000000BD1A179FFE1BD9FFFE1BD9EFFE0BC
          9DFFDFBB9BFFDFBB9AFFDFBA99FFDEB997FFDEB896FF00000000000000000000
          00000000000000000000000000000000000AD2A37BFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          000003031527000000000000000000000009D4A47DFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000404
          1727131382E70000000000000000000000085556D8FF5150D5FF4C4BD0FF4646
          CDFF4140C9FF3C3CC6FF3736C2FF3231BEFF2E2DBBFF00000000050518271C21
          96EA191994FF15168FFF12128AFF000000075959DBFF6262E2FF5D5DE0FF5959
          DCFF5555D9FF5151D6FF4D4CD3FF4948D0FF4444CEFF00000000201F93E7364B
          D6FF3750E2FF2F46DCFF15168FFF000000065C5CDDFF6565E5FF6160E2FF5D5D
          DFFF5958DCFF5454D9FF5150D6FF4C4BD3FF4847D0FF00000000060619272327
          9EEA1F209FFF1C1C99FF191994FF00000005605FDFFF6868E7FF6464E4FF6060
          E2FF5D5CDFFF5857DCFF5454D9FF4F4FD6FF4C4BD3FF00000000000000000606
          1A271F2094E70000000000000000000000046363E2FF5F5FDFFF5B5ADBFF5656
          D8FF5150D4FF4C4BD1FF4646CDFF4140C9FF3C3CC6FF00000000000000000000
          000006061927000000000000000000000002D9AF8AFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          000000000000000000000000000000000000D9B08CFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
          000000000000000000000000000000000000947860ADD9B08CFFDAAE8AFFD8AE
          88FFD7AC86FFD6AA84FFD5A882FFD5A780FFD4A57EFF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 5
        OnClick = btnMarcarDesmarcarExclusaoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 943
      Top = 22
      ExplicitLeft = 943
      ExplicitTop = 22
    end
  end
  inherited pnlStatus: TPanel
    Top = 713
    Width = 1024
    ExplicitTop = 713
    ExplicitWidth = 1024
    inherited pnlNomeForm: TPanel
      Left = 853
      ExplicitLeft = 853
    end
    inherited pnlInfo: TPanel
      Width = 853
      ExplicitWidth = 853
    end
  end
  inherited pnlHeader: TPanel
    Width = 1024
    Height = 27
    ExplicitWidth = 1024
    ExplicitHeight = 27
    object lblEmpresa: TLabel
      Left = 8
      Top = 6
      Width = 62
      Height = 14
      Caption = 'lblEmpresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited pnlTail: TPanel
    Top = 618
    Width = 1024
    ExplicitTop = 618
    ExplicitWidth = 1024
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 67
    Width = 1024
    Height = 372
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 38
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 317
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGUNI'
        Title.Caption = 'Un.'
        Width = 22
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDOS'
        Title.Caption = 'Saldo 001'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESTMAX'
        Title.Caption = 'Est. M'#225'ximo 001'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDOSABS'
        ReadOnly = True
        Title.Caption = 'Saldo 001'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESTMAXABS'
        ReadOnly = True
        Title.Caption = 'Est. M'#225'ximo 001'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NECCOM'
        Title.Caption = 'Qtd. a Transf.'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALUSO'
        Title.Caption = 'Qtd. Disp. Transf.'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORMAR'
        Title.Caption = 'Fornecedor / Marca / Refer'#234'ncia'
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        Visible = False
      end
      item
        Expanded = False
        Visible = False
      end
      item
        Expanded = False
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 27
    Width = 1024
    ExplicitTop = 27
    ExplicitWidth = 1024
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  object pnlEmpresasDistribuicao: TPanel [6]
    Left = 0
    Top = 439
    Width = 1024
    Height = 179
    Align = alBottom
    ParentColor = True
    TabOrder = 6
    object cxDistrib: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1022
      Height = 177
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDistrib: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEmpresaDistribuidor
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            Position = spFooter
            Column = cxgDistribITE_SALTRA
          end
          item
            Kind = skSum
            Column = cxgDistribITE_SALTRA
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            FieldName = 'ITE_SALTRA'
            Column = cxgDistribITE_SALTRA
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfAlwaysVisible
        Zebra = True
        Destaque = True
        CorZebra = clMoneyGreen
        object cxgDistribEMPRESA: TcxGridDBColumn
          Caption = 'Empresa Destino'
          DataBinding.FieldName = 'EMPRESA'
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 410
        end
        object cxgDistribCODITE: TcxGridDBColumn
          Caption = 'C'#243'd. Item'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
        end
        object cxgDistribITE_SALDOS: TcxGridDBColumn
          Caption = 'Saldo'
          DataBinding.FieldName = 'ITE_SALDOS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = '0.000'
          Options.Editing = False
          Width = 89
        end
        object cxgDistribITE_ESTMAX: TcxGridDBColumn
          Caption = 'Saldo Max.'
          DataBinding.FieldName = 'ITE_ESTMAX'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = '0.000'
          Options.Editing = False
          Width = 104
        end
        object cxgDistribITE_SALTRA: TcxGridDBColumn
          Caption = 'Saldo para Transferir'
          DataBinding.FieldName = 'ITE_SALTRA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = '0.000'
          Properties.OnValidate = cxgDistribITE_SALTRAPropertiesValidate
          Styles.Content = cxStyle1
          Width = 134
        end
      end
      object cxlDistrib: TcxGridLevel
        GridView = cxgDistrib
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 248
    Top = 104
  end
  inherited qryConsulta: TUniQuery
    AfterScroll = qryConsultaAfterScroll
  end
  object dtsEmpresaDistribuidor: TDataSource
    Left = 692
    Top = 328
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
