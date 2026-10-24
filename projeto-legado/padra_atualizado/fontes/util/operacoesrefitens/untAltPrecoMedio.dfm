inherited frmAltPrecoMedio: TfrmAltPrecoMedio
  Width = 795
  Height = 414
  Caption = 'Altera'#231#227'o de Pre'#231'os M'#233'dio e '#218'ltima Compra por Produto'
  Position = poMainFormCenter
  ExplicitWidth = 795
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 341
    Width = 789
    ExplicitTop = 341
    ExplicitWidth = 789
    inherited btnSair: TBitBtnLocked
      Left = 706
      TabOrder = 1
      ExplicitLeft = 706
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 88
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
      OnClick = btnConfirmaClick
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 789
    Height = 145
    Align = alTop
    Color = 16770261
    TabOrder = 2
    object Label1: TLabel
      Left = 56
      Top = 25
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label7: TLabel
      Left = 36
      Top = 71
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label9: TLabel
      Left = 689
      Top = 70
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label11: TLabel
      Left = 59
      Top = 94
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label2: TLabel
      Left = 33
      Top = 114
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 24
      Top = 49
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 93
      Top = 18
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtLinGru: TEditFocus
      Left = 93
      Top = 40
      Width = 676
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtDesIte: TEditFocus
      Left = 182
      Top = 18
      Width = 587
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtRefere: TEditFocus
      Left = 93
      Top = 62
      Width = 588
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtDesUni: TEditFocus
      Left = 733
      Top = 62
      Width = 36
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtDesMar: TEditFocus
      Left = 93
      Top = 84
      Width = 676
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
    object edtNomFor: TEditFocus
      Left = 93
      Top = 106
      Width = 676
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  object pnlPreMed: TPanel [3]
    Left = 0
    Top = 145
    Width = 789
    Height = 64
    Align = alTop
    ParentColor = True
    TabOrder = 3
    object Label8: TLabel
      Left = 197
      Top = 14
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o M'#233'dio Atual:'
    end
    object Label10: TLabel
      Left = 196
      Top = 37
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo Pre'#231'o M'#233'dio:'
    end
    object edtPreMedAtu: TEditFocus
      Left = 288
      Top = 9
      Width = 88
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPreMedNov: TEditFocus
      Tag = 99
      Left = 288
      Top = 32
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
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
  object pnlPreUlt: TPanel [4]
    Left = 0
    Top = 209
    Width = 789
    Height = 64
    Align = alTop
    ParentColor = True
    TabOrder = 4
    object Label5: TLabel
      Left = 142
      Top = 14
      Width = 144
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de '#218'ltima Compra Atual:'
    end
    object Label6: TLabel
      Left = 141
      Top = 37
      Width = 145
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo Pre'#231'o de '#218'ltima Compra:'
    end
    object edtPreUltAtu: TEditFocus
      Left = 288
      Top = 9
      Width = 88
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtPreUltNov: TEditFocus
      Tag = 99
      Left = 288
      Top = 32
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
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
  object pnlImpUlt: TPanel [5]
    Left = 0
    Top = 273
    Width = 789
    Height = 68
    Align = alClient
    ParentColor = True
    TabOrder = 5
    object Label4: TLabel
      Left = 18
      Top = 14
      Width = 268
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de '#218'ltima Compra com Impostos de Entrada Atual:'
    end
    object Label12: TLabel
      Left = 17
      Top = 37
      Width = 269
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo Pre'#231'o de '#218'ltima Compra com Impostos de Entrada:'
    end
    object edtUltImpAtu: TEditFocus
      Left = 288
      Top = 9
      Width = 88
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtUltImpNov: TEditFocus
      Tag = 99
      Left = 288
      Top = 32
      Width = 88
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
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
  inherited pnlStatus: TPanel
    Top = 369
    Width = 789
    ExplicitTop = 369
    ExplicitWidth = 789
    inherited pnlNomeForm: TPanel
      Left = 618
      ExplicitLeft = 618
    end
    inherited pnlInfo: TPanel
      Width = 618
      ExplicitWidth = 618
    end
  end
end
