inherited frmConfirmaEspelhoConferencia: TfrmConfirmaEspelhoConferencia
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = ''
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 784
    ExplicitTop = 517
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Left = 418
      Width = 287
      TabOrder = 3
      ExplicitLeft = 418
      ExplicitTop = 2
      ExplicitWidth = 287
      ExplicitHeight = 24
      object btnExpAut: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 164
        Height = 24
        Align = alLeft
        Caption = '[F7] Expedi'#231#227'o "Autom'#225'tica"'
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
        TabOrder = 0
        OnClick = btnExpAutClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 4
      ExplicitLeft = 705
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 116
      Height = 24
      Align = alLeft
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
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnExcluir: TBitBtnLocked
      Left = 241
      Top = 2
      Width = 177
      Height = 24
      Align = alLeft
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
    object btnQuantidade: TBitBtnLocked
      Left = 118
      Top = 2
      Width = 123
      Height = 24
      Align = alLeft
      Caption = '[F6] Quantidade'
      TabOrder = 1
      OnClick = btnQuantidadeClick
    end
  end
  object pnlContagem: TPanel [2]
    Left = 0
    Top = 477
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
      Width = 111
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
    Top = 0
    Width = 784
    Height = 477
    Align = alClient
    BevelInner = bvNone
    TabOrder = 3
    object cxgItensView: TcxGridDBTableView
      OnKeyDown = cxgItensViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.HideSelection = True
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Styles.OnGetContentStyle = cxgItensViewStylesGetContentStyle
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Focusing = False
        Width = 62
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Options.Focusing = False
        Width = 290
      end
      object cxgItensREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Focusing = False
        Width = 154
      end
      object cxgItensSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Options.Focusing = False
        Width = 60
      end
      object cxgItensQTDEXP: TcxGridDBColumn
        Caption = 'Qtd. Conferida'
        DataBinding.FieldName = 'QTDEXP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Focusing = False
        Width = 95
      end
      object cxgItensViewQTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'QTDITE'
        Visible = False
        Options.Focusing = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
    ExplicitTop = 545
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
    object cxsConferido: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
