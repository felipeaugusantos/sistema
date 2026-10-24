inherited frmFechamentoContabilEstorno: TfrmFechamentoContabilEstorno
  Width = 405
  Height = 307
  Caption = 'Exclus'#227'o de Fechamento Cont'#225'bil'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 405
  ExplicitHeight = 307
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 234
    Width = 399
    TabOrder = 1
    inherited FlwBotoes: TFlowPanel
      Width = 395
      object btnGerar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 73
        Height = 22
        Caption = '&Excluir'
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 319
    end
  end
  inherited pnlStatus: TPanel
    Top = 262
    Width = 399
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 228
    end
    inherited pnlInfo: TPanel
      Width = 228
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
    TabOrder = 0
    ExplicitTop = 8
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
      Caption = 
        'Per'#237'odo Fechamento (Per'#237'odos abaixo marcados = Per'#237'odos Fechados' +
        ')'
      Properties.Items = <>
      Properties.OnEditValueChanged = chkGrpPeriodoFechamentoPropertiesEditValueChanged
      TabOrder = 3
      Height = 105
      Width = 383
    end
  end
end
