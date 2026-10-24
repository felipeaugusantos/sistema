inherited frmFechamentoContabil: TfrmFechamentoContabil
  Width = 405
  Height = 307
  BorderIcons = [biSystemMenu]
  Caption = 'Fechamento Cont'#225'bil'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 405
  ExplicitHeight = 307
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 234
    Width = 399
    ExplicitTop = 234
    ExplicitWidth = 399
    inherited FlwBotoes: TFlowPanel
      Width = 1
      Align = alLeft
      TabOrder = 2
      ExplicitWidth = 1
    end
    inherited btnSair: TBitBtnLocked
      Left = 316
      ExplicitLeft = 316
    end
    object btnGerar: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 73
      Height = 22
      Caption = '&Gerar'
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
      OnClick = btnGerarClick
    end
    object btnCheckList: TBitBtnLocked
      Left = 78
      Top = 3
      Width = 83
      Height = 22
      Caption = 'Check List'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnCheckListClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 262
    Width = 399
    ExplicitTop = 262
    ExplicitWidth = 399
    inherited pnlNomeForm: TPanel
      Left = 228
      ExplicitLeft = 228
    end
    inherited pnlInfo: TPanel
      Width = 228
      ExplicitWidth = 228
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 399
    Height = 234
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lbPeriodoExercicio: TLabel
      Left = 5
      Top = 13
      Width = 47
      Height = 14
      Caption = 'Exerc'#237'cio:'
    end
    object Label1: TLabel
      Left = 7
      Top = 29
      Width = 91
      Height = 28
      Caption = 'Empresa de Grava'#231#227'o (Matriz):'
      WordWrap = True
    end
    object edtEmpGrv: TEditFocus
      Tag = 99
      Left = 101
      Top = 34
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtEmpGrvKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpGrv: TEditFocus
      Left = 161
      Top = 34
      Width = 229
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object rdgFormaFechamento: TRadioGroup
      Left = 7
      Top = 65
      Width = 383
      Height = 51
      Caption = 'Efetuar o fechamento de forma:'
      Columns = 3
      Enabled = False
      Items.Strings = (
        'Mensal'
        'Trimestral'
        'Anual')
      TabOrder = 2
      OnClick = rdgFormaFechamentoClick
    end
    object mskExercicio: TMaskEditFocus
      Tag = 99
      Left = 101
      Top = 9
      Width = 57
      Height = 22
      EditMask = '9999;1;_'
      MaxLength = 4
      TabOrder = 0
      Text = '    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object chkGrpPeriodoFechamento: TcxCheckGroup
      Left = 7
      Top = 122
      Caption = 'Per'#237'odo Fechamento'
      Properties.Items = <>
      TabOrder = 3
      Height = 105
      Width = 383
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 316
    Top = 51
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 252
    Top = 51
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 284
    Top = 51
  end
end
