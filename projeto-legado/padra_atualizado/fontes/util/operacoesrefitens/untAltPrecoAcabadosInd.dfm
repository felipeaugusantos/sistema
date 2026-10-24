inherited frmAltPrecoAcabadosInd: TfrmAltPrecoAcabadosInd
  Width = 569
  Height = 429
  Caption = 'Atualiza'#231#227'o de Custos dos Produtos Acabados'
  ExplicitWidth = 569
  ExplicitHeight = 429
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 356
    Width = 563
    TabOrder = 3
    ExplicitTop = 356
    ExplicitWidth = 563
    inherited FlwBotoes: TFlowPanel
      Width = 559
      ExplicitWidth = 559
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 72
        Height = 22
        Caption = '&Gravar'
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 484
      ExplicitLeft = 484
    end
  end
  inherited pnlStatus: TPanel
    Top = 384
    Width = 563
    TabOrder = 4
    ExplicitTop = 384
    ExplicitWidth = 563
    inherited pnlNomeForm: TPanel
      Left = 392
      ExplicitLeft = 392
    end
    inherited pnlInfo: TPanel
      Width = 392
      ExplicitWidth = 392
      object shpMultSel: TShape
        Left = 357
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  object rdgMarPre: TRadioGroup [2]
    Left = 8
    Top = 296
    Width = 546
    Height = 53
    Caption = 'Atualizar '
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Margem'
      'Pre'#231'o de Venda')
    TabOrder = 2
  end
  object gpbGranel: TGroupBox [3]
    Left = 7
    Top = 8
    Width = 546
    Height = 131
    Caption = 'Produto a Granel'
    TabOrder = 0
    object Label7: TLabel
      Left = 15
      Top = 24
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto a Granel:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 31
      Top = 76
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label12: TLabel
      Left = 29
      Top = 50
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
    end
    object Label5: TLabel
      Left = 43
      Top = 102
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object edtCodGra: TEditFocus
      Tag = 99
      Left = 103
      Top = 21
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodGraExit
      OnKeyPress = edtCodGraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesGra: TEditFocus
      Left = 161
      Top = 21
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtDesGruGra: TEditFocus
      Left = 161
      Top = 73
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodDepGra: TEditFocus
      Tag = 99
      Left = 103
      Top = 47
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodDepGraExit
      OnKeyPress = edtCodDepGraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesCodDepGra: TEditFocus
      Left = 161
      Top = 47
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtRefereGra: TEditFocus
      Left = 103
      Top = 99
      Width = 232
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskLinGruGra: TMaskEditFocus
      Tag = 99
      Left = 103
      Top = 73
      Width = 57
      Height = 22
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 3
      Text = ''
      OnExit = mskLinGruGraExit
      OnKeyPress = mskLinGruGraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object gpbAcabado: TGroupBox [4]
    Left = 7
    Top = 153
    Width = 546
    Height = 131
    Caption = 'Produto Acabado'
    TabOrder = 1
    object Label4: TLabel
      Left = 31
      Top = 76
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label6: TLabel
      Left = 29
      Top = 50
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
    end
    object Label8: TLabel
      Left = 43
      Top = 102
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label1: TLabel
      Left = 14
      Top = 24
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto Acabado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDesGruAca: TEditFocus
      Left = 161
      Top = 73
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodDepAca: TEditFocus
      Tag = 99
      Left = 103
      Top = 47
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodDepAcaExit
      OnKeyPress = edtCodDepAcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesCodDepAca: TEditFocus
      Left = 161
      Top = 47
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtRefereAca: TEditFocus
      Left = 103
      Top = 99
      Width = 232
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAca: TEditFocus
      Tag = 99
      Left = 103
      Top = 21
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodAcaExit
      OnKeyPress = edtCodAcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesAca: TEditFocus
      Left = 161
      Top = 21
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskLinGruAca: TMaskEditFocus
      Tag = 99
      Left = 103
      Top = 73
      Width = 57
      Height = 22
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 3
      Text = ''
      OnExit = mskLinGruAcaExit
      OnKeyPress = mskLinGruAcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 306
    Top = 9
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 274
    Top = 9
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 96
  end
end
