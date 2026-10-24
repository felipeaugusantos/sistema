inherited frmRecTransfEstoqueConfer: TfrmRecTransfEstoqueConfer
  Width = 800
  Height = 700
  BorderStyle = bsSizeable
  Caption = 'Confer'#234'ncia de Entrada de Mercadorias (Simplificada)'
  OnClose = FormClose
  ExplicitWidth = 800
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 619
    Width = 784
    Height = 26
    ExplicitTop = 619
    ExplicitWidth = 784
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 703
      Height = 22
      TabOrder = 1
      ExplicitWidth = 703
      ExplicitHeight = 22
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 116
        Height = 22
        Caption = '[ F10 ] &Confirma'
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
        ModalResult = 1
        TabOrder = 0
        OnClick = btnGravarClick
      end
      object btnQuantidade: TBitBtnLocked
        Left = 116
        Top = 0
        Width = 123
        Height = 22
        Caption = '[F6] Quantidade'
        TabOrder = 1
        OnClick = btnQuantidadeClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 239
        Top = 0
        Width = 177
        Height = 22
        Caption = '&Zera confer'#234'ncia do Item'
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
        TabOrder = 2
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Top = 2
      Align = alRight
      TabOrder = 0
      ExplicitLeft = 705
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 645
    Width = 784
    ExplicitTop = 645
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object pnlContagem: TPanel [2]
    Left = 0
    Top = 579
    Width = 784
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label2: TLabel
      Left = 440
      Top = 11
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 645
      Top = 11
      Width = 58
      Height = 14
      Caption = 'Quantidade:'
    end
    object lblConPar: TLabel
      Left = 268
      Top = 3
      Width = 111
      Height = 14
      Caption = 'Conferido Parcialmente'
      Color = clYellow
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object shpConPar: TShape
      Left = 248
      Top = 2
      Width = 16
      Height = 16
      Brush.Color = clYellow
    end
    object shpConTot: TShape
      Left = 248
      Top = 20
      Width = 16
      Height = 16
      Brush.Color = clMoneyGreen
    end
    object lblConTot: TLabel
      Left = 268
      Top = 21
      Width = 101
      Height = 14
      Caption = 'Conferido Totalmente'
      Color = clMoneyGreen
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object rdbCodBar: TRadioButton
      Left = 12
      Top = 11
      Width = 106
      Height = 14
      Caption = 'C'#243'digo de Barras'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rdbCodBarClick
    end
    object rdbCodFab: TRadioButton
      Left = 124
      Top = 11
      Width = 109
      Height = 14
      Caption = 'C'#243'digo da F'#225'brica'
      TabOrder = 1
      OnClick = rdbCodBarClick
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 478
      Top = 7
      Width = 163
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 707
      Top = 7
      Width = 73
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 3
      Text = '1,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 81
    Width = 784
    Height = 402
    Align = alClient
    BevelInner = bvNone
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      OnKeyDown = cxgItensViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 62
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 290
      end
      object cxgItensREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 154
      end
      object cxgItensSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Width = 60
      end
      object cxgItensQTDITE: TcxGridDBColumn
        Caption = 'Qtd. Notas'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 95
      end
      object cxgItensQTDCON: TcxGridDBColumn
        Caption = 'Qtd. Conferida'
        DataBinding.FieldName = 'QTDCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 95
      end
      object cxgItensLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
      end
      object cxgItensLOCSUP: TcxGridDBColumn
        Caption = 'Loc. Super Estoque'
        DataBinding.FieldName = 'LOCSUP'
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlNotas: TPanel [4]
    Left = 0
    Top = 0
    Width = 784
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Notas em Confer'#234'ncia'
    TabOrder = 4
  end
  object mmoNotas: TMemo [5]
    Left = 0
    Top = 25
    Width = 784
    Height = 56
    TabStop = False
    Align = alTop
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object pnlAplicacao: TPanel [6]
    Left = 0
    Top = 483
    Width = 784
    Height = 96
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    Visible = False
    object pnlAplica: TPanel
      Left = 0
      Top = 0
      Width = 784
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Aplica'#231#227'o'
      TabOrder = 0
    end
    object mmoAplica: TDBMemoFocus
      Left = 0
      Top = 20
      Width = 784
      Height = 76
      Align = alBottom
      BorderStyle = bsNone
      DataField = 'APLICA'
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 336
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 336
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 400
    Top = 336
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 160
    Top = 224
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
