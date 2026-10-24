inherited frmRcxCancTransfValores: TfrmRcxCancTransfValores
  Width = 796
  Height = 589
  BorderIcons = [biSystemMenu]
  Caption = 'Cancelamento de transfer'#234'ncia de valores'
  Position = poMainFormCenter
  ExplicitWidth = 796
  ExplicitHeight = 589
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 516
    Width = 790
    ExplicitTop = 516
    ExplicitWidth = 790
    inherited FlwBotoes: TFlowPanel
      Width = 786
      TabOrder = 4
      ExplicitWidth = 786
    end
    inherited btnSair: TBitBtnLocked
      Left = 707
      TabOrder = 3
      ExplicitLeft = 707
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
      OnClick = btnConfirmaDadosClick
    end
    object btnMarcar: TBitBtnLocked
      Left = 171
      Top = 3
      Width = 77
      Height = 22
      Caption = '[F8] &Marcar'
      TabOrder = 2
      OnClick = btnMarcarClick
    end
    object btnDesmarcar: TBitBtnLocked
      Left = 86
      Top = 3
      Width = 80
      Height = 22
      Caption = '[F9] &Desmarcar'
      TabOrder = 1
      OnClick = btnDesmarcarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 544
    Width = 790
    ExplicitTop = 544
    ExplicitWidth = 790
    inherited pnlNomeForm: TPanel
      Left = 619
      ExplicitLeft = 619
    end
    inherited pnlInfo: TPanel
      Width = 619
      ExplicitWidth = 619
    end
  end
  object pnlTransferencias: TPanel [2]
    Left = 0
    Top = 0
    Width = 790
    Height = 427
    Align = alClient
    TabOrder = 2
    object dbgTransferencias: TcxGrid
      Left = 1
      Top = 1
      Width = 788
      Height = 425
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgTransferenciasDBTableView1: TcxGridDBTableView
        OnDblClick = dbgTransferenciasDBTableView1DblClick
        OnKeyDown = dbgTransferenciasDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgTransferenciasDBTableView1CustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' dados a serem exibidos>'
        OptionsView.GroupByBox = False
        object dbgTransferenciasDBTableView1RCX_DTACAD: TcxGridDBColumn
          Caption = 'Data Lan'#231'.'
          DataBinding.FieldName = 'RCX_DTACAD'
          Options.Editing = False
          Width = 70
        end
        object dbgTransferenciasDBTableView1RCX_HORCAD: TcxGridDBColumn
          Caption = 'Hora Lan'#231'.'
          DataBinding.FieldName = 'RCX_HORCAD'
          Options.Editing = False
          Width = 70
        end
        object dbgTransferenciasDBTableView1RCX_SEQCON: TcxGridDBColumn
          Caption = 'Sequ'#234'ncia'
          DataBinding.FieldName = 'RCX_SEQCON'
          Options.Editing = False
          Width = 70
        end
        object dbgTransferenciasDBTableView1RCX_OPERAD: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'RCX_OPERAD'
          Options.Editing = False
          Width = 230
        end
        object dbgTransferenciasDBTableView1RCX_DESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'RCX_DESCRI'
          Options.Editing = False
          Width = 250
        end
        object dbgTransferenciasDBTableView1RCX_VALDOC: TcxGridDBColumn
          Caption = 'Valor TF'
          DataBinding.FieldName = 'RCX_VALDOC'
          Options.Editing = False
          Width = 80
        end
        object dbgTransferenciasDBTableView1RCX_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'RCX_MARDES'
          Visible = False
          Options.Editing = False
        end
      end
      object dbgTransferenciasLevel1: TcxGridLevel
        GridView = dbgTransferenciasDBTableView1
      end
    end
  end
  object pnlDetalhes: TPanel [3]
    Left = 0
    Top = 427
    Width = 790
    Height = 89
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 5
      Top = 13
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblDinheiro: TLabel
      Left = 15
      Top = 38
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dinheiro:'
    end
    object lblCartao: TLabel
      Left = 22
      Top = 62
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cart'#227'o:'
    end
    object lblChequePre: TLabel
      Left = 308
      Top = 62
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque-pr'#233':'
    end
    object lblChequeAVista: TLabel
      Left = 293
      Top = 38
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque '#224' vista:'
    end
    object lblOrdemPagamento: TLabel
      Left = 550
      Top = 38
      Width = 106
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ordem de pagamento:'
    end
    object lblFundoDeCaixa: TLabel
      Left = 578
      Top = 62
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fundo de Caixa:'
    end
    object edtDesComp: TEditFocus
      Left = 63
      Top = 10
      Width = 714
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValDin: TEditFocus
      Left = 63
      Top = 34
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
    object edtValCar: TEditFocus
      Left = 63
      Top = 58
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
    object edtValOpg: TEditFocus
      Left = 661
      Top = 34
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValChp: TEditFocus
      Left = 374
      Top = 58
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
    object edtValChq: TEditFocus
      Left = 374
      Top = 34
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
    object edtFundoDeCaixa: TEditFocus
      Left = 661
      Top = 58
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
end
